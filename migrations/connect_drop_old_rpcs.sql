-- Run this FIRST if CREATE OR REPLACE fails with "cannot change name of input parameter".
-- Then re-run connect_service_interest.sql / connect_rpc_postgrest_fix.sql as needed.

drop function if exists public.register_connect_interest(text, text);
drop function if exists public.hold_connect_slot(bigint, text);
drop function if exists public.hold_connect_slot(text, bigint);
drop function if exists public.confirm_connect_slot_payment(bigint, text, text);
drop function if exists public.confirm_connect_slot_payment(text, text, bigint);
drop function if exists public.create_connect_slot(text, timestamptz, timestamptz);
drop function if exists public.create_connect_slot(timestamptz, text, timestamptz);
