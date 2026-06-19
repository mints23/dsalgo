-- Security: trial users only see problem_playback for trial-preview topics (not full catalog).
-- Same rules as migrations/trial_preview_topic_rls.sql — run if that migration was skipped.

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
