-- Study UI preferences for Pro subscribers.
-- `problems_only` ("Just problems") is read/written only via this table for Pro (not localStorage).
-- Core-set / revision toggles may still be bootstrapped from localStorage until a row exists.

create table if not exists public.user_study_preferences (
  user_id                  uuid primary key references auth.users (id) on delete cascade,
  problems_only            boolean not null default false,
  min_coverage_by_topic    jsonb not null default '{}'::jsonb,
  revision_only_by_topic   jsonb not null default '{}'::jsonb,
  updated_at               timestamptz not null default now()
);

alter table public.user_study_preferences enable row level security;

-- Paid Pro only (active subscription with paid_until in the future)
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
