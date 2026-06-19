-- problem_playback: per-problem Key Insight overlay data (solution steps + optional viz frames).
-- Run in Supabase SQL Editor after `problems` exists.
-- Then: npm run seed:playback (service role) to populate from repo seed data.
--
-- solution JSON (document contract):
-- {
--   "approach": "string",
--   "time": "string",
--   "space": "string",
--   "steps": [
--     {
--       "title": "string",
--       "explain": "optional plain-language paragraph for end users (shown beside pseudocode)",
--       "code": ["line1", "line2"],
--       "note": "string (extra hint, often after typing)",
--       "phase": "optional section label",
--       "dry": { "caption": "...", "cells": [...], "vars": [...], "auxTitle": "...", "auxLines": [...] }
--     }
--   ]
-- }

create table if not exists public.problem_playback (
  problem_id     bigint primary key references public.problems (id) on delete cascade,
  solution       jsonb,  -- shape above; types in src/data/solution-model.ts
  visualization  jsonb,  -- { frames: [...] } — see src/data/visualizations.ts
  updated_at     timestamptz not null default now()
);

create index if not exists idx_problem_playback_updated on public.problem_playback (updated_at desc);

alter table public.problem_playback enable row level security;

-- Read access mirrors problems: free topic OR paid Pro OR trial on preview topics only
drop policy if exists "Problem playback access by subscription" on public.problem_playback;
create policy "Problem playback access by subscription"
  on public.problem_playback for select
  using (
    exists (
      select 1
      from public.problems p
      join public.topics t on t.id = p.topic_id
      where p.id = problem_playback.problem_id
        and (
          t.is_free = true
          or exists (
            select 1 from public.subscriptions s
            where s.user_id = auth.uid()
              and s.status = 'active'
              and s.paid_until is not null
              and s.paid_until > now()
          )
          or (
            exists (
              select 1 from public.subscriptions s
              where s.user_id = auth.uid()
                and s.status = 'trial'
                and s.trial_ends_at > now()
            )
            and (
              p.topic_id in (1, 2, 3, 4, 10, 14, 29, 39)
              or lower(coalesce(t.nav_label, '')) like '%top k%'
              or lower(coalesce(t.title, '')) like '%top k%'
              or lower(coalesce(t.nav_label, '')) like '%1d linear%'
              or lower(coalesce(t.title, '')) like '%1d linear%'
            )
          )
        )
    )
  );

-- No insert/update/delete for authenticated users — seed with service role only
