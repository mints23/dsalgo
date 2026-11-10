-- Canonical ownership pass 6: correct a Prim-vs-Bellman-Ford misclassification and remove unsupported Knuth-optimisation claim.
begin;

update public.problems
set is_required=false,
    curriculum_role='optional_reference',
    curriculum_path=null,
    curriculum_path_order=null,
    path_problem_order=null
where id in (10496,10533,10908)
  and is_required=true;

-- The LC 1000 optional reference remains accessible, but its solution note must not teach an invalid optimisation.
update public.problems
set key_insight='Use K-way interval DP. A split point advances in steps of K−1; an interval can become one pile only when (length−1) mod (K−1) = 0. The standard recurrence is O(n³/K); Knuth optimisation is not generally valid for arbitrary K > 2.'
where id=10908;

-- Keep authored HTML and structured metadata consistent.
update public.topics
set body_html = replace(
  replace(body_html,
    'Knuth + K-way merge',
    'K-way interval DP'),
  'Hard: K-way + interval validity (length &equiv; 1 mod (K&minus;1)) + Knuth opt bounds simultaneously',
  'K-way interval DP: split points advance by K−1; only merge intervals with (length−1) mod (K−1) = 0. Standard recurrence is O(n³/K); Knuth optimisation is not generally valid for arbitrary K > 2.'
)
where id=42
  and body_html like '%Minimum Cost to Merge Stones%';

do $$
declare expected integer := 3; demoted integer; wrong_insight integer; authored_fix integer;
begin
 select count(*) into demoted from public.problems
 where id in (10496,10533,10908) and is_required=false
   and curriculum_role='optional_reference'
   and curriculum_path is null and curriculum_path_order is null and path_problem_order is null;
 if demoted<>expected then raise exception 'Canonical-owner pass 6 expected % optional placements, found %',expected,demoted; end if;
 select count(*) into wrong_insight from public.problems
 where id=10908 and key_insight like '%Knuth optimisation is not generally valid%';
 if wrong_insight<>1 then raise exception 'LC 1000 structured insight correction failed'; end if;
 select count(*) into authored_fix from public.topics
 where id=42 and body_html like '%Knuth optimisation is not generally valid%';
 if authored_fix<>1 then raise exception 'LC 1000 authored insight correction failed'; end if;
end $$;

with ranked as (
 select id,row_number() over(partition by topic_id,curriculum_path_order,curriculum_path order by order_num) next_path_order
 from public.problems where is_required=true
)
update public.problems p set path_problem_order=r.next_path_order from ranked r where p.id=r.id;

do $$
declare req integer; complete integer; missing_roles integer;
begin
 select count(*) into req from public.problems where is_required=true;
 select count(*) into complete from public.problems where is_required=true and curriculum_path is not null and curriculum_path_order is not null and path_problem_order is not null;
 select count(*) into missing_roles from public.problems where is_required=true and curriculum_role is null;
 if req<>complete then raise exception 'Required path completeness failed: % of %',complete,req; end if;
 if missing_roles<>0 then raise exception 'Required roles missing: %',missing_roles; end if;
end $$;
commit;