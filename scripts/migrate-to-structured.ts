/**
 * One-time migration: parses topics.ts bodyHtml and populates:
 *   - topic_content table (why_it_matters, core_idea, sub_variants,
 *     pattern_triggers, coverage_problems, red_flags)
 *   - problems table (one row per LeetCode problem)
 *
 * Run: npx tsx scripts/migrate-to-structured.ts
 * Requires SUPABASE_SERVICE_ROLE_KEY in .env (not the anon key).
 */

import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';
import { topics } from '../src/data/topics.ts';

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
    .replace(/&middot;/g, '·');

const clean = (html: string) =>
  decodeEntities(stripTags(html)).replace(/\s+/g, ' ').trim();

// ── Section parsers ─────────────────────────────────────────────────────────

function parseWhyItMatters(html: string): string {
  const m = html.match(/<div class="info-box"><strong>[^<]+<\/strong>\s*([\s\S]*?)<\/div>/);
  return m ? clean(m[1]) : '';
}

function parseCoreIdea(html: string): string {
  const m = html.match(/<div class="core-box"><strong>[^<]+<\/strong>\s*([\s\S]*?)<\/div>/);
  return m ? clean(m[1]) : '';
}

function parseSubVariants(html: string): string[] {
  const m = html.match(/<div class="pill-grid">([\s\S]*?)<\/div>/);
  if (!m) return [];
  return [...m[1].matchAll(/<span class="pill">(.*?)<\/span>/g)].map(x =>
    decodeEntities(x[1])
  );
}

const LAYER_CLEAN: Record<string, string> = {
  Foundation: 'Foundation',
  Variants: 'Variants',
  Combo: 'Combo',
  Hard: 'Hard',
  '⚠️Trap': 'Trap',
};

function parseProblems(topicId: number, html: string) {
  const rows: ReturnType<typeof parseProblems> = [];

  for (const tbodyM of html.matchAll(/<tbody>([\s\S]*?)<\/tbody>/g)) {
    for (const rm of tbodyM[1].matchAll(/<tr>([\s\S]*?)<\/tr>/g)) {
      const row = rm[1];
      // Only process problem rows — num-cell is exclusive to the problem table
      const numM = row.match(/<td class="num-cell">(\d+)<\/td>/);
      if (!numM) continue;

      const tds = [...row.matchAll(/<td[^>]*>([\s\S]*?)<\/td>/g)];
      if (tds.length < 8) continue;

      const lcM = row.match(/href="(https:\/\/leetcode\.com[^"]+)"[^>]*>LC (\d+)/);
      const diffM = row.match(/<span class="diff-[emh]">(.*?)<\/span>/);
      const layerRaw = clean(tds[1][1]);

      rows.push({
        topic_id: topicId,
        order_num: +numM[1],
        layer: LAYER_CLEAN[layerRaw] ?? layerRaw,
        lc_url: lcM?.[1] ?? null,
        lc_number: lcM?.[2] ?? null,
        title: clean(tds[3][1]).replace(/^⚠️\s*/, ''),
        difficulty: diffM?.[1] ?? null,
        is_premium: /<span class="prem">/.test(row),
        sub_variant: clean(tds[6][1]) || null,
        key_insight: clean(tds[7][1]) || null,
      });
    }
  }
  return rows;
}

function parsePatternTriggers(html: string) {
  const m = html.match(
    /<div class="sec-title">Pattern Triggers<\/div>[\s\S]*?<tbody>([\s\S]*?)<\/tbody>/
  );
  if (!m) return [];

  return [...m[1].matchAll(/<tr>([\s\S]*?)<\/tr>/g)].flatMap((rm) => {
    const row = rm[1];
    const ph = row.match(/<td class="trigger-phrase">([\s\S]*?)<\/td>/)?.[1];
    const va = row.match(/<td class="trigger-variant">([\s\S]*?)<\/td>/)?.[1];
    const br = row.match(/<td class="trigger-breaks">([\s\S]*?)<\/td>/)?.[1];
    if (!ph || !va || !br) return [];
    return [{ trigger: clean(ph), sub_variant: clean(va), breaks_when: clean(br) }];
  });
}

function parseCoverageProblems(html: string): string[] {
  const m = html.match(/<div class="coverage-box">([\s\S]*?)<\/div>/);
  if (!m) return [];
  return [...m[1].matchAll(/<span class="pill">(LC \d+)<\/span>/g)].map(x => x[1]);
}

// Red flags store the raw inner HTML so <strong> formatting is preserved.
function parseRedFlags(html: string): string[] {
  return [...html.matchAll(/<div class="warn-box">([\s\S]*?)<\/div>/g)].map(m =>
    m[1].trim()
  );
}

// ── Main migration ──────────────────────────────────────────────────────────

async function run() {
  let totalProblems = 0;

  for (const topic of topics) {
    const h = topic.bodyHtml;
    process.stdout.write(`[${String(topic.id).padStart(2)}] ${topic.title}... `);

    const why_it_matters   = parseWhyItMatters(h);
    const core_idea        = parseCoreIdea(h);
    const sub_variants     = parseSubVariants(h);
    const pattern_triggers = parsePatternTriggers(h);
    const coverage_problems = parseCoverageProblems(h);
    const red_flags        = parseRedFlags(h);
    const probs            = parseProblems(topic.id, h);

    const { error: topicErr } = await sb
      .from('topic_content')
      .upsert({ topic_id: topic.id, body_html: h, why_it_matters, core_idea, sub_variants, pattern_triggers, coverage_problems, red_flags });

    if (topicErr) {
      console.error(`\n  ✗ topic_content upsert failed: ${topicErr.message}`);
      continue;
    }

    if (probs.length > 0) {
      // Delete then re-insert so the script is idempotent.
      await sb.from('problems').delete().eq('topic_id', topic.id);
      const { error: probErr } = await sb.from('problems').insert(probs);
      if (probErr) {
        console.error(`\n  ✗ problems insert failed: ${probErr.message}`);
      } else {
        totalProblems += probs.length;
        console.log(`${probs.length} problems ✓`);
      }
    } else {
      console.log('no problems found');
    }
  }

  console.log(`\nMigration complete. ${totalProblems} total problems inserted.`);
}

run().catch((err) => { console.error(err); process.exit(1); });
