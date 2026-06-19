-- Connect mentoring: availability slots (start with system-design).
-- Run in Supabase SQL Editor, then Dashboard → Settings → API → Reload schema.
--
-- One-time: register admin on existing subscriptions row (replace email):
--   update public.subscriptions set is_admin = true
--   where user_id = (select id from auth.users where email = 'you@example.com');
--
-- Requires subscriptions.is_admin (run migrations/subscriptions_is_admin.sql first).

alter table public.subscriptions
  add column if not exists is_admin boolean not null default false;

-- Legacy table — optional; is_connect_mentor now uses subscriptions.is_admin
create table if not exists public.connect_mentor_config (
  id int primary key default 1,
  constraint connect_mentor_config_singleton check (id = 1),
  user_id uuid not null references auth.users(id) on delete cascade
);

alter table public.connect_mentor_config enable row level security;

drop policy if exists "Mentor reads own config" on public.connect_mentor_config;
create policy "Mentor reads own config"
  on public.connect_mentor_config for select
  using (auth.uid() = user_id);

create or replace function public.is_connect_mentor()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(
    (
      select s.is_admin
      from public.subscriptions s
      where s.user_id = auth.uid()
    ),
    false
  );
$$;

-- ── Slots ──
create table if not exists public.connect_slots (
  id bigint generated always as identity primary key,
  service_id text not null,
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  status text not null default 'available'
    check (status in ('available', 'reserved', 'paid', 'cancelled')),
  booked_by uuid references auth.users(id) on delete set null,
  razorpay_payment_id text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint connect_slots_time_valid check (ends_at > starts_at)
);

create index if not exists idx_connect_slots_service_starts
  on public.connect_slots (service_id, starts_at);

create index if not exists idx_connect_slots_status_starts
  on public.connect_slots (status, starts_at)
  where status = 'available';

alter table public.connect_slots enable row level security;

drop policy if exists "Read connect slots" on public.connect_slots;
create policy "Read connect slots"
  on public.connect_slots for select
  using (
    public.is_connect_mentor()
    or status = 'available'
    or booked_by = auth.uid()
  );

drop policy if exists "Mentor inserts connect slots" on public.connect_slots;
create policy "Mentor inserts connect slots"
  on public.connect_slots for insert
  with check (public.is_connect_mentor());

drop policy if exists "Mentor deletes available connect slots" on public.connect_slots;
create policy "Mentor deletes available connect slots"
  on public.connect_slots for delete
  using (public.is_connect_mentor() and status = 'available');

-- ── Mentor: create slot ──
-- Param order matches PostgREST (alphabetical: p_ends_at, p_service_id, p_starts_at).
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

-- ── Mentor: cancel available slot ──
create or replace function public.cancel_connect_slot(p_slot_id bigint)
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
  set status = 'cancelled', updated_at = now()
  where id = p_slot_id
    and status = 'available';

  if not found then
    raise exception 'slot not found or not available' using errcode = 'P0002';
  end if;
end;
$$;

-- ── Student: legacy RPC (disabled — booking happens in confirm_connect_slot_payment) ──
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

-- ── Mentor: release unpaid reserved hold (legacy data) ──
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

grant execute on function public.create_connect_slot(timestamptz, text, timestamptz) to authenticated;
grant execute on function public.cancel_connect_slot(bigint) to authenticated;
grant execute on function public.release_connect_slot(bigint) to authenticated;

-- ── Student: book slot after Razorpay payment (available → paid, atomic) ──
create or replace function public.confirm_connect_slot_payment(
  p_slot_id bigint,
  p_payment_id text,
  p_service_id text default null
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

  update public.connect_slots
  set status = 'paid',
      booked_by = auth.uid(),
      razorpay_payment_id = trim(p_payment_id),
      service_id = coalesce(nullif(trim(p_service_id), ''), service_id),
      updated_at = now()
  where id = p_slot_id
    and status = 'available'
    and starts_at > now()
  returning * into row;

  if not found then
    raise exception 'slot unavailable' using errcode = 'P0002';
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
