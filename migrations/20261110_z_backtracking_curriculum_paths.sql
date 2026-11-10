begin;

with assignments(problem_id, path_name, path_order, inferred_role) as (
  values
  (9939::bigint,'Subset and combination search',1,'core_pattern'),
  (9940::bigint,'Subset and combination search',1,'core_pattern'),
  (9942::bigint,'Subset and combination search',1,'core_pattern'),
  (9943::bigint,'Subset and combination search',1,'core_pattern'),
  (9944::bigint,'Subset and combination search',1,'core_pattern'),
  (9966::bigint,'Subset and combination search',1,'variant'),
  (9972::bigint,'Subset and combination search',1,'variant'),
  (9973::bigint,'Subset and combination search',1,'combination'),

  (9941::bigint,'Permutation and arrangement search',2,'core_pattern'),
  (9945::bigint,'Permutation and arrangement search',2,'core_pattern'),
  (9961::bigint,'Permutation and arrangement search',2,'combination'),
  (9970::bigint,'Permutation and arrangement search',2,'combination'),

  (9946::bigint,'String construction and partitioning',3,'variant'),
  (9947::bigint,'String construction and partitioning',3,'variant'),
  (9948::bigint,'String construction and partitioning',3,'variant'),
  (9954::bigint,'String construction and partitioning',3,'combination'),
  (9955::bigint,'String construction and partitioning',3,'combination'),
  (9957::bigint,'String construction and partitioning',3,'combination'),
  (9969::bigint,'String construction and partitioning',3,'combination'),
  (9971::bigint,'String construction and partitioning',3,'combination'),

  (9949::bigint,'Grid and graph constrained search',4,'variant'),
  (9950::bigint,'Grid and graph constrained search',4,'variant'),
  (9959::bigint,'Grid and graph constrained search',4,'combination'),
  (9964::bigint,'Grid and graph constrained search',4,'variant'),

  (9951::bigint,'Constraint satisfaction and branch-and-bound',5,'variant'),
  (9952::bigint,'Constraint satisfaction and branch-and-bound',5,'variant'),
  (9953::bigint,'Constraint satisfaction and branch-and-bound',5,'variant'),
  (9960::bigint,'Constraint satisfaction and branch-and-bound',5,'combination'),
  (9962::bigint,'Constraint satisfaction and branch-and-bound',5,'combination'),
  (9965::bigint,'Constraint satisfaction and branch-and-bound',5,'combination'),

  (9956::bigint,'Memoized and adversarial state search',6,'combination'),
  (9963::bigint,'Memoized and adversarial state search',6,'combination')
)
update public.problems p
set curriculum_path = a.path_name,
    curriculum_path_order = a.path_order,
    path_problem_order = p.order_num,
    curriculum_role = coalesce(p.curriculum_role, a.inferred_role)
from assignments a
where p.id = a.problem_id
  and p.topic_id = 8
  and p.is_required = true;

do $$
declare required_count integer; complete_count integer; role_count integer;
begin
  select count(*) into required_count from public.problems where topic_id=8 and is_required=true;
  select count(*) into complete_count from public.problems where topic_id=8 and is_required=true
    and curriculum_path is not null and curriculum_path_order is not null and path_problem_order is not null;
  select count(*) into role_count from public.problems where topic_id=8 and is_required=true and curriculum_role is not null;
  if required_count <> 35 or complete_count <> 35 or role_count <> 35 then
    raise exception 'Backtracking curriculum validation failed: required %, complete %, roles %', required_count, complete_count, role_count;
  end if;
end $$;

commit;