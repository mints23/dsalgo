-- Per-topic "Revision only" filter (Pro study preferences).
alter table public.user_study_preferences
  add column if not exists revision_only_by_topic jsonb not null default '{}'::jsonb;
