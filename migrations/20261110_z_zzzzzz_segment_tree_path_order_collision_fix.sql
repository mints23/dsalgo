-- Correct a path-order collision in Segment Tree discovered by the final invariant audit.
-- Point-update/range-query is the foundation; lazy propagation and advanced paths follow it.
begin;
update public.problems
set curriculum_path='Point updates and range queries',
    curriculum_path_order=1,
    path_problem_order=1
where id=10060 and topic_id=12 and is_required=true;

update public.problems
set curriculum_path_order=curriculum_path_order+1
where topic_id=12 and is_required=true and id<>10060
  and curriculum_path_order>=1;

with ranked as (
 select id,row_number() over(partition by topic_id,curriculum_path_order,curriculum_path order by order_num) next_order
 from public.problems where topic_id=12 and is_required=true
)
update public.problems p set path_problem_order=r.next_order
from ranked r where p.id=r.id;

do $$
declare collisions integer; req integer; complete integer;
begin
 select count(*) into collisions from (
   select curriculum_path_order from public.problems
   where topic_id=12 and is_required=true
   group by curriculum_path_order having count(distinct curriculum_path)>1
 ) x;
 select count(*) into req from public.problems where topic_id=12 and is_required=true;
 select count(*) into complete from public.problems where topic_id=12 and is_required=true
   and curriculum_path is not null and curriculum_path_order is not null
   and path_problem_order is not null and curriculum_role is not null;
 if collisions<>0 then raise exception 'Segment Tree path order collision remains: %',collisions; end if;
 if req<>complete then raise exception 'Segment Tree required rows incomplete: % of %',complete,req; end if;
end $$;
commit;