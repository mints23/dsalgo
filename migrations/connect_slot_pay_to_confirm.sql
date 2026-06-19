-- Book slot only after Razorpay payment (skip pre-payment "reserved" state).
-- Run in Supabase SQL Editor after connect_slots.sql.

create or replace function public.confirm_connect_slot_payment(
  p_slot_id bigint,
  p_payment_id text,
  p_service_id text default null
)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
  row public.connect_slots%rowtype;
begin
  if auth.uid() is null then
    raise exception 'not authenticated' using errcode = '42501';
  end if;
  if coalesce(trim(p_payment_id), '') = '' then
    raise exception 'payment id required' using errcode = '22023';
  end if;

  update public.connect_slots
  set status = 'paid',
      booked_by = auth.uid(),
      razorpay_payment_id = trim(p_payment_id),
      service_id = coalesce(nullif(trim(p_service_id), ''), service_id),
      updated_at = now()
  where id = p_slot_id
    and status = 'available'
    and starts_at > now()
  returning * into row;

  if not found then
    raise exception 'slot unavailable' using errcode = 'P0002';
  end if;

  return json_build_object(
    'id', row.id,
    'status', row.status,
    'service_id', row.service_id,
    'starts_at', row.starts_at,
    'ends_at', row.ends_at
  );
end;
$$;
