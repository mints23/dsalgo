/**
 * Fill missing time/space on Key Insight playback using LC map, keyword inference,
 * common-pattern hints, and O(...) snippets in the table insight text.
 */
import type { Solution } from './solution-model';
import { LC_COMPREHENSIVE, inferFromKeywords } from './algorithm-walkthroughs';

function isMissing(s: unknown): boolean {
  const t = String(s ?? '').trim();
  return !t || t === '—' || t === '–' || t === '-' || /^n\/?a$/i.test(t);
}

function normalizeBigO(s: string): string {
  return s.replace(/\s+/g, '').replace(/O\(/i, 'O(');
}

/** Pull Time … O(...) / Space … O(...) or any O(...) mentions from prose. */
function parseBigOFromProse(text: string): { time?: string; space?: string } {
  if (!text.trim()) return {};
  const out: { time?: string; space?: string } = {};
  const ti = /\btime\b[^.!?\n]{0,140}?(\bO\s*\([^)]+\))/i.exec(text);
  const sp = /\bspace\b[^.!?\n]{0,160}?(\bO\s*\([^)]+\))/i.exec(text);
  if (ti) out.time = normalizeBigO(ti[1]);
  if (sp) out.space = normalizeBigO(sp[1]);
  if (out.time && out.space) return out;
  const all = [...text.matchAll(/\bO\s*\([^)]+\)/gi)].map((m) => normalizeBigO(m[0]));
  const uniq: string[] = [];
  for (const x of all) if (!uniq.includes(x)) uniq.push(x);
  if (!out.time && uniq[0]) out.time = uniq[0];
  if (!out.space) {
    if (uniq[1]) out.space = uniq[1];
    else if (uniq[0] && /\bspace\b|\bmemory\b|\baux(iliary)?\b/i.test(text)) out.space = uniq[0];
  }
  return out;
}

/** Curated hints when we have no LC walkthrough row but the problem name is recognizable. */
const EXTRA_COMPLEXITY_HINTS: { re: RegExp; time: string; space: string }[] = [
  { re: /sort colors|dutch national flag|three[- ]way partition/i, time: 'O(n)', space: 'O(1)' },
  { re: /merge intervals/i, time: 'O(n log n)', space: 'O(1) or O(n)' },
  { re: /insert interval/i, time: 'O(n)', space: 'O(n)' },
  { re: /meeting rooms ii|meeting rooms 2/i, time: 'O(n log n)', space: 'O(n)' },
  { re: /meeting rooms\b/i, time: 'O(n log n)', space: 'O(n)' },
  { re: /cyclic sort|find.*missing.*(number|positive)|first missing positive/i, time: 'O(n)', space: 'O(1)' },
  { re: /top k frequent|k most frequent/i, time: 'O(n log k)', space: 'O(n)' },
  { re: /k closest|closest point/i, time: 'O(n log k)', space: 'O(k)' },
  { re: /subarray.*sum.*k|prefix sum.*hash/i, time: 'O(n)', space: 'O(n)' },
  { re: /product of array except self|except self/i, time: 'O(n)', space: 'O(1)' },
  { re: /spiral order|spiral matrix/i, time: 'O(m·n)', space: 'O(1)' },
  { re: /rotate (image|matrix)|rotate the matrix/i, time: 'O(n²)', space: 'O(1)' },
  { re: /word search\b/i, time: 'O(m·n·4^L)', space: 'O(L)' },
];

function extraHint(title: string, insight: string): { time: string; space: string } | null {
  const blob = `${title} ${insight}`;
  for (const { re, time, space } of EXTRA_COMPLEXITY_HINTS) {
    if (re.test(blob)) return { time, space };
  }
  return null;
}

export function resolvePlaybackComplexity(
  lcNumber: string,
  title: string,
  insight: string,
  sol: Pick<Solution, 'time' | 'space'> | null | undefined
): { time: string; space: string } {
  let time = String(sol?.time ?? '').trim();
  let space = String(sol?.space ?? '').trim();

  const fill = (t: string, sp: string) => {
    if (isMissing(time) && !isMissing(t)) time = t.trim();
    if (isMissing(space) && !isMissing(sp)) space = sp.trim();
  };

  const lc = String(lcNumber ?? '').trim();
  if (lc && LC_COMPREHENSIVE[lc]) {
    const ref = LC_COMPREHENSIVE[lc];
    fill(ref.time, ref.space);
  }

  if (isMissing(time) || isMissing(space)) {
    const inferred = inferFromKeywords(title, insight);
    if (inferred) fill(inferred.time, inferred.space);
  }

  if (isMissing(time) || isMissing(space)) {
    const ex = extraHint(title, insight);
    if (ex) fill(ex.time, ex.space);
  }

  if (isMissing(time) || isMissing(space)) {
    const parsed = parseBigOFromProse(`${title}\n${insight}`);
    if (parsed.time) fill(parsed.time, '');
    if (parsed.space) fill('', parsed.space);
  }

  if (isMissing(time)) time = '—';
  if (isMissing(space)) space = '—';
  return { time, space };
}
