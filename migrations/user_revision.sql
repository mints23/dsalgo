-- Marks problems the user wants to revisit (synced for Pro; RLS same pattern as user_progress).
create table if not exists user_revision (
  id bigint generated always as identity primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  topic_id int not null,
  problem_num int not null,
  marked_at timestamptz default now(),
  unique (user_id, topic_id, problem_num)
);

alter table user_revision enable row level security;

create policy "Users read own revision marks"
  on user_revision for select
  using (auth.uid() = user_id);

create policy "Users insert own revision marks"
  on user_revision for insert
  with check (auth.uid() = user_id);

create policy "Users delete own revision marks"
  on user_revision for delete
  using (auth.uid() = user_id);

create index if not exists idx_user_revision_user
  on user_revision (user_id);
