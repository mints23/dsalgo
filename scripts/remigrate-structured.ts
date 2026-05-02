/**
 * Robust re-migration: reads body_html directly from the `topics` table
 * in Supabase and populates `topic_content` + `problems`.
 *
 * Fixes over the original migrate-to-structured.ts:
 *   - Auto-detects 8-col vs 9-col (and variants) problem tables via <thead>
 *   - Handles LC link embedded in Problem cell (9-col format)
 *   - Handles numbered sub-variants in info-box (not just pill-grid)
 *   - Handles "Core Invariant" renamed sections
 *   - Properly matches nested divs (doesn't stop at first </div>)
 *   - Skips non-problem tables (Complexity Staircase, etc.)
 *
 * Run:  npx tsx scripts/remigrate-structured.ts
 * Requires SUPABASE_SERVICE_ROLE_KEY in .env
 */

import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';

const sb = createClient(
  process.env.PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!,
  { auth: { persistSession: false } }
);

// ── Text utilities ──────────────────────────────────────────────────────────

const stripTags = (s: string) => s.replace(/<[^>]*>/g, '');

const decodeEntities = (s: string) =>
  s
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&le;/g, '≤')
    .replace(/&ge;/g, '≥')
    .replace(/&ne;/g, '≠')
    .replace(/&nbsp;/g, ' ')
    .replace(/&middot;/g, '·')
    .replace(/&#96;/g, '`')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&times;/g, '×')
    .replace(/&minus;/g, '−')
    .replace(/&rarr;/g, '→')
    .replace(/&larr;/g, '←');

const clean = (html: string) =>
  decodeEntities(stripTags(html)).replace(/\s+/g, ' ').trim();

// ── Balanced div extraction ─────────────────────────────────────────────────
// Finds the full inner HTML of a div, correctly handling nested divs.

function extractDivContent(html: string, className: string): string | null {
  const startTag = `<div class="${className}"`;
  const startIdx = html.indexOf(startTag);
  if (startIdx === -1) return null;

  // Find the closing > of the opening tag
  const openEnd = html.indexOf('>', startIdx);
  if (openEnd === -1) return null;
  const afterOpen = openEnd + 1;

  const tokenRe = /<\/div>|<div\b[^>]*>/g;
  tokenRe.lastIndex = afterOpen;

  let depth = 1;
  let m: RegExpExecArray | null;
  while ((m = tokenRe.exec(html))) {
    if (m[0].startsWith('<div')) depth++;
    else depth--;
    if (depth === 0) return html.slice(afterOpen, m.index);
  }
  return null;
}

// Extract ALL matching divs of a given class (for multiple warn-box, info-box, etc.)
function extractAllDivContents(html: string, className: string): string[] {
  const results: string[] = [];
  const startTag = `<div class="${className}"`;
  let searchFrom = 0;

  while (true) {
    const startIdx = html.indexOf(startTag, searchFrom);
    if (startIdx === -1) break;

    const openEnd = html.indexOf('>', startIdx);
    if (openEnd === -1) break;
    const afterOpen = openEnd + 1;

    const tokenRe = /<\/div>|<div\b[^>]*>/g;
    tokenRe.lastIndex = afterOpen;

    let depth = 1;
    let m: RegExpExecArray | null;
    while ((m = tokenRe.exec(html))) {
      if (m[0].startsWith('<div')) depth++;
      else depth--;
      if (depth === 0) {
        results.push(html.slice(afterOpen, m.index));
        searchFrom = m.index + m[0].length;
        break;
      }
    }
    if (depth !== 0) break; // malformed, stop
  }
  return results;
}

// ── Section parsers ─────────────────────────────────────────────────────────

function parseWhyItMatters(html: string): string {
  // First info-box that starts with "Why It Matters" or "Why This Topic Matters"
  const m = html.match(/<div class="info-box"[^>]*>\s*<strong>(?:Why It Matters|Why This Topic Matters)[^<]*<\/strong>\s*([\s\S]*?)$/);
  if (!m) return '';

  // Get the full balanced content of this div
  const infoBoxes = extractAllDivContents(html, 'info-box');
  for (const box of infoBoxes) {
    if (/Why (?:It|This Topic) Matters/.test(box)) {
      const after = box.replace(/<strong>[^<]*<\/strong>\s*/, '');
      return clean(after);
    }
  }
  return '';
}

function parseCoreIdea(html: string): string {
  // Match core-box content — may be titled "Core Idea", "Core Invariant", etc.
  const coreContent = extractDivContent(html, 'core-box');
  if (!coreContent) return '';

  // Strip the first <strong>...</strong> label
  const stripped = coreContent.replace(/^\s*<strong>[^<]*<\/strong>\s*/, '');
  return clean(stripped);
}

function parseSubVariants(html: string): string[] {
  // Method 1: pill-grid with <span class="pill">
  const pillContent = extractDivContent(html, 'pill-grid');
  if (pillContent) {
    const pills = [...pillContent.matchAll(/<span class="pill">([\s\S]*?)<\/span>/g)]
      .map(x => decodeEntities(stripTags(x[1])).trim())
      .filter(Boolean);
    if (pills.length > 0) return pills;
  }

  // Method 2: Numbered sub-variants in info-box after "Sub-Variants" sec-title
  const svSectionMatch = html.match(
    /<div class="sec-title">Sub-Variants[^<]*<\/div>\s*<div class="info-box"/
  );
  if (svSectionMatch) {
    // Find the info-box that follows the Sub-Variants sec-title
    const afterTitle = html.indexOf(svSectionMatch[0]);
    if (afterTitle !== -1) {
      const searchStart = afterTitle + svSectionMatch[0].length - '<div class="info-box"'.length;
      const remaining = html.slice(searchStart);
      const content = extractDivContent(remaining, 'info-box');
      if (content) {
        // Extract numbered items: <strong>1. Name</strong>
        return [...content.matchAll(/<strong>\d+\.\s*(.*?)<\/strong>/g)]
          .map(m => decodeEntities(stripTags(m[1])).trim())
          .filter(Boolean);
      }
    }
  }

  return [];
}

// ── Problem table detection & parsing ────────────────────────────────────────

type ProblemRow = {
  topic_id: number;
  order_num: number;
  layer: string;
  lc_number: string | null;
  lc_url: string | null;
  title: string;
  difficulty: string | null;
  is_premium: boolean;
  sub_variant: string | null;
  key_insight: string | null;
};

const LAYER_CLEAN: Record<string, string> = {
  Foundation: 'Foundation',
  Variants: 'Variants',
  Combo: 'Combo',
  Hard: 'Hard',
  '⚠️Trap': 'Trap',
  Trap: 'Trap',
  // Numeric layer values used in Knapsack/DP topics
  '1': 'Foundation',
  '2': 'Variants',
  '3': 'Combo',
  '4': 'Hard',
  '5': 'Hard',
  '5 ⚠️': 'Trap',
};

/**
 * Detect table format from the <thead> row and return column indices.
 * Known formats:
 *   A: #, Layer, Link, Problem, Diff, P, Sub-Variant, Key Insight                          (8 cols)
 *   B: #, Layer, Stage, Source, Problem, Diff, P, Sub-Variant/New Idea, Key Insight         (9 cols)
 *   C: #, Layer, Stage, Problem, Diff, Prem, Sub-Variant, Key Insight                       (8 cols, no link)
 *   D: #, Layer, Stage, Link, Problem, Diff, P, Sub-Variant, New Idea Added, Key Insight    (10 cols)
 *   T: #, Link, Problem, Diff, Why It's a Trap, Correct Approach                            (6 cols, trap)
 */
interface ColMap {
  layerIdx: number | null;
  titleIdx: number;
  diffIdx: number;
  premIdx: number | null;
  variantIdx: number | null;
  insightIdx: number | null;
  linkIdx: number | null;     // separate link column
  titleHasLink: boolean;      // link embedded in title cell
  isTrapTable: boolean;       // trap-format table
  trapReasonIdx: number | null;
  trapFixIdx: number | null;
}

function detectColumns(thead: string): ColMap | null {
  const headers = [...thead.matchAll(/<th[^>]*>([\s\S]*?)<\/th>/g)].map(m =>
    clean(m[1]).toLowerCase()
  );

  if (headers.length < 2) return null;

  const idxOf = (pat: string) => headers.findIndex(h => h.includes(pat));
  const hasStage  = idxOf('stage') >= 0;
  const hasSource = idxOf('source') >= 0;
  const hasLink   = idxOf('link') >= 0;
  const hasLayer  = idxOf('layer') >= 0;
  const hasTrap   = idxOf('trap') >= 0 || idxOf('why it') >= 0 || idxOf('symptom') >= 0;
  const hasNewIdea = idxOf('new idea') >= 0;
  const hasProblem = idxOf('problem') >= 0;
  const hasInsight = idxOf('insight') >= 0;

  // Format E (3-col compact): #, Problem, Insight — link+diff embedded in Problem cell
  if (headers.length <= 3 && hasProblem && hasInsight) {
    return {
      layerIdx: null, titleIdx: idxOf('problem'), diffIdx: -1, premIdx: null,
      variantIdx: null, insightIdx: idxOf('insight'),
      linkIdx: null, titleHasLink: true,
      isTrapTable: false, trapReasonIdx: null, trapFixIdx: null,
    };
  }

  // Format F (10-col, S.No header): S.No, Layer, Stage, Source, # / Name, Difficulty, Premium?, Sub-Variant, New Idea Added, Key Insight
  const hasSNo    = idxOf('s.no') >= 0 || idxOf('s. no') >= 0;
  const hasName   = idxOf('# / name') >= 0 || idxOf('name') >= 0;
  const hasDiff   = idxOf('difficulty') >= 0 || idxOf('diff') >= 0;
  if ((hasSNo || (headers[0] === '#')) && hasName && hasNewIdea) {
    const nameI = headers.findIndex(h => h.includes('# / name') || h.includes('name'));
    const diffI = headers.findIndex(h => h.includes('difficulty') || h === 'diff');
    const premI = headers.findIndex(h => h.includes('premium'));
    const varI  = headers.findIndex(h => h.includes('sub-variant'));
    const insI  = headers.findIndex(h => h.includes('key insight'));
    return {
      layerIdx: idxOf('layer') >= 0 ? idxOf('layer') : null,
      titleIdx: nameI >= 0 ? nameI : 4,
      diffIdx: diffI >= 0 ? diffI : -1,
      premIdx: premI >= 0 ? premI : null,
      variantIdx: varI >= 0 ? varI : null,
      insightIdx: insI >= 0 ? insI : null,
      linkIdx: null, titleHasLink: true,
      isTrapTable: false, trapReasonIdx: null, trapFixIdx: null,
    };
  }

  // Format T2 (4-col trap): #, Trap, Symptom, Fix
  if (hasTrap && headers.length <= 4 && !hasLayer) {
    return {
      layerIdx: null, titleIdx: 1, diffIdx: -1, premIdx: null,
      variantIdx: null, insightIdx: null,
      linkIdx: null, titleHasLink: false,
      isTrapTable: true, trapReasonIdx: 2, trapFixIdx: 3,
    };
  }

  // Format T (6-col trap): #, Link, Problem, Diff, Why It's a Trap, Correct Approach
  if (hasTrap && !hasLayer && headers.length >= 5) {
    return {
      layerIdx: null, titleIdx: 2, diffIdx: 3, premIdx: null,
      variantIdx: null, insightIdx: null,
      linkIdx: 1, titleHasLink: false,
      isTrapTable: true, trapReasonIdx: 4, trapFixIdx: 5,
    };
  }

  // Format D (10-col): #, Layer, Stage, Link, Problem, Diff, P, Sub-Variant, New Idea Added, Key Insight
  if (hasStage && hasLink && hasNewIdea) {
    const linkI = idxOf('link');
    return {
      layerIdx: 1, titleIdx: linkI + 1, diffIdx: linkI + 2, premIdx: linkI + 3,
      variantIdx: linkI + 4, insightIdx: headers.length - 1,
      linkIdx: linkI, titleHasLink: false,
      isTrapTable: false, trapReasonIdx: null, trapFixIdx: null,
    };
  }

  // Format B (9-col): #, Layer, Stage, Source, Problem, Diff, P, Sub-Variant, Key Insight
  if (hasStage && hasSource) {
    return {
      layerIdx: 1, titleIdx: 4, diffIdx: 5, premIdx: 6,
      variantIdx: 7, insightIdx: 8, linkIdx: null, titleHasLink: true,
      isTrapTable: false, trapReasonIdx: null, trapFixIdx: null,
    };
  }

  // Format A (8-col with Link): #, Layer, Link, Problem, Diff, P, Sub-Variant, Key Insight
  if (hasLink && !hasStage) {
    const linkI = idxOf('link');
    return {
      layerIdx: 1, titleIdx: linkI + 1, diffIdx: linkI + 2, premIdx: linkI + 3,
      variantIdx: linkI + 4, insightIdx: linkI + 5,
      linkIdx: linkI, titleHasLink: false,
      isTrapTable: false, trapReasonIdx: null, trapFixIdx: null,
    };
  }

  // Format C (8-col, Stage but no Link): #, Layer, Stage, Problem, Diff, Prem, Sub-Variant, Key Insight
  // Guard: require "Problem" or "Diff" to exclude Sub-Variants tables that also have Stage
  if (hasStage && !hasLink && !hasSource && (hasProblem || hasDiff)) {
    return {
      layerIdx: 1, titleIdx: 3, diffIdx: 4, premIdx: 5,
      variantIdx: 6, insightIdx: 7, linkIdx: null, titleHasLink: true,
      isTrapTable: false, trapReasonIdx: null, trapFixIdx: null,
    };
  }

  // Format G (8-col, Source but no Link/Stage): #, Layer, Source, Problem, Diff, P, Sub-Variant, Key Insight
  // Source column has plain text like "LC 1514" or "🔧 Custom"; link is inside Problem cell
  if (hasSource && !hasStage && !hasLink && (hasProblem || hasDiff)) {
    const probI = idxOf('problem') >= 0 ? idxOf('problem') : 3;
    const diffI = idxOf('diff') >= 0 ? idxOf('diff') : (hasDiff ? headers.findIndex(h => h.includes('diff')) : probI + 1);
    return {
      layerIdx: 1, titleIdx: probI, diffIdx: diffI, premIdx: diffI + 1,
      variantIdx: diffI + 2, insightIdx: diffI + 3,
      linkIdx: null, titleHasLink: true,
      isTrapTable: false, trapReasonIdx: null, trapFixIdx: null,
    };
  }

  // Fallback: try format A layout if enough columns
  if (headers.length >= 8) {
    const linkI = hasLink ? idxOf('link') : null;
    return {
      layerIdx: 1, titleIdx: 3, diffIdx: 4, premIdx: 5,
      variantIdx: 6, insightIdx: 7, linkIdx: linkI ?? null, titleHasLink: linkI === null,
      isTrapTable: false, trapReasonIdx: null, trapFixIdx: null,
    };
  }

  return null;
}

function parseProblems(topicId: number, html: string): ProblemRow[] {
  const allRows: ProblemRow[] = [];

  // Find all tables that have num-cell rows (problem tables, not complexity tables)
  for (const tableMatch of html.matchAll(/<table[\s\S]*?<\/table>/g)) {
    const tableHtml = tableMatch[0];

    // Get the thead to detect format — some tables use <tr><th>...</th></tr> without <thead>
    const theadM = tableHtml.match(/<thead>([\s\S]*?)<\/thead>/);
    // Fallback: first <tr> with <th> elements
    const headerRow = theadM?.[1] ?? tableHtml.match(/<tr>\s*<th[\s\S]*?<\/tr>/)?.[0];
    if (!headerRow) continue;

    const cols = detectColumns(headerRow);
    if (!cols) continue;

    // For tables without num-cell, only process if we detected a known problem format
    const hasNumCell = tableHtml.includes('num-cell');
    if (!hasNumCell && cols.diffIdx === -1 && !cols.isTrapTable && cols.variantIdx === null && cols.insightIdx === null) continue;

    // Parse rows — from <tbody> if present, or directly from all <tr> in the table
    const tbodyM2 = tableHtml.match(/<tbody>([\s\S]*?)<\/tbody>/);
    const rowSource = tbodyM2?.[1] ?? tableHtml;
    for (const rm of rowSource.matchAll(/<tr>([\s\S]*?)<\/tr>/g)) {
      const row = rm[1];
      // Skip header rows and colspan separator rows (e.g., CLIFF WARNING)
      if (row.includes('<th') || row.includes('colspan')) continue;
      // Match num-cell with optional extra classes, OR plain <td> with a number as first cell
      let numM = row.match(/<td class="num-cell[^"]*">([A-Za-z]?\d+)<\/td>/);
      if (!numM && !hasNumCell) {
        // Fallback: first <td> containing just a number (plain format)
        numM = row.match(/^[\s\S]*?<td[^>]*>\s*(\d+)\s*<\/td>/);
      }
      if (!numM) continue;

      const tds = [...row.matchAll(/<td[^>]*>([\s\S]*?)<\/td>/g)];
      // Minimum columns needed varies by format
      const reqIndices = [cols.titleIdx].filter((v): v is number => v !== null && v >= 0);
      const minCols = Math.max(1, ...reqIndices.map(i => i + 1));
      if (tds.length < minCols) continue;

      // Extract LC/CF link — either from separate Link column or embedded in title/row
      let lcUrl: string | null = null;
      let lcNumber: string | null = null;

      // Helper: extract link from a cell's HTML
      const extractLink = (cellHtml: string) => {
        // LeetCode link with number right after tag: <a href="...">LC 1234</a> or <a href="...">1234</a>
        const lcM = cellHtml.match(/href="(https:\/\/leetcode\.com[^"]+)"[^>]*>(?:LC )?(\d+)/);
        if (lcM) return { url: lcM[1], num: lcM[2] };
        // <a ...>LC 1234</a> with text before the number
        const lcM2 = cellHtml.match(/href="(https:\/\/leetcode\.com[^"]+)"[^>]*>[^<]*LC (\d+)/);
        if (lcM2) return { url: lcM2[1], num: lcM2[2] };
        // <a href="..."><span>Problem Name</span></a> — link wrapping inner elements (get URL only)
        const lcUrlOnly = cellHtml.match(/href="(https:\/\/leetcode\.com[^"]+)"/);
        if (lcUrlOnly) return { url: lcUrlOnly[1], num: null as string | null };
        // Codeforces link
        const cfM = cellHtml.match(/href="(https:\/\/codeforces\.com[^"]+)"[^>]*>(CF [^<]+)/);
        if (cfM) return { url: cfM[1], num: cfM[2] };
        return null;
      };

      let title: string;
      const titleCell = tds[cols.titleIdx]?.[1] ?? '';

      if (cols.linkIdx !== null && tds[cols.linkIdx]) {
        // Separate link column
        const link = extractLink(tds[cols.linkIdx][1]);
        lcUrl = link?.url ?? null;
        lcNumber = link?.num ?? null;
        title = clean(titleCell);
      } else {
        // Link might be in the title cell (formats B/C/E) or anywhere in the row
        const link = extractLink(titleCell) ?? extractLink(row);
        lcUrl = link?.url ?? null;
        lcNumber = link?.num ?? null;
        // If URL found but no LC number, try to find "LC XXXX" text anywhere in the row
        if (lcUrl && !lcNumber) {
          const lcTextM = row.match(/>\s*LC\s+(\d+)\s*</);
          if (lcTextM) lcNumber = lcTextM[1];
        }
        title = clean(titleCell);
        // Remove "LC XXX " or "XXX – " prefix from title if present
        if (lcNumber) {
          title = title.replace(new RegExp(`^LC\\s+${lcNumber.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\s*`), '');
          title = title.replace(new RegExp(`^${lcNumber.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\s*[–—-]\\s*`), '');
        }
      }

      // Clean title: remove ⚠️ / 🔧 prefixes and ✅ suffix
      title = title.replace(/^[⚠️🔧]+\s*/u, '').replace(/\s*✅\s*$/, '').trim();

      // Layer — trap tables may not have a layer column; compact tables infer from td class
      let layer: string;
      if (cols.isTrapTable) {
        layer = 'Trap';
      } else if (cols.layerIdx !== null && tds[cols.layerIdx]) {
        const layerRaw = clean(tds[cols.layerIdx][1]);
        layer = LAYER_CLEAN[layerRaw] ?? layerRaw;
      } else {
        // Infer layer from num-cell td class: "num-cell l1"→Foundation, l2→Variants, l3→Combo, l4→Hard
        const layerClassM = row.match(/class="num-cell\s+(l\d)"/);
        const layerMap: Record<string, string> = { l1: 'Foundation', l2: 'Variants', l3: 'Combo', l4: 'Hard' };
        layer = layerClassM ? (layerMap[layerClassM[1]] ?? 'Unknown') : 'Unknown';
      }

      // Difficulty — from dedicated column, diff-X span, or plain text
      let difficulty: string | null = null;
      if (cols.diffIdx >= 0 && tds[cols.diffIdx]) {
        const diffCell = tds[cols.diffIdx][1];
        // Try span first
        const diffM2 = diffCell.match(/<span class="diff-[emh]">(.*?)<\/span>/);
        difficulty = diffM2?.[1] ?? null;
        // Fallback: plain text "Easy"/"Medium"/"Hard"
        if (!difficulty) {
          const plainDiff = clean(diffCell).trim();
          if (/^(Easy|Medium|Hard)$/i.test(plainDiff)) difficulty = plainDiff;
        }
      }
      if (!difficulty) {
        // Try to find diff-X span anywhere in the row
        const rowDiffM = row.match(/<span class="diff-([emh])">(.*?)<\/span>/);
        difficulty = rowDiffM?.[2] ?? null;
      }
      if (!difficulty) {
        // Try plain text "Easy"/"Medium"/"Hard" anywhere in row cells
        const plainM = row.match(/<span class="diff-[emh]">(Easy|Medium|Hard)<\/span>/i)
                    ?? row.match(/<td[^>]*>\s*(Easy|Medium|Hard)\s*<\/td>/i);
        difficulty = plainM?.[1] ?? null;
      }

      // Premium — from dedicated column or from row
      const premCell = cols.premIdx !== null ? (tds[cols.premIdx]?.[1] ?? '') : '';
      const isPremium = /<span class="prem">/.test(premCell) || premCell.includes('✅') || row.includes('✅ Premium');

      // Sub-variant / trap reason
      let subVariant: string | null = null;
      let keyInsight: string | null = null;

      if (cols.isTrapTable) {
        // For trap tables: use trap description as sub_variant and fix as key_insight
        subVariant = cols.trapReasonIdx !== null ? clean(tds[cols.trapReasonIdx]?.[1] ?? '') || null : null;
        keyInsight = cols.trapFixIdx !== null ? clean(tds[cols.trapFixIdx]?.[1] ?? '') || null : null;
      } else {
        const variantCell = cols.variantIdx !== null ? (tds[cols.variantIdx]?.[1] ?? '') : '';
        subVariant = clean(variantCell) || null;
        const insightCell = cols.insightIdx !== null ? (tds[cols.insightIdx]?.[1] ?? '') : '';
        keyInsight = clean(insightCell) || null;
      }

      allRows.push({
        topic_id: topicId,
        order_num: 0, // will be re-sequenced below
        layer,
        lc_number: lcNumber,
        lc_url: lcUrl,
        title,
        difficulty,
        is_premium: isPremium,
        sub_variant: subVariant,
        key_insight: keyInsight,
      });
    }
  }

  // Re-sequence order_num as 1, 2, 3, ... across all sections
  allRows.forEach((row, i) => { row.order_num = i + 1; });

  return allRows;
}

// ── Pattern triggers ────────────────────────────────────────────────────────

function parsePatternTriggers(html: string) {
  // Match the table after "Pattern Triggers" or "Pattern Recognition Triggers"
  const m = html.match(
    /<div class="sec-title">Pattern (?:Recognition )?Triggers<\/div>[\s\S]*?<table[\s\S]*?>([\s\S]*?)<\/table>/
  );
  if (!m) return [];

  // Extract rows from <tbody> if present, otherwise from the whole table content
  const tbodyM = m[1].match(/<tbody>([\s\S]*?)<\/tbody>/);
  const rowSource = tbodyM?.[1] ?? m[1];

  return [...rowSource.matchAll(/<tr>([\s\S]*?)<\/tr>/g)].flatMap((rm) => {
    const row = rm[1];
    // Skip header rows
    if (row.includes('<th')) return [];
    const tds = [...row.matchAll(/<td[^>]*>([\s\S]*?)<\/td>/g)];
    if (tds.length < 3) return [];
    // Try class-based extraction first, then fall back to positional
    const ph = row.match(/<td class="trigger-phrase">([\s\S]*?)<\/td>/)?.[1]
            ?? tds[0]?.[1];
    const va = row.match(/<td class="trigger-variant">([\s\S]*?)<\/td>/)?.[1]
            ?? tds[1]?.[1];
    const br = tds[2]?.[1];
    if (!ph || !va || !br) return [];
    return [{ trigger: clean(ph), sub_variant: clean(va), breaks_when: clean(br) }];
  });
}

// ── Coverage problems ───────────────────────────────────────────────────────

function parseCoverageProblems(html: string): string[] {
  const content = extractDivContent(html, 'coverage-box');
  if (!content) return [];
  return [...content.matchAll(/<span class="pill">(LC \d+)<\/span>/g)].map(x => x[1]);
}

// ── Red flags ───────────────────────────────────────────────────────────────

function parseRedFlags(html: string): string[] {
  return extractAllDivContents(html, 'warn-box').map(c => c.trim());
}

// ── Main migration ──────────────────────────────────────────────────────────

async function run() {
  console.log('Fetching topics from DB...');
  const { data: topics, error: fetchErr } = await sb
    .from('topics')
    .select('id, title, body_html')
    .order('id');

  if (fetchErr || !topics) {
    console.error('Failed to fetch topics:', fetchErr?.message);
    process.exit(1);
  }

  console.log(`Found ${topics.length} topics.\n`);

  let totalProblems = 0;
  let topicContentCount = 0;
  const failures: string[] = [];

  for (const topic of topics) {
    const h: string = topic.body_html ?? '';
    const label = `[${String(topic.id).padStart(2)}] ${topic.title}`;

    if (!h.trim()) {
      console.log(`${label} — empty body_html, skipping`);
      continue;
    }

    process.stdout.write(`${label}... `);

    const why_it_matters   = parseWhyItMatters(h);
    const core_idea        = parseCoreIdea(h);
    const sub_variants     = parseSubVariants(h);
    const pattern_triggers = parsePatternTriggers(h);
    const coverage_problems = parseCoverageProblems(h);
    const red_flags        = parseRedFlags(h);
    const probs            = parseProblems(topic.id, h);

    // Log parse results
    const parts = [
      why_it_matters ? '✓why' : '✗why',
      core_idea ? '✓core' : '✗core',
      `${sub_variants.length}sv`,
      `${probs.length}probs`,
      `${pattern_triggers.length}trig`,
      `${coverage_problems.length}cov`,
      `${red_flags.length}flags`,
    ];

    // Upsert topic_content (body_html may not exist in actual DB schema)
    const { error: topicErr } = await sb
      .from('topic_content')
      .upsert({
        topic_id: topic.id,
        why_it_matters,
        core_idea,
        sub_variants,
        pattern_triggers,
        coverage_problems,
        red_flags,
      });

    if (topicErr) {
      const msg = `${label}: topic_content upsert failed — ${topicErr.message}`;
      console.error(`\n  ✗ ${msg}`);
      failures.push(msg);
      continue;
    }
    topicContentCount++;

    // Re-insert problems
    if (probs.length > 0) {
      await sb.from('problems').delete().eq('topic_id', topic.id);
      const { error: probErr } = await sb.from('problems').insert(probs);
      if (probErr) {
        const msg = `${label}: problems insert failed — ${probErr.message}`;
        console.error(`\n  ✗ ${msg}`);
        failures.push(msg);
      } else {
        totalProblems += probs.length;
      }
    }

    console.log(parts.join(' | '));
  }

  console.log('\n══════════════════════════════════════');
  console.log(`topic_content upserted: ${topicContentCount}`);
  console.log(`problems inserted:      ${totalProblems}`);
  if (failures.length > 0) {
    console.log(`\nFailures (${failures.length}):`);
    failures.forEach(f => console.log(`  • ${f}`));
  }
  console.log('══════════════════════════════════════');
}

run().catch((err) => { console.error(err); process.exit(1); });
