-- Fix admin "Clear hold" — grant RPC + ensure hold_expires_at is cleared.
-- Run in Supabase SQL Editor, then reload schema.

alter table public.connect_slots
  add column if not exists hold_expires_at timestamptz;

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

grant execute on function public.release_connect_slot(bigint) to authenticated;
grant execute on function public.create_connect_slot(timestamptz, text, timestamptz) to authenticated;
grant execute on function public.cancel_connect_slot(bigint) to authenticated;
