-- Canonical ownership pass 1: demote only exact duplicate or clearly misclassified secondary placements.
-- Keep every problem record and progress identity. Optional references remain accessible in the UI.
begin;

update public.problems
set is_required = false,
    curriculum_role = 'optional_reference',
    curriculum_path = null,
    curriculum_path_order = null,
    path_problem_order = null
where id = any(array[10672,10385,10381,10379,10383,10542,10380,10382,10682,10552,10880,10568,10214,10361,10317,10311,10573,10673,10550,10555,10284,10362,10762,10297,10551,10737,9956,10560,10323,9994,10547,10219,9782,10569,10583,9995,10549,10314,10107,10213,10930,10335,10210,10152,10287,10151,10294,10378,9989,10148,10286,10321,10559,10965,10139,10322,10324,10338,10615,10220,10221,10305,10334,10307,10306,10557,10336,10289,10298,10866,10308,10575,10585,10466,10222,10408,10869,10293,10193,10815,10140,10579,10337,10254,10471,10341,10342,10424,10477,10476,10250,10217,10223,10231,10345,10407,10881,10242,10328,10942,10109,10580,10108,10572,10255]::bigint[])
  and is_required = true;

do $$
declare expected integer := 105; changed integer;
begin
  select count(*) into changed
  from public.problems
  where id = any(array[10672,10385,10381,10379,10383,10542,10380,10382,10682,10552,10880,10568,10214,10361,10317,10311,10573,10673,10550,10555,10284,10362,10762,10297,10551,10737,9956,10560,10323,9994,10547,10219,9782,10569,10583,9995,10549,10314,10107,10213,10930,10335,10210,10152,10287,10151,10294,10378,9989,10148,10286,10321,10559,10965,10139,10322,10324,10338,10615,10220,10221,10305,10334,10307,10306,10557,10336,10289,10298,10866,10308,10575,10585,10466,10222,10408,10869,10293,10193,10815,10140,10579,10337,10254,10471,10341,10342,10424,10477,10476,10250,10217,10223,10231,10345,10407,10881,10242,10328,10942,10109,10580,10108,10572,10255]::bigint[])
    and is_required = false
    and curriculum_role = 'optional_reference'
    and curriculum_path is null
    and curriculum_path_order is null
    and path_problem_order is null;
  if changed <> expected then
    raise exception 'Canonical-owner pass 1 expected % optional placements, found %', expected, changed;
  end if;
end $$;

with ranked as (
  select id,
         row_number() over (
           partition by topic_id,curriculum_path_order,curriculum_path
           order by order_num
         ) as next_path_order
  from public.problems
  where is_required = true
)
update public.problems p
set path_problem_order = ranked.next_path_order
from ranked
where p.id = ranked.id;

do $$
declare required_rows integer; complete_rows integer; missing_roles integer;
begin
  select count(*) into required_rows from public.problems where is_required = true;
  select count(*) into complete_rows from public.problems
   where is_required = true and curriculum_path is not null
     and curriculum_path_order is not null and path_problem_order is not null;
  select count(*) into missing_roles from public.problems
   where is_required = true and curriculum_role is null;
  if required_rows <> complete_rows then
    raise exception 'Required path completeness failed: % required, % complete', required_rows, complete_rows;
  end if;
  if missing_roles <> 0 then
    raise exception 'Required curriculum roles missing: %', missing_roles;
  end if;
end $$;

commit;