-- Load/save study preferences via SECURITY DEFINER RPCs.
-- get_user_study_preferences returns TABLE so PostgREST always returns a JSON array of rows
-- (0 or 1 row). A scalar `returns json` can surface as a string or other shape in the client.
--
-- After running: Supabase Dashboard → Settings → API → "Reload schema" if the client still
-- cannot see the function (PostgREST cache).

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
    select 1
    from public.subscriptions s
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
    select 1
    from public.subscriptions s
    where s.user_id = auth.uid()
      and s.status = 'active'
      and s.paid_until is not null
      and s.paid_until > now()
  ) then
    raise exception 'subscription required' using errcode = '42501';
  end if;

  insert into public.user_study_preferences (
    user_id,
    problems_only,
    min_coverage_by_topic,
    revision_only_by_topic,
    updated_at
  )
  values (
    auth.uid(),
    p_problems_only,
    coalesce(p_min, '{}'::jsonb),
    coalesce(p_rev, '{}'::jsonb),
    now()
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
