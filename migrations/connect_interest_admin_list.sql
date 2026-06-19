-- Admin RPC to list DSA batch waitlist on /admin.
-- Run in Supabase SQL Editor if connect_service_interest.sql was already applied.

create or replace function public.list_connect_batch_interest(
  p_service_id text default 'dsa-classes'
)
returns json
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_connect_mentor() then
    raise exception 'mentor only' using errcode = '42501';
  end if;

  return (
    select coalesce(
      json_agg(row_to_json(t) order by t.created_at desc),
      '[]'::json
    )
    from (
      select
        i.id,
        i.user_id,
        u.email,
        i.service_id,
        i.note,
        i.created_at
      from public.connect_service_interest i
      join auth.users u on u.id = i.user_id
      where i.service_id = coalesce(nullif(trim(p_service_id), ''), 'dsa-classes')
      order by i.created_at desc
    ) t
  );
end;
$$;

grant execute on function public.list_connect_batch_interest(text) to authenticated;
