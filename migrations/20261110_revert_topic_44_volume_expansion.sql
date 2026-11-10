-- Corrective migration: revert the temporary Topic 44 insertion.
-- The requested curriculum audit is volume-neutral; bit manipulation remains a concept
-- inventory/reclassification candidate, not an additional question bank.
begin;
delete from public.problems where topic_id = 44;
delete from public.topic_content where topic_id = 44;
delete from public.topics where id = 44;
commit;
