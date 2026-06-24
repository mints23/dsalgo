-- Exclude site admins from Pro subscribers (paid) list on /admin.
create or replace function public.list_paid_pro_subscribers()
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
      json_agg(row_to_json(t) order by t.paid_until asc),
      '[]'::json
    )
    from (
      select
        s.user_id,
        u.email,
        coalesce(
          nullif(trim(u.raw_user_meta_data->>'full_name'), ''),
          nullif(trim(u.raw_user_meta_data->>'name'), ''),
          split_part(u.email, '@', 1)
        ) as display_name,
        s.paid_until,
        s.razorpay_payment_id,
        s.updated_at
      from public.subscriptions s
      join auth.users u on u.id = s.user_id
      where s.status = 'active'
        and s.paid_until is not null
        and s.paid_until > now()
        and coalesce(s.is_admin, false) = false
        and coalesce(trim(s.razorpay_payment_id), '') not ilike 'manual_grant%'
      order by s.paid_until asc
    ) t
  );
end;
$$;
