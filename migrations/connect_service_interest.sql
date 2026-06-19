-- Waitlist / interest for Connect services (e.g. DSA Classes coming soon).
-- Run in Supabase SQL Editor, then reload schema.

create table if not exists public.connect_service_interest (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  service_id text not null,
  note text,
  created_at timestamptz not null default now(),
  constraint connect_service_interest_user_service unique (user_id, service_id)
);

create index if not exists idx_connect_service_interest_service
  on public.connect_service_interest (service_id, created_at desc);

alter table public.connect_service_interest enable row level security;

-- Table is accessed via security definer RPCs only.

-- PostgREST uses alphabetical arg order; drop before replace when param names change.
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

  -- Release unpaid checkout holds (e.g. user joins waitlist instead of paying)
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

create or replace function public.has_connect_interest(p_service_id text)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.connect_service_interest i
    where i.user_id = auth.uid()
      and i.service_id = trim(p_service_id)
  );
$$;

grant execute on function public.register_connect_interest(text, text) to authenticated;
grant execute on function public.has_connect_interest(text) to authenticated;

-- Admin: list batch waitlist signups (email + optional note)
create or replace function public.list_connect_batch_interest(
  p_service_id text default 'dsa-classes'
)
returns json
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_connect_mentor() then
    raise exception 'mentor only' using errcode = '42501';
  end if;

  return (
    select coalesce(
      json_agg(row_to_json(t) order by t.created_at desc),
      '[]'::json
    )
    from (
      select
        i.id,
        i.user_id,
        u.email,
        i.service_id,
        i.note,
        i.created_at
      from public.connect_service_interest i
      join auth.users u on u.id = i.user_id
      where i.service_id = coalesce(nullif(trim(p_service_id), ''), 'dsa-classes')
      order by i.created_at desc
    ) t
  );
end;
$$;

grant execute on function public.list_connect_batch_interest(text) to authenticated;
