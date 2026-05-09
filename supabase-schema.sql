-- Run this in your Supabase SQL Editor (Dashboard → SQL Editor → New Query)

-- ── Topics table: stores all DSA content (protected by RLS) ──
create table if not exists topics (
  id int primary key,
  display_number text not null,
  show_in_sidebar boolean default true,
  nav_section text not null,
  nav_label text not null,
  nav_tier_dot_color text not null default '#01696f',
  title text not null,
  tier_code text not null,
  tier_label text not null,
  type_label text not null,
  summary_meta text not null default '',
  topbar_meta text not null default '',
  body_html text not null default ''
);

alter table topics enable row level security;

-- Only authenticated users can read topics
drop policy if exists "Authenticated users can read topics" on topics;
create policy "Authenticated users can read topics"
  on topics for select
  using (auth.role() = 'authenticated');

-- ── User progress table ──

-- Table: tracks which problems each user has completed
create table if not exists user_progress (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  topic_id int not null,
  problem_num int not null,
  completed_at timestamptz default now(),
  unique (user_id, topic_id, problem_num)
);

-- Enable Row Level Security
alter table user_progress enable row level security;

-- Users can only see their own progress
drop policy if exists "Users read own progress" on user_progress;
create policy "Users read own progress"
  on user_progress for select
  using (auth.uid() = user_id);

-- Users can only insert their own progress
drop policy if exists "Users insert own progress" on user_progress;
create policy "Users insert own progress"
  on user_progress for insert
  with check (auth.uid() = user_id);

-- Users can only delete their own progress
drop policy if exists "Users delete own progress" on user_progress;
create policy "Users delete own progress"
  on user_progress for delete
  using (auth.uid() = user_id);

-- Index for fast lookups
create index if not exists idx_user_progress_user
  on user_progress (user_id);

-- ── User revision marks (revisit later) ──
create table if not exists user_revision (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  topic_id int not null,
  problem_num int not null,
  marked_at timestamptz default now(),
  unique (user_id, topic_id, problem_num)
);

alter table user_revision enable row level security;

drop policy if exists "Users read own revision marks" on user_revision;
create policy "Users read own revision marks"
  on user_revision for select
  using (auth.uid() = user_id);

drop policy if exists "Users insert own revision marks" on user_revision;
create policy "Users insert own revision marks"
  on user_revision for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users delete own revision marks" on user_revision;
create policy "Users delete own revision marks"
  on user_revision for delete
  using (auth.uid() = user_id);

create index if not exists idx_user_revision_user
  on user_revision (user_id);

-- ── Subscriptions table: tracks trial & paid status ──
create table if not exists subscriptions (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users(id) on delete cascade not null unique,
  status text not null default 'trial',  -- trial, active, expired, cancelled
  trial_ends_at timestamptz not null,
  paid_until timestamptz,
  razorpay_payment_id text,
  razorpay_subscription_id text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table subscriptions enable row level security;

-- Users can read their own subscription
drop policy if exists "Users read own subscription" on subscriptions;
create policy "Users read own subscription"
  on subscriptions for select
  using (auth.uid() = user_id);

-- Users can insert their own subscription (for existing users without a row)
drop policy if exists "Users insert own subscription" on subscriptions;
create policy "Users insert own subscription"
  on subscriptions for insert
  with check (auth.uid() = user_id);

-- Index for fast lookups
create index if not exists idx_subscriptions_user
  on subscriptions (user_id);

-- ── Auto-create trial on signup (7 days) ──
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.subscriptions (user_id, status, trial_ends_at)
  values (new.id, 'trial', now() + interval '1 day');
  return new;
end;
$$ language plpgsql security definer;

-- Drop existing trigger if any, then create
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ── Activate subscription after payment ──
-- plan: 'monthly' → +30 days; 'quarterly' → +90 days (stacked after max(paid_until, now()))
create or replace function public.activate_subscription(payment_id text, plan text default 'monthly')
returns json as $$
declare
  result json;
  cur_until timestamptz;
  base_ts timestamptz;
  add_interval interval;
  until_ts timestamptz;
begin
  select s.paid_until into cur_until
  from public.subscriptions s
  where s.user_id = auth.uid();

  base_ts := greatest(coalesce(cur_until, now()), now());

  add_interval := case lower(trim(coalesce(plan, 'monthly')))
    when 'quarterly' then interval '90 days'
    else interval '30 days'
  end;

  until_ts := base_ts + add_interval;

  update public.subscriptions
  set status = 'active',
      paid_until = until_ts,
      razorpay_payment_id = payment_id,
      updated_at = now()
  where user_id = auth.uid();

  select json_build_object(
    'success', true,
    'paid_until', (select paid_until from public.subscriptions where user_id = auth.uid())
  ) into result;

  return result;
end;
$$ language plpgsql security definer;

-- ── Free-topic flag (controls access after trial expires) ──
-- Run this block after the initial schema above.
alter table topics
  add column if not exists is_free boolean not null default false;

-- Mark the first 2 topics as permanently free (always accessible after trial ends).
-- Change this list any time — no code deploys needed.
update topics set is_free = true where id in (1, 2);

-- ── Structured content table (separate from topics for easy rollback) ──
-- To roll back: DROP TABLE problems; DROP TABLE topic_content;
-- The topics table (with body_html) is left completely untouched.

create table if not exists topic_content (
  topic_id          int primary key references topics(id) on delete cascade,
  body_html         text not null default '',
  why_it_matters    text not null default '',
  core_idea         text not null default '',
  sub_variants      jsonb not null default '[]',
  pattern_triggers  jsonb not null default '[]',
  coverage_problems jsonb not null default '[]',
  red_flags         jsonb not null default '[]'
);

alter table topic_content enable row level security;

-- topic_content is accessible when:
--   • the topic is marked free (is_free = true), OR
--   • the user has an active trial, OR
--   • the user has an active paid subscription
drop policy if exists "Authenticated users can read topic_content" on topic_content;
drop policy if exists "Topic content access by subscription" on topic_content;

create policy "Topic content access by subscription"
  on topic_content for select
  using (
    exists (select 1 from public.topics t where t.id = topic_id and t.is_free = true)
    or exists (
      select 1 from public.subscriptions s
      where s.user_id = auth.uid()
        and (
          (s.status = 'trial'  and s.trial_ends_at > now())
          or
          (s.status = 'active' and s.paid_until    > now())
        )
    )
  );

-- One row per LeetCode problem per topic
create table if not exists problems (
  id          bigserial primary key,
  topic_id    int     not null references topics(id) on delete cascade,
  order_num   int     not null,
  layer       text    not null,   -- Foundation | Variants | Combo | Hard | Trap
  lc_number   text,               -- e.g. '167'
  lc_url      text,
  title       text    not null,
  difficulty  text,               -- Easy | Med | Hard
  is_premium  boolean not null default false,
  sub_variant text,
  key_insight text,
  unique (topic_id, order_num)
);

alter table problems enable row level security;

-- Same access rule for problems rows
drop policy if exists "Authenticated users can read problems" on problems;
drop policy if exists "Problems access by subscription" on problems;

create policy "Problems access by subscription"
  on problems for select
  using (
    exists (select 1 from public.topics t where t.id = topic_id and t.is_free = true)
    or exists (
      select 1 from public.subscriptions s
      where s.user_id = auth.uid()
        and (
          (s.status = 'trial'  and s.trial_ends_at > now())
          or
          (s.status = 'active' and s.paid_until    > now())
        )
    )
  );

create index if not exists idx_problems_topic on problems (topic_id, order_num);

-- ── Per-problem Key Insight overlay (solution + visualization JSON) ──
-- solution: { approach, time, space, steps: [{ title, explain?, code[], note, phase?, dry? }] }
--   explain = plain-language paragraph beside pseudocode (see src/data/solution-model.ts)
create table if not exists public.problem_playback (
  problem_id     bigint primary key references public.problems (id) on delete cascade,
  solution       jsonb,
  visualization  jsonb,
  updated_at     timestamptz not null default now()
);

create index if not exists idx_problem_playback_updated on public.problem_playback (updated_at desc);

alter table public.problem_playback enable row level security;

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
            select 1
            from public.subscriptions s
            where s.user_id = auth.uid()
              and (
                (s.status = 'trial'  and s.trial_ends_at > now())
                or
                (s.status = 'active' and s.paid_until    > now())
              )
          )
        )
    )
  );

-- ── Pro study preferences (problem-table focus + core coverage per topic) ──
create table if not exists public.user_study_preferences (
  user_id                  uuid primary key references auth.users (id) on delete cascade,
  problems_only            boolean not null default false,
  min_coverage_by_topic    jsonb not null default '{}'::jsonb,
  revision_only_by_topic   jsonb not null default '{}'::jsonb,
  updated_at               timestamptz not null default now()
);

alter table public.user_study_preferences enable row level security;

drop policy if exists "study_prefs_select_pro" on public.user_study_preferences;
create policy "study_prefs_select_pro"
  on public.user_study_preferences for select
  using (
    auth.uid() = user_id
    and exists (
      select 1 from public.subscriptions s
      where s.user_id = auth.uid()
        and s.status = 'active'
        and s.paid_until is not null
        and s.paid_until > now()
    )
  );

drop policy if exists "study_prefs_insert_pro" on public.user_study_preferences;
create policy "study_prefs_insert_pro"
  on public.user_study_preferences for insert
  with check (
    auth.uid() = user_id
    and exists (
      select 1 from public.subscriptions s
      where s.user_id = auth.uid()
        and s.status = 'active'
        and s.paid_until is not null
        and s.paid_until > now()
    )
  );

drop policy if exists "study_prefs_update_pro" on public.user_study_preferences;
create policy "study_prefs_update_pro"
  on public.user_study_preferences for update
  using (
    auth.uid() = user_id
    and exists (
      select 1 from public.subscriptions s
      where s.user_id = auth.uid()
        and s.status = 'active'
        and s.paid_until is not null
        and s.paid_until > now()
    )
  )
  with check (auth.uid() = user_id);

-- Study prefs RPCs (client uses these; see migrations/study_preferences_rpc.sql)
drop function if exists public.get_user_study_preferences();

create or replace function public.get_user_study_preferences()
returns table (
  problems_only boolean,
  min_coverage_by_topic jsonb,
  revision_only_by_topic jsonb
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    return;
  end if;
  if not exists (
    select 1 from public.subscriptions s
    where s.user_id = auth.uid()
      and s.status = 'active'
      and s.paid_until is not null
      and s.paid_until > now()
  ) then
    return;
  end if;
  return query
  select p.problems_only, p.min_coverage_by_topic, p.revision_only_by_topic
  from public.user_study_preferences p
  where p.user_id = auth.uid();
end;
$$;

create or replace function public.upsert_user_study_preferences(
  p_problems_only boolean,
  p_min jsonb default '{}'::jsonb,
  p_rev jsonb default '{}'::jsonb
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    raise exception 'not authenticated' using errcode = '42501';
  end if;
  if not exists (
    select 1 from public.subscriptions s
    where s.user_id = auth.uid()
      and s.status = 'active'
      and s.paid_until is not null
      and s.paid_until > now()
  ) then
    raise exception 'subscription required' using errcode = '42501';
  end if;
  insert into public.user_study_preferences (
    user_id, problems_only, min_coverage_by_topic, revision_only_by_topic, updated_at
  )
  values (
    auth.uid(), p_problems_only, coalesce(p_min, '{}'::jsonb), coalesce(p_rev, '{}'::jsonb), now()
  )
  on conflict (user_id) do update set
    problems_only = excluded.problems_only,
    min_coverage_by_topic = excluded.min_coverage_by_topic,
    revision_only_by_topic = excluded.revision_only_by_topic,
    updated_at = excluded.updated_at;
end;
$$;

revoke all on function public.get_user_study_preferences() from public;
grant execute on function public.get_user_study_preferences() to authenticated;
revoke all on function public.upsert_user_study_preferences(boolean, jsonb, jsonb) from public;
grant execute on function public.upsert_user_study_preferences(boolean, jsonb, jsonb) to authenticated;

-- After verifying migration data looks correct you can optionally remove body_html:
-- alter table topics drop column body_html;
-- Or to fully roll back the refactor:
-- DROP TABLE problems; DROP TABLE topic_content;
