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
create policy "Users read own progress"
  on user_progress for select
  using (auth.uid() = user_id);

-- Users can only insert their own progress
create policy "Users insert own progress"
  on user_progress for insert
  with check (auth.uid() = user_id);

-- Users can only delete their own progress
create policy "Users delete own progress"
  on user_progress for delete
  using (auth.uid() = user_id);

-- Index for fast lookups
create index if not exists idx_user_progress_user
  on user_progress (user_id);

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
create policy "Users read own subscription"
  on subscriptions for select
  using (auth.uid() = user_id);

-- Users can insert their own subscription (for existing users without a row)
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
create or replace function public.activate_subscription(payment_id text)
returns json as $$
declare
  result json;
begin
  update public.subscriptions
  set status = 'active',
      paid_until = now() + interval '30 days',
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

-- After verifying migration data looks correct you can optionally remove body_html:
-- alter table topics drop column body_html;
-- Or to fully roll back the refactor:
-- DROP TABLE problems; DROP TABLE topic_content;
