/**
 * Marketing / static HTML counts. Keep aligned with production:
 * - Topics: `GUIDE_TOPIC_COUNT` matches `LOGIN_SNEAK_NAV.length` (regenerate nav via
 *   `node tools/dump-login-sneak-topics.mjs` when the sidebar changes).
 * - Problems: run `npx tsx scripts/count-problems.ts` (Supabase env) and set
 *   `GUIDE_PROBLEM_ROW_COUNT` to the printed total row count.
 */
import { LOGIN_SNEAK_NAV } from './login-sneak-static';

export const GUIDE_TOPIC_COUNT = LOGIN_SNEAK_NAV.length;

/** Exact `count(*)` from `public.problems` — update after bulk imports. */
export const GUIDE_PROBLEM_ROW_COUNT = 1150;
