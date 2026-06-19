-- Trial users: full Pro-style access in the app, but only preview topic rows return
-- `topic_content`, `problems`, and `problem_playback` (RLS). Paid Pro unchanged.
--
-- Preview = fixed id list OR topics whose nav_label/title match Top K / 1D Linear
-- (covers DBs where `topics.id` does not match the catalog 10 / 14 defaults).
-- Client: `resolveTrialContentTopicIds` in `src/data/trial-preview-topic-ids.ts`.

-- topic_content
drop policy if exists "Topic content access by subscription" on public.topic_content;
create policy "Topic content access by subscription"
  on public.topic_content for select
  using (
    exists (select 1 from public.topics t where t.id = topic_content.topic_id and t.is_free = true)
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
        topic_content.topic_id in (1, 2, 3, 4, 10, 14, 29, 39)
        or exists (
          select 1
          from public.topics t
          where t.id = topic_content.topic_id
            and (
              lower(coalesce(t.nav_label, '')) like '%top k%'
              or lower(coalesce(t.title, '')) like '%top k%'
              or lower(coalesce(t.nav_label, '')) like '%1d linear%'
              or lower(coalesce(t.title, '')) like '%1d linear%'
            )
        )
      )
    )
  );

-- problems
drop policy if exists "Problems access by subscription" on public.problems;
create policy "Problems access by subscription"
  on public.problems for select
  using (
    exists (select 1 from public.topics t where t.id = problems.topic_id and t.is_free = true)
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
        problems.topic_id in (1, 2, 3, 4, 10, 14, 29, 39)
        or exists (
          select 1
          from public.topics t
          where t.id = problems.topic_id
            and (
              lower(coalesce(t.nav_label, '')) like '%top k%'
              or lower(coalesce(t.title, '')) like '%top k%'
              or lower(coalesce(t.nav_label, '')) like '%1d linear%'
              or lower(coalesce(t.title, '')) like '%1d linear%'
            )
        )
      )
    )
  );

-- problem_playback (via parent problem → topic)
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
