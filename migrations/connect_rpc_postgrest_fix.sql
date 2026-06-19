-- Fix Connect RPC parameter order for PostgREST (JSON keys are passed alphabetically).
-- Run in Supabase SQL Editor, then Dashboard → Settings → API → Reload schema.

alter table public.connect_slots
  add column if not exists hold_expires_at timestamptz;

-- Drop old signatures before recreate (PostgREST param reorder / rename).
drop function if exists public.hold_connect_slot(bigint, text);
drop function if exists public.hold_connect_slot(text, bigint);
drop function if exists public.confirm_connect_slot_payment(bigint, text, text);
drop function if exists public.confirm_connect_slot_payment(text, text, bigint);
drop function if exists public.create_connect_slot(text, timestamptz, timestamptz);
drop function if exists public.create_connect_slot(timestamptz, text, timestamptz);

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

create or replace function public.create_connect_slot(
  p_ends_at timestamptz,
  p_service_id text,
  p_starts_at timestamptz
)
returns bigint
language plpgsql
security definer
set search_path = public
as $$
declare
  new_id bigint;
begin
  if auth.uid() is null then
    raise exception 'not authenticated' using errcode = '42501';
  end if;
  if not public.is_connect_mentor() then
    raise exception 'mentor only' using errcode = '42501';
  end if;
  if p_ends_at <= p_starts_at then
    raise exception 'invalid time range' using errcode = '22023';
  end if;
  if p_starts_at < now() then
    raise exception 'slot must be in the future' using errcode = '22023';
  end if;

  insert into public.connect_slots (service_id, starts_at, ends_at, status)
  values (trim(p_service_id), p_starts_at, p_ends_at, 'available')
  returning id into new_id;

  return new_id;
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
