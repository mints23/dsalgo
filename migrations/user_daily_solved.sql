-- Daily solved counts (GitHub-style heatmap).
-- This complements `user_progress` (per-problem) with a compact per-day aggregate.

create table if not exists user_daily_solved (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  day date not null,
  solved_count int not null default 0,
  updated_at timestamptz not null default now(),
  unique (user_id, day)
);

alter table user_daily_solved enable row level security;

create policy "Users read own daily solved"
  on user_daily_solved for select
  using (auth.uid() = user_id);

create policy "Users upsert own daily solved"
  on user_daily_solved for insert
  with check (auth.uid() = user_id);

create policy "Users update own daily solved"
  on user_daily_solved for update
  using (auth.uid() = user_id);

create index if not exists idx_user_daily_solved_user_day
  on user_daily_solved (user_id, day desc);

