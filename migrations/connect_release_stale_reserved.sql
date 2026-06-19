-- Clear legacy pre-payment "reserved" holds and add mentor release RPC.
-- Run in Supabase SQL Editor.

-- Reopen slots stuck from the old book-before-pay flow
update public.connect_slots
set status = 'available',
    booked_by = null,
    updated_at = now()
where status = 'reserved'
  and coalesce(trim(razorpay_payment_id), '') = '';

-- Block new pre-payment reservations (pay-then-book only)
create or replace function public.book_connect_slot(p_slot_id bigint)
returns json
language plpgsql
security definer
set search_path = public
as $$
begin
  raise exception 'Slots are booked only after payment confirmation'
    using errcode = '42501';
end;
$$;

-- Mentor: release an unpaid reserved hold back to available
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
      updated_at = now()
  where id = p_slot_id
    and status = 'reserved'
    and coalesce(trim(razorpay_payment_id), '') = '';

  if not found then
    raise exception 'slot not reserved or already paid' using errcode = 'P0002';
  end if;
end;
$$;
