-- Security: clients may only insert a trial row for themselves (no self-granted Pro).
-- Run in Supabase SQL Editor after initial schema.

drop policy if exists "Users insert own subscription" on public.subscriptions;

create policy "Users insert own trial subscription"
  on public.subscriptions for insert
  with check (
    auth.uid() = user_id
    and status = 'trial'
    and trial_ends_at is not null
    and trial_ends_at > now()
    and trial_ends_at <= now() + interval '8 days'
    and paid_until is null
    and coalesce(trim(razorpay_payment_id), '') = ''
    and coalesce(razorpay_subscription_id, '') = ''
    and coalesce(is_admin, false) = false
  );
