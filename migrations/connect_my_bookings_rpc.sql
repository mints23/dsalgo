-- User: list own upcoming Connect bookings (for /connect calendar).
-- Also refreshes RLS so booked_by rows are readable. Run in Supabase SQL Editor, reload schema.

drop policy if exists "Read connect slots" on public.connect_slots;
create policy "Read connect slots"
  on public.connect_slots for select
  using (
    public.is_connect_mentor()
    or status = 'available'
    or booked_by = auth.uid()
  );

create or replace function public.list_my_connect_bookings()
returns json
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    return '[]'::json;
  end if;

  return (
    select coalesce(
      json_agg(row_to_json(t) order by t.starts_at asc),
      '[]'::json
    )
    from (
      select
        s.id,
        s.service_id,
        s.starts_at,
        s.ends_at,
        s.status
      from public.connect_slots s
      where s.booked_by = auth.uid()
        and s.status in ('paid', 'reserved')
        and s.ends_at > now()
      order by s.starts_at asc
    ) t
  );
end;
$$;

grant execute on function public.list_my_connect_bookings() to authenticated;
grant select on public.connect_slots to authenticated;
