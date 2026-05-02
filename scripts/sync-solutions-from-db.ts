/**
 * Pull all problems with lc_number from Supabase and regenerate
 * src/data/solutions.db.generated.ts with typewriter-ready Solution stubs
 * derived from key_insight (split on → or ;).
 *
 * Requires in .env:
 *   PUBLIC_SUPABASE_URL
 *   SUPABASE_SERVICE_ROLE_KEY   (service role bypasses RLS for full export)
 */
import { createClient } from '@supabase/supabase-js';
import * as fs from 'node:fs';
import * as path from 'node:path';
import { fileURLToPath } from 'node:url';
import dotenv from 'dotenv';
import type { Solution, Step } from '../src/data/solution-model.ts';

dotenv.config();

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.join(__dirname, '..');
const outFile = path.join(repoRoot, 'src', 'data', 'solutions.db.generated.ts');

const url = process.env.PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !key) {
  console.error('Missing PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env');
  process.exit(1);
}

const sb = createClient(url, key);

function splitInsight(raw: string): string[] {
  const t = raw.trim();
  if (!t) return [];
  if (t.includes('→')) return t.split('→').map((s) => s.trim()).filter(Boolean);
  if (t.includes(';')) return t.split(';').map((s) => s.trim()).filter(Boolean);
  if (t.length > 120 && t.includes('. ')) {
    const parts = t.split(/(?<=\.)\s+/).map((s) => s.trim()).filter(Boolean);
    if (parts.length > 1) return parts;
  }
  return [t];
}

function shortTitle(s: string, max = 56): string {
  const one = s.replace(/\s+/g, ' ').trim();
  if (one.length <= max) return one;
  return one.slice(0, max - 1) + '…';
}

function noteToCodeLines(note: string): string[] {
  const words = note.replace(/\s+/g, ' ').trim().split(' ');
  const lines: string[] = [];
  let buf = '# ';
  for (const w of words) {
    if (!w) continue;
    if ((buf + w).length > 74) {
      lines.push(buf.trimEnd());
      buf = '# ' + w + ' ';
    } else {
      buf += w + ' ';
    }
  }
  const last = buf.trimEnd();
  if (last !== '#') lines.push(last);
  return lines.length ? lines : ['# (empty insight)'];
}

function insightToSteps(insight: string, title: string): Step[] {
  const parts = splitInsight(insight);
  if (parts.length === 0) {
    return [
      {
        title: 'Approach',
        code: [`# ${title}`, '# Add key_insight in Supabase for step-by-step text.'],
        note: 'No key insight text in the database yet — use the problem statement and editorial.',
      },
    ];
  }
  return parts.map((p, i) => ({
    title: shortTitle(p),
    code: [`# Step ${i + 1}`, ...noteToCodeLines(p)],
    note: p,
  }));
}

function mergeInsight(a: string, b: string): string {
  const x = a.trim();
  const y = b.trim();
  if (!x) return y;
  if (!y) return x;
  if (x.includes(y) || y.includes(x)) return x.length >= y.length ? x : y;
  return `${x}; ${y}`;
}

function rowToApproach(subVariant: string | null, layer: string | null, difficulty: string | null): string {
  const v = [subVariant, layer].filter(Boolean).join(' · ');
  if (v) return v;
  if (difficulty) return `${difficulty} — see statement`;
  return 'Interview pattern';
}

async function fetchAllProblems(): Promise<
  Array<{
    lc_number: string | null;
    title: string;
    key_insight: string | null;
    sub_variant: string | null;
    layer: string | null;
    difficulty: string | null;
  }>
> {
  const PAGE = 1000;
  let from = 0;
  const all: any[] = [];
  for (;;) {
    const { data, error } = await sb
      .from('problems')
      .select('lc_number, title, key_insight, sub_variant, layer, difficulty')
      .not('lc_number', 'is', null)
      .order('topic_id')
      .order('order_num')
      .range(from, from + PAGE - 1);

    if (error) throw new Error(error.message);
    if (!data?.length) break;
    all.push(...data);
    if (data.length < PAGE) break;
    from += PAGE;
  }
  return all;
}

async function main() {
  console.log('Fetching problems from Supabase…');
  const rows = await fetchAllProblems();
  console.log(`Rows with lc_number: ${rows.length}`);

  const byLc = new Map<
    string,
    { title: string; insight: string; sub_variant: string | null; layer: string | null; difficulty: string | null }
  >();

  for (const r of rows) {
    const lc = String(r.lc_number).trim();
    if (!lc) continue;
    const prev = byLc.get(lc);
    const insight = (r.key_insight || '').trim();
    if (!prev) {
      byLc.set(lc, {
        title: r.title,
        insight,
        sub_variant: r.sub_variant,
        layer: r.layer,
        difficulty: r.difficulty,
      });
    } else {
      byLc.set(lc, {
        title: prev.title || r.title,
        insight: mergeInsight(prev.insight, insight),
        sub_variant: prev.sub_variant || r.sub_variant,
        layer: prev.layer || r.layer,
        difficulty: prev.difficulty || r.difficulty,
      });
    }
  }

  const record: Record<string, Solution> = {};
  for (const [lc, meta] of byLc) {
    record[lc] = {
      approach: rowToApproach(meta.sub_variant, meta.layer, meta.difficulty),
      time: '—',
      space: '—',
      steps: insightToSteps(meta.insight, meta.title),
    };
  }

  const sorted: Record<string, Solution> = {};
  for (const lc of Object.keys(record).sort((a, b) => a.localeCompare(b, undefined, { numeric: true }))) {
    sorted[lc] = record[lc];
  }

  const json = JSON.stringify(sorted, null, 2);
  const banner = `/**
 * AUTO-GENERATED by scripts/sync-solutions-from-db.ts — do not edit by hand.
 * Regenerate: npm run sync:solutions
 * Problems merged from DB: ${byLc.size}
 */

import type { Solution } from './solution-model';

export const solutionsFromDb: Record<string, Solution> = ${json};
`;

  fs.writeFileSync(outFile, banner, 'utf8');
  console.log(`Wrote ${byLc.size} solutions → ${path.relative(repoRoot, outFile)}`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
