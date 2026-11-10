-- Classify an existing non-required custom interval reference.
-- It remains optional and does not affect required path counts or progress.
update public.problems
set curriculum_role = 'optional_reference'
where id = 10976
  and topic_id = 6
  and is_required = false
  and curriculum_role is null;

do $$
begin
  if exists (
    select 1 from public.problems
    where id = 10976 and topic_id = 6
      and is_required = false and curriculum_role is null
  ) then
    raise exception 'Offline Stabbing Queries optional reference was not classified';
  end if;
end $$;