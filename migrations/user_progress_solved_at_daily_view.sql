-- Make the daily solved heatmap fully DB-derived for Pro users.
--
-- Assumptions:
-- - `public.user_progress` already exists (it’s referenced by the app).
-- - If it lacks a timestamp, we add `solved_at` (set on insert).
--
-- After this, the app can read from `public.user_daily_solved_view` to render the heatmap.

alter table if exists public.user_progress
  add column if not exists solved_at timestamptz not null default now();

create or replace view public.user_daily_solved_view as
select
  user_id,
  (solved_at at time zone 'utc')::date as day,
  count(*)::int as solved_count
from public.user_progress
group by user_id, (solved_at at time zone 'utc')::date;

alter view public.user_daily_solved_view set (security_invoker = true);

