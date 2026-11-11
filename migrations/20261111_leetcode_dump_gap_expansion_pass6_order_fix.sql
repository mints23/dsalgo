-- Preserve the visible progression order in Topic 25 after adding LC 3341.
begin;
update public.problems set order_num = 23 where topic_id = 25 and lc_number = '3342';
update public.problems set order_num = 22 where topic_id = 25 and lc_number = '3341';
commit;
