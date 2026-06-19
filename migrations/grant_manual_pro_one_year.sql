-- Grant 1 year of Pro from "now" (or stack on top of existing paid_until if longer).
-- Run in Supabase: SQL Editor → run as postgres (service role bypasses RLS).
--
-- 1) Find the user's UUID (Authentication → Users, or):
--    select id, email from auth.users where email ilike 'user@example.com';
--
-- 2) Replace the UUID below, then run the DO block (or use the simple UPDATE).

-- Option A — by user id (stack: new end = max(current paid_until, now) + 1 year)
do $$
declare
  target uuid := '00000000-0000-0000-0000-000000000000';  -- <-- paste auth.users.id
  base_ts timestamptz;
  new_until timestamptz;
begin
  select greatest(coalesce(s.paid_until, now()), now()) into base_ts
  from public.subscriptions s
  where s.user_id = target;

  if not found then
    raise exception 'No subscriptions row for user %. Create one first (signup) or INSERT.', target;
  end if;

  new_until := base_ts + interval '1 year';

  update public.subscriptions
  set status = 'active',
      paid_until = new_until,
      razorpay_payment_id = coalesce(razorpay_payment_id, 'manual_grant_1yr'),
      updated_at = now()
  where user_id = target;
end;
$$;

-- Option B — one line if you already know the row exists:
-- update public.subscriptions
-- set status = 'active',
--     paid_until = greatest(coalesce(paid_until, now()), now()) + interval '1 year',
--     razorpay_payment_id = coalesce(razorpay_payment_id, 'manual_grant_1yr'),
--     updated_at = now()
-- where user_id = '00000000-0000-0000-0000-000000000000';
