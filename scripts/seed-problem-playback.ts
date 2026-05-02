/**
 * Upsert problem_playback rows from src/data algorithm walkthroughs + visualizations,
 * keyed by problems.lc_number → matching problems.id.
 *
 * Requires in .env:
 *   PUBLIC_SUPABASE_URL
 *   SUPABASE_SERVICE_ROLE_KEY
 *
 * Run migration first: migrations/problem_playback.sql
 */
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import type { Solution } from '../src/data/solution-model.ts';
import { getStepExplain } from '../src/data/step-explain.ts';
import { LC_COMPREHENSIVE } from '../src/data/algorithm-walkthroughs.ts';
import { visualizations } from '../src/data/visualizations.ts';

/** Persist explicit `explain` on each step for DB inspection & stable overlay copy. */
function solutionWithExplains(sol: Solution): Solution {
  return {
    ...sol,
    steps: sol.steps.map((st) => {
      const explicit = st.explain?.trim();
      const derived = explicit || getStepExplain({ ...st, explain: undefined });
      if (!derived || derived.length < 12) return { ...st };
      return { ...st, explain: derived };
    }),
  };
}

dotenv.config();

const url = process.env.PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !key) {
  console.error('Missing PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in .env');
  process.exit(1);
}

const sb = createClient(url, key);

function chunk<T>(arr: T[], size: number): T[][] {
  const out: T[][] = [];
  for (let i = 0; i < arr.length; i += size) out.push(arr.slice(i, i + size));
  return out;
}

async function main() {
  const { data: rows, error } = await sb.from('problems').select('id, lc_number');
  if (error) {
    console.error(error.message);
    process.exit(1);
  }
  if (!rows?.length) {
    console.error('No problems rows returned.');
    process.exit(1);
  }

  type Row = { problem_id: number; solution: unknown; visualization: unknown };
  const payloads: Row[] = [];

  for (const pr of rows) {
    const lc = String(pr.lc_number ?? '').trim();
    if (!lc) continue;
    const sol = LC_COMPREHENSIVE[lc];
    const viz = visualizations[lc as keyof typeof visualizations];
    const hasSol = Boolean(sol?.steps?.length);
    const hasViz = Boolean(viz && 'frames' in viz && Array.isArray(viz.frames) && viz.frames.length);
    if (!hasSol && !hasViz) continue;
    payloads.push({
      problem_id: Number(pr.id),
      solution: hasSol ? solutionWithExplains(sol) : null,
      visualization: hasViz ? viz : null,
    });
  }

  console.log(`Upserting ${payloads.length} problem_playback row(s)…`);

  let ok = 0;
  for (const batch of chunk(payloads, 80)) {
    const { error: upErr } = await sb.from('problem_playback').upsert(batch, { onConflict: 'problem_id' });
    if (upErr) {
      console.error(upErr.message);
      process.exit(1);
    }
    ok += batch.length;
  }

  console.log(`Done. ${ok} row(s) written.`);
  console.log(`LC keys in walkthroughs: ${Object.keys(LC_COMPREHENSIVE).length}; viz keys: ${Object.keys(visualizations).length}.`);
}

main();
