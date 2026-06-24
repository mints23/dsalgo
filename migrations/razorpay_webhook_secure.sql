-- P0: Razorpay webhook-only payment activation (no client-trusted RPCs).
-- Run in Supabase SQL Editor, then reload schema.
-- Deploy Edge Function `razorpay-webhook` and set RAZORPAY_WEBHOOK_SECRET (see migrations/README_RAZORPAY_WEBHOOK.md).

-- ── Unique payment IDs (idempotent webhooks; exclude manual_grant* placeholders) ──
create unique index if not exists idx_subscriptions_razorpay_payment_unique
  on public.subscriptions (razorpay_payment_id)
  where razorpay_payment_id is not null
    and trim(razorpay_payment_id) <> ''
    and razorpay_payment_id not ilike 'manual_grant%';

create unique index if not exists idx_connect_slots_razorpay_payment_unique
  on public.connect_slots (razorpay_payment_id)
  where razorpay_payment_id is not null and trim(razorpay_payment_id) <> '';

-- ── Connect service prices (paise) — keep in sync with src/data/connect-services.ts ──
create or replace function public.connect_service_price_paise(p_service_id text)
returns int
language sql
immutable
set search_path = public
as $$
  select case trim(coalesce(p_service_id, ''))
    when 'system-design' then 49900
    when 'roadmap' then 39900
    when 'dsa-classes' then 39900
    when 'cv-review' then 39900
    when 'mentorship' then 79900
    else null
  end;
$$;

-- ── Webhook: activate Pro (service_role only) ──
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

-- ── Webhook: confirm Connect slot (service_role only) ──
create or replace function public.webhook_confirm_connect_slot(
  p_payment_id text,
  p_user_id uuid,
  p_slot_id bigint,
  p_service_id text,
  p_amount_paise int
)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
  row public.connect_slots%rowtype;
  expected_amount int;
  existing_slot bigint;
begin
  if coalesce(trim(p_payment_id), '') = '' or p_user_id is null or p_slot_id is null then
    raise exception 'invalid webhook payload' using errcode = '22023';
  end if;

  expected_amount := public.connect_service_price_paise(p_service_id);
  if expected_amount is null then
    raise exception 'unknown connect service' using errcode = '22023';
  end if;
  if p_amount_paise is distinct from expected_amount then
    raise exception 'connect amount mismatch' using errcode = '22023';
  end if;

  select s.id into existing_slot
  from public.connect_slots s
  where s.razorpay_payment_id = trim(p_payment_id)
  limit 1;

  if found then
    if existing_slot = p_slot_id then
      return json_build_object('success', true, 'already_applied', true, 'id', p_slot_id);
    end if;
    raise exception 'payment id already used' using errcode = '23505';
  end if;

  perform public.release_expired_connect_holds();

  update public.connect_slots
  set status = 'paid',
      booked_by = p_user_id,
      razorpay_payment_id = trim(p_payment_id),
      service_id = coalesce(nullif(trim(p_service_id), ''), service_id),
      hold_expires_at = null,
      updated_at = now()
  where id = p_slot_id
    and starts_at > now()
    and status = 'reserved'
    and booked_by = p_user_id
    and hold_expires_at is not null
    and hold_expires_at > now()
  returning * into row;

  if not found then
    raise exception 'slot unavailable or hold expired' using errcode = 'P0002';
  end if;

  return json_build_object(
    'success', true,
    'id', row.id,
    'status', row.status,
    'service_id', row.service_id,
    'starts_at', row.starts_at,
    'ends_at', row.ends_at
  );
end;
$$;

revoke all on function public.webhook_activate_subscription(text, uuid, text, int) from public;
revoke all on function public.webhook_confirm_connect_slot(text, uuid, bigint, text, int) from public;
grant execute on function public.webhook_activate_subscription(text, uuid, text, int) to service_role;
grant execute on function public.webhook_confirm_connect_slot(text, uuid, bigint, text, int) to service_role;

-- ── Lock down client-trusted payment RPCs ──
create or replace function public.activate_subscription(payment_id text, plan text default 'monthly')
returns json
language plpgsql
security definer
set search_path = public
as $$
begin
  raise exception 'Pro activation is processed automatically after payment'
    using errcode = '42501';
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
begin
  raise exception 'Booking confirmation is processed automatically after payment'
    using errcode = '42501';
end;
$$;

revoke all on function public.activate_subscription(text, text) from public, anon, authenticated;
revoke all on function public.confirm_connect_slot_payment(text, text, bigint) from public, anon, authenticated;
