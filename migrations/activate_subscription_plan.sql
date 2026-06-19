-- activate_subscription: Razorpay success handler (authenticated caller).
-- plan: 'monthly' → +30 days; 'quarterly' → +90 days from stacking base.
-- Stacking: new period is added after max(existing paid_until, now()) so early renewals extend access.

create or replace function public.activate_subscription(payment_id text, plan text default 'monthly')
returns json as $$
declare
  result json;
  cur_until timestamptz;
  base_ts timestamptz;
  add_interval interval;
  until_ts timestamptz;
begin
  select s.paid_until into cur_until
  from public.subscriptions s
  where s.user_id = auth.uid();

  base_ts := greatest(coalesce(cur_until, now()), now());

  add_interval := case lower(trim(coalesce(plan, 'monthly')))
    when 'quarterly' then interval '90 days'
    else interval '30 days'
  end;

  until_ts := base_ts + add_interval;

  update public.subscriptions
  set status = 'active',
      paid_until = until_ts,
      razorpay_payment_id = payment_id,
      updated_at = now()
  where user_id = auth.uid();

  select json_build_object(
    'success', true,
    'paid_until', (select paid_until from public.subscriptions where user_id = auth.uid())
  ) into result;

  return result;
end;
$$ language plpgsql security definer;
