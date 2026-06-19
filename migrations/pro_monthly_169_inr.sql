-- Monthly Pro = ₹169 (16900 paise). Run in Supabase SQL Editor after deploy.
create or replace function public.webhook_activate_subscription(
  p_payment_id text,
  p_user_id uuid,
  p_plan text,
  p_amount_paise int
)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
  cur_until timestamptz;
  base_ts timestamptz;
  add_interval interval;
  until_ts timestamptz;
  expected_amount int;
  existing_user uuid;
begin
  if coalesce(trim(p_payment_id), '') = '' or p_user_id is null then
    raise exception 'invalid webhook payload' using errcode = '22023';
  end if;

  expected_amount := case lower(trim(coalesce(p_plan, 'monthly')))
    when 'quarterly' then 29900
    else 16900
  end;

  if p_amount_paise is distinct from expected_amount then
    raise exception 'pro amount mismatch' using errcode = '22023';
  end if;

  select s.user_id into existing_user
  from public.subscriptions s
  where s.razorpay_payment_id = trim(p_payment_id)
  limit 1;

  if found then
    if existing_user = p_user_id then
      return json_build_object('success', true, 'already_applied', true);
    end if;
    raise exception 'payment id already used' using errcode = '23505';
  end if;

  select s.paid_until into cur_until
  from public.subscriptions s
  where s.user_id = p_user_id;

  if not found then
    raise exception 'no subscription row for user' using errcode = 'P0002';
  end if;

  base_ts := greatest(coalesce(cur_until, now()), now());
  add_interval := case lower(trim(coalesce(p_plan, 'monthly')))
    when 'quarterly' then interval '90 days'
    else interval '30 days'
  end;
  until_ts := base_ts + add_interval;

  update public.subscriptions
  set status = 'active',
      paid_until = until_ts,
      razorpay_payment_id = trim(p_payment_id),
      updated_at = now()
  where user_id = p_user_id;

  return json_build_object('success', true, 'paid_until', until_ts);
end;
$$;
