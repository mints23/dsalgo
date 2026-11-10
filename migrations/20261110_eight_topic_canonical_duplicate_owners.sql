-- Canonical-owner pass for exact duplicate problem placements across the pilot.
-- Secondary placements remain accessible as optional references; none are deleted or moved.
update public.problems
set is_required = false,
    curriculum_role = 'optional_reference',
    curriculum_path = null,
    curriculum_path_order = null,
    path_problem_order = null
where id in (
  9709,9714,       -- LC 438 / LC 3: Sliding Window owns the window mechanics
  9978,9979,9981, -- LC 435 / 452 / 45: Intervals owns these canonical interval formulations
  9986,9987,       -- LC 881 / 253: Two Pointers / Intervals own the canonical drills
  9998,            -- LC 1326: Intervals owns the interval-cover formulation
  10972,           -- LC 630: Greedy owns deadline scheduling with regret heap
  10980            -- LC 763: Greedy owns last-occurrence reach expansion
);

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
declare required_rows integer; complete_rows integer; missing_roles integer; duplicate_owners integer;
begin
  select count(*) into required_rows from public.problems
  where topic_id in (1,2,3,4,5,6,7,9) and is_required = true;
  select count(*) into complete_rows from public.problems
  where topic_id in (1,2,3,4,5,6,7,9) and is_required = true
    and curriculum_path is not null and curriculum_path_order is not null and path_problem_order is not null;
  select count(*) into missing_roles from public.problems
  where topic_id in (1,2,3,4,5,6,7,9) and is_required = true and curriculum_role is null;
  select count(*) into duplicate_owners from (
    select lc_number from public.problems
    where topic_id in (1,2,3,4,5,6,7,9) and is_required = true and lc_number in ('3','45','253','287','435','438','452','630','763','881','1074','1326','525','560','974')
    group by lc_number having count(*) > 1
  ) d;
  if required_rows <> 246 then raise exception 'Expected 246 canonical required placements, found %',required_rows; end if;
  if complete_rows <> required_rows then raise exception 'Path completeness mismatch: % of %',complete_rows,required_rows; end if;
  if missing_roles <> 0 then raise exception 'Required rows still have null roles: %',missing_roles; end if;
  if duplicate_owners <> 5 then raise exception 'Expected five intentional multi-pattern duplicates, found %',duplicate_owners; end if;
end $$;