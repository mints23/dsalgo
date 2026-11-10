-- Canonical ownership pass 2: remove duplicate formulations and placements whose claimed topic is not the actual algorithm.
-- All rows remain available as optional references; no problem/progress identity is deleted or rewritten.
begin;
update public.problems
set is_required=false,
    curriculum_role='optional_reference',
    curriculum_path=null,
    curriculum_path_order=null,
    path_problem_order=null
where id=any(array[10050,10895,10377,10943,10733,10548,10862,10566,10671,10313,10216,10299,10246,10570,10108,10572,10901]::bigint[])
  and is_required=true;
do $$
declare expected integer := 17; changed integer;
begin
 select count(*) into changed from public.problems
 where id=any(array[10050,10895,10377,10943,10733,10548,10862,10566,10671,10313,10216,10299,10246,10570,10108,10572,10901]::bigint[])
   and is_required=false and curriculum_role='optional_reference'
   and curriculum_path is null and curriculum_path_order is null and path_problem_order is null;
 if changed<>expected then raise exception 'Canonical-owner pass 2 expected %, found %',expected,changed; end if;
end $$;
with ranked as (
 select id,row_number() over(partition by topic_id,curriculum_path_order,curriculum_path order by order_num) next_path_order
 from public.problems where is_required=true
)
update public.problems p set path_problem_order=r.next_path_order from ranked r where p.id=r.id;
do $$
declare required_rows integer; complete_rows integer; missing_roles integer;
begin
 select count(*) into required_rows from public.problems where is_required=true;
 select count(*) into complete_rows from public.problems where is_required=true and curriculum_path is not null and curriculum_path_order is not null and path_problem_order is not null;
 select count(*) into missing_roles from public.problems where is_required=true and curriculum_role is null;
 if required_rows<>complete_rows then raise exception 'Path completeness failed: % required, % complete',required_rows,complete_rows; end if;
 if missing_roles<>0 then raise exception 'Missing required roles: %',missing_roles; end if;
end $$;
commit;