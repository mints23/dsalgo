-- Remove Urgent Connect and Motivation from Connect pricing (keep in sync with src/data/connect-services.ts)
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
