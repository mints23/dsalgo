import fs from 'node:fs';
import path from 'node:path';

const repoRoot = process.cwd();
const indexPath = path.join(repoRoot, 'src', 'pages', 'index.astro');
const outPath = path.join(repoRoot, 'src', 'data', 'topics.ts');

function unescapeHtml(s) {
  return s
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/&nbsp;/g, ' ');
}

function extractNav(indexText) {
  const nav = [];
  const sectionRe = /<div class="nav-section">([^<]+)<\/div>/g;
  const buttonRe =
    /<button class="nav-item" data-topic-id="(\d+)"><span class="num">([^<]+)<\/span>([^<]+)<span class="tier-dot" style="background:(#[0-9a-fA-F]{6})"><\/span><\/button>/g;

  const sectionPositions = [];
  for (const m of indexText.matchAll(sectionRe)) {
    sectionPositions.push({ idx: m.index, name: unescapeHtml(m[1].trim()) });
  }
  sectionPositions.sort((a, b) => a.idx - b.idx);

  for (const m of indexText.matchAll(buttonRe)) {
    const idx = m.index ?? 0;
    const id = Number(m[1]);
    const displayNumber = m[2].trim();
    const navLabel = unescapeHtml(m[3].trim());
    const navTierDotColor = m[4];
    const section =
      sectionPositions
        .slice()
        .reverse()
        .find((s) => s.idx < idx)?.name ?? 'Unknown';

    nav.push({ id, displayNumber, navLabel, navTierDotColor, navSection: section });
  }

  return nav;
}

function findDivInnerHtml(cardHtml, className) {
  const startIdx = cardHtml.indexOf(`<div class="${className}">`);
  if (startIdx === -1) return null;

  const afterStart = startIdx + `<div class="${className}">`.length;
  const tokenRe = /<\/div>|<div\b[^>]*>/g;
  tokenRe.lastIndex = afterStart;

  let depth = 1;
  let endIdx = -1;
  for (let m = tokenRe.exec(cardHtml); m; m = tokenRe.exec(cardHtml)) {
    if (m[0].startsWith('<div')) depth += 1;
    else depth -= 1;
    if (depth === 0) {
      endIdx = m.index;
      break;
    }
  }
  if (endIdx === -1) return null;
  return cardHtml.slice(afterStart, endIdx);
}

function extractCards(indexText) {
  const cards = [];
  const cardStartRe = /<div class="topic-card" id="tp(\d+)">/g;
  const starts = [...indexText.matchAll(cardStartRe)].map((m) => ({
    id: Number(m[1]),
    idx: m.index ?? 0,
  }));
  for (let i = 0; i < starts.length; i++) {
    const { id, idx } = starts[i];
    const end = i + 1 < starts.length ? starts[i + 1].idx : indexText.indexOf('</div>\n    </div>\n\n    <button class="mob-nav-btn"', idx);
    const cardHtml = indexText.slice(idx, end === -1 ? undefined : end);

    const displayNumber = /<div class="topic-num">([^<]+)<\/div>/.exec(cardHtml)?.[1]?.trim() ?? '';
    const title = /<div class="topic-title">([^<]+)<\/div>/.exec(cardHtml)?.[1]?.trim() ?? '';
    const tierClass = /<span class="tier-badge (tier-T\d)">/.exec(cardHtml)?.[1] ?? 'tier-T1';
    const tierLabel = /<span class="tier-badge tier-T\d">([^<]+)<\/span>/.exec(cardHtml)?.[1]?.trim() ?? '';
    const typeLabel = /<span class="topic-type">([^<]+)<\/span>/.exec(cardHtml)?.[1]?.trim() ?? '';
    const summaryMeta = /<div class="topic-meta">([^<]+)<\/div>/.exec(cardHtml)?.[1]?.trim() ?? '';

    const bodyInner = findDivInnerHtml(cardHtml, 'topic-body') ?? '';
    // Avoid breaking TS template literals: encode literal backticks.
    const bodyHtml = bodyInner.replace(/`/g, '&#96;');

    cards.push({
      id,
      displayNumber,
      title: unescapeHtml(title),
      tierClass,
      tierLabel: unescapeHtml(tierLabel),
      typeLabel: unescapeHtml(typeLabel),
      summaryMeta: unescapeHtml(summaryMeta),
      bodyHtml,
    });
  }
  return cards;
}

function extractTopicMetas(indexText) {
  const metasBlock = /const topicMetas = \{([\s\S]*?)\};/.exec(indexText)?.[1] ?? '';
  const pairs = [...metasBlock.matchAll(/(\d+):\s*'([^']*)'/g)].map((m) => [Number(m[1]), m[2]]);
  return Object.fromEntries(pairs);
}

function buildTopicsTs(topics) {
  const lines = [];
  lines.push("import type { Topic } from './types';");
  lines.push('');
  lines.push('export const topics: Topic[] = [');
  for (const t of topics) {
    lines.push('  {');
    lines.push(`    id: ${t.id},`);
    lines.push(`    displayNumber: ${JSON.stringify(t.displayNumber)},`);
    lines.push(`    showInSidebar: ${t.showInSidebar ? 'true' : 'false'},`);
    lines.push(`    navSection: ${JSON.stringify(t.navSection)},`);
    lines.push(`    navLabel: ${JSON.stringify(t.navLabel)},`);
    lines.push(`    navTierDotColor: ${JSON.stringify(t.navTierDotColor)},`);
    lines.push(`    title: ${JSON.stringify(t.title)},`);
    lines.push(`    tier: { code: ${JSON.stringify(t.tierCode)}, label: ${JSON.stringify(t.tierLabel)} },`);
    lines.push(`    typeLabel: ${JSON.stringify(t.typeLabel)},`);
    lines.push(`    summaryMeta: ${JSON.stringify(t.summaryMeta)},`);
    lines.push(`    topbarMeta: ${JSON.stringify(t.topbarMeta)},`);
    lines.push('    bodyHtml: String.raw`');
    lines.push(t.bodyHtml.trimEnd());
    lines.push('`,');
    lines.push('  },');
  }
  lines.push('];');
  lines.push('');
  return lines.join('\n');
}

function tierCodeFromClass(tierClass) {
  const m = /tier-(T\d)/.exec(tierClass);
  return m?.[1] ?? 'T1';
}

const indexText = fs.readFileSync(indexPath, 'utf8');
const navItems = extractNav(indexText);
const cards = extractCards(indexText);
const topicMetas = extractTopicMetas(indexText);

const navById = new Map(navItems.map((n) => [n.id, n]));
const cardById = new Map(cards.map((c) => [c.id, c]));

const ids = [...new Set([...navById.keys(), ...cardById.keys()])].sort((a, b) => a - b);
const topics = ids.map((id) => {
  const nav = navById.get(id);
  const card = cardById.get(id);
  if (!card) {
    throw new Error(`Missing topic card for id=${id}`);
  }

  const showInSidebar = !!nav;
  const navSection = nav?.navSection ?? (topicMetas[id]?.split(' · ')[0] ?? 'Other');
  const navLabel = nav?.navLabel ?? card.title;
  const navTierDotColor =
    nav?.navTierDotColor ??
    (navSection === 'Dynamic Programming' ? '#006494' : navSection === 'Data Structures' ? '#7a39bb' : '#01696f');

  const topbarMeta = topicMetas[id] ?? `${navSection} · ${card.typeLabel}`;
  return {
    id,
    displayNumber: nav?.displayNumber || card.displayNumber,
    showInSidebar,
    navSection,
    navLabel,
    navTierDotColor,
    title: card.title,
    tierCode: tierCodeFromClass(card.tierClass),
    tierLabel: card.tierLabel,
    typeLabel: card.typeLabel,
    summaryMeta: card.summaryMeta,
    topbarMeta,
    bodyHtml: card.bodyHtml,
  };
});

fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, buildTopicsTs(topics), 'utf8');
console.log(`Wrote ${topics.length} topics -> ${path.relative(repoRoot, outPath)}`);

