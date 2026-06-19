-- Admin flag on the existing subscriptions row (same login/trial/Pro record).
-- Run in Supabase SQL Editor, then reload API schema.
--
-- Grant admin (replace email):
--   update public.subscriptions
--   set is_admin = true
--   where user_id = (select id from auth.users where email = 'you@example.com');

alter table public.subscriptions
  add column if not exists is_admin boolean not null default false;

comment on column public.subscriptions.is_admin is
  'Site admin: /admin slot tool, Connect mentor RPCs. Set via SQL only.';

-- Migrate legacy connect_mentor_config rows if that table exists
do $$
begin
  if exists (
    select 1 from information_schema.tables
    where table_schema = 'public' and table_name = 'connect_mentor_config'
  ) then
    update public.subscriptions s
    set is_admin = true
    from public.connect_mentor_config c
    where s.user_id = c.user_id;
  end if;
end $$;

-- Used by connect_slots RLS + /admin page
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
