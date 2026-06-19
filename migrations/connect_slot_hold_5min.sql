-- 7-minute checkout hold: blocks others from booking the same slot while paying.
-- Run in Supabase SQL Editor, then reload schema.

alter table public.connect_slots
  add column if not exists hold_expires_at timestamptz;

drop function if exists public.hold_connect_slot(bigint, text);
drop function if exists public.hold_connect_slot(text, bigint);
drop function if exists public.confirm_connect_slot_payment(bigint, text, text);
drop function if exists public.confirm_connect_slot_payment(text, text, bigint);

-- Clear expired unpaid holds (called from hold / confirm RPCs)
create or replace function public.release_expired_connect_holds()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.connect_slots
  set status = 'available',
      booked_by = null,
      hold_expires_at = null,
      updated_at = now()
  where status = 'reserved'
    and coalesce(trim(razorpay_payment_id), '') = ''
    and (
      (hold_expires_at is not null and hold_expires_at <= now())
      or (hold_expires_at is null and updated_at <= now() - interval '7 minutes')
    );
end;
$$;

-- Student: reserve slot for 7 minutes before Razorpay checkout
-- Param order matches PostgREST (alphabetical JSON keys: p_service_id, p_slot_id).
create or replace function public.hold_connect_slot(
  p_service_id text,
  p_slot_id bigint
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

  perform public.release_expired_connect_holds();

  update public.connect_slots
  set status = 'reserved',
      booked_by = auth.uid(),
      hold_expires_at = now() + interval '7 minutes',
      service_id = coalesce(nullif(trim(p_service_id), ''), service_id),
      updated_at = now()
  where id = p_slot_id
    and starts_at > now()
    and (
      status = 'available'
      or (status = 'reserved' and booked_by = auth.uid())
    )
  returning * into row;

  if not found then
    raise exception 'slot unavailable' using errcode = 'P0002';
  end if;

  return json_build_object(
    'id', row.id,
    'status', row.status,
    'hold_expires_at', row.hold_expires_at,
    'starts_at', row.starts_at
  );
end;
$$;

-- Student: release own hold when checkout is cancelled
create or replace function public.release_my_connect_slot_hold(p_slot_id bigint)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    raise exception 'not authenticated' using errcode = '42501';
  end if;

  update public.connect_slots
  set status = 'available',
      booked_by = null,
      hold_expires_at = null,
      updated_at = now()
  where id = p_slot_id
    and status = 'reserved'
    and booked_by = auth.uid()
    and coalesce(trim(razorpay_payment_id), '') = '';
end;
$$;

-- Student: confirm only from an active hold owned by the payer
-- Param order matches PostgREST (alphabetical: p_payment_id, p_service_id, p_slot_id).
create or replace function public.confirm_connect_slot_payment(
  p_payment_id text,
  p_service_id text,
  p_slot_id bigint
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

  perform public.release_expired_connect_holds();

  update public.connect_slots
  set status = 'paid',
      booked_by = auth.uid(),
      razorpay_payment_id = trim(p_payment_id),
      service_id = coalesce(nullif(trim(p_service_id), ''), service_id),
      hold_expires_at = null,
      updated_at = now()
  where id = p_slot_id
    and starts_at > now()
    and status = 'reserved'
    and booked_by = auth.uid()
    and hold_expires_at is not null
    and hold_expires_at > now()
  returning * into row;

  if not found then
    raise exception 'slot unavailable or hold expired' using errcode = 'P0002';
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

-- Mentor: release checkout hold
create or replace function public.release_connect_slot(p_slot_id bigint)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_connect_mentor() then
    raise exception 'mentor only' using errcode = '42501';
  end if;

  update public.connect_slots
  set status = 'available',
      booked_by = null,
      hold_expires_at = null,
      updated_at = now()
  where id = p_slot_id
    and status = 'reserved'
    and coalesce(trim(razorpay_payment_id), '') = '';

  if not found then
    raise exception 'slot not reserved or already paid' using errcode = 'P0002';
  end if;
end;
$$;

grant execute on function public.hold_connect_slot(text, bigint) to authenticated;
grant execute on function public.release_my_connect_slot_hold(bigint) to authenticated;
grant execute on function public.release_connect_slot(bigint) to authenticated;
grant execute on function public.create_connect_slot(timestamptz, text, timestamptz) to authenticated;
grant execute on function public.cancel_connect_slot(bigint) to authenticated;

create or replace function public.sweep_connect_holds()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  perform public.release_expired_connect_holds();
end;
$$;

grant execute on function public.sweep_connect_holds() to anon, authenticated;
