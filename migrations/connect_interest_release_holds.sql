-- Waitlist signup also clears unpaid reserved slot holds.
-- Run in Supabase SQL Editor if connect_service_interest.sql was already applied.

drop function if exists public.register_connect_interest(text, text);

create or replace function public.register_connect_interest(
  p_note text,
  p_service_id text
)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
  row public.connect_service_interest%rowtype;
begin
  if auth.uid() is null then
    raise exception 'not authenticated' using errcode = '42501';
  end if;
  if coalesce(trim(p_service_id), '') = '' then
    raise exception 'service id required' using errcode = '22023';
  end if;

  update public.connect_slots
  set status = 'available',
      booked_by = null,
      hold_expires_at = null,
      updated_at = now()
  where status = 'reserved'
    and coalesce(trim(razorpay_payment_id), '') = '';

  insert into public.connect_service_interest (user_id, service_id, note)
  values (
    auth.uid(),
    trim(p_service_id),
    nullif(trim(p_note), '')
  )
  on conflict (user_id, service_id) do update
  set note = coalesce(nullif(trim(excluded.note), ''), public.connect_service_interest.note)
  returning * into row;

  return json_build_object(
    'service_id', row.service_id,
    'registered_at', row.created_at
  );
end;
$$;
