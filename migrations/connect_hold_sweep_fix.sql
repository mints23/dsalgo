-- Fix stuck checkout holds: sweep expired + legacy reserved rows.
-- Run in Supabase SQL Editor, then reload schema.

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

-- Safe to call on page load (Connect + admin) — clears expired holds only.
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
