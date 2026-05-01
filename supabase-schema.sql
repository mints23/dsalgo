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
  values (new.id, 'trial', now() + interval '7 days');
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
