-- Refine path taxonomy after production verification.
-- Keep stable IDs, topic IDs, order_num, and progress keys unchanged.
update public.problems
set curriculum_path = 'Boundary scans and multi-pointer merges'
where topic_id = 1 and curriculum_path_order = 4 and is_required = true;

update public.problems
set curriculum_path = 'Boundary scans and multi-pointer merges',
    curriculum_path_order = 4
where id = 9652 and topic_id = 1 and is_required = true;

update public.problems
set curriculum_path = 'Interval algebra and range compression',
    curriculum_path_order = 1
where id = 10944 and topic_id = 6 and is_required = true;

update public.problems
set curriculum_path = 'Stateful and constrained greedy scans',
    curriculum_path_order = 3
where id = 10016 and topic_id = 9 and is_required = true;

with ranked as (
  select id,
         row_number() over (
           partition by topic_id,curriculum_path_order,curriculum_path
           order by order_num
         ) as next_path_order
  from public.problems
  where topic_id in (1,2,3,4,5,6,7,9) and is_required = true
)
update public.problems p
set path_problem_order = ranked.next_path_order
from ranked
where p.id = ranked.id;

do $$
declare incomplete integer; conflicts integer;
begin
  select count(*) into incomplete
  from public.problems
  where topic_id in (1,2,3,4,5,6,7,9) and is_required = true
    and (curriculum_path is null or curriculum_path_order is null or path_problem_order is null);
  if incomplete <> 0 then raise exception 'Incomplete path metadata after correction: %', incomplete; end if;

  select count(*) into conflicts from (
    select topic_id,curriculum_path_order
    from public.problems
    where topic_id in (1,2,3,4,5,6,7,9) and is_required = true
    group by topic_id,curriculum_path_order
    having count(distinct curriculum_path)>1
  ) x;
  if conflicts <> 0 then raise exception 'Path-order label conflicts after correction: %', conflicts; end if;
end $$;