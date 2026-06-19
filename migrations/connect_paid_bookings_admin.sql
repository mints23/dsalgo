-- Admin: paid Connect bookings with user email (who booked).
-- Run in Supabase SQL Editor, then reload schema.

create or replace function public.list_connect_paid_bookings()
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
      json_agg(row_to_json(t) order by t.starts_at asc),
      '[]'::json
    )
    from (
      select
        s.id,
        s.starts_at,
        s.ends_at,
        s.service_id,
        s.razorpay_payment_id,
        s.booked_by,
        u.email
      from public.connect_slots s
      left join auth.users u on u.id = s.booked_by
      where s.status = 'paid'
        and s.starts_at > now()
      order by s.starts_at asc
    ) t
  );
end;
$$;

create or replace function public.list_connect_slot_contacts()
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
      json_agg(json_build_object('slot_id', s.id, 'email', u.email, 'status', s.status)),
      '[]'::json
    )
    from public.connect_slots s
    join auth.users u on u.id = s.booked_by
    where s.status in ('reserved', 'paid')
      and s.starts_at > now()
  );
end;
$$;

grant execute on function public.list_connect_paid_bookings() to authenticated;
grant execute on function public.list_connect_slot_contacts() to authenticated;
