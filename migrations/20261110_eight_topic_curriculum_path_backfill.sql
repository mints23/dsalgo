
-- Reviewed eight-topic curriculum classification and learning-path backfill.
-- Stable problem IDs, topic IDs, order_num values, and user_progress keys are untouched.
do $$
declare n integer;
begin
  select count(*) into n from public.problems
  where id in (9675,9676,9677,9678,9679,9686,9687,9727,9728,9730,9732,9733,9735,9736,9737,9738,9774,9776,9777,9778,9779,9780,9781,9782,9783,9811,9813,9827,9828,9829,9838,9839,9862,9863,9864,10972,10973,10974,10975,10979,10980,10981,9931,9932,9934,9935,10000,10001,10002,10003,10004,10005,10017,10018,10019,10020)
    and is_required = true and curriculum_role is null;
  if n <> 56 then
    raise exception 'Expected 56 required null-role rows to classify; found %', n;
  end if;
end $$;

update public.problems p
set curriculum_role = v.role
from (values
(9675,1,'core_pattern'),
(9676,1,'variant'),
(9677,1,'variant'),
(9678,1,'combination'),
(9679,1,'core_pattern'),
(9686,1,'combination'),
(9687,1,'combination'),
(9727,2,'core_pattern'),
(9728,2,'variant'),
(9730,2,'combination'),
(9732,2,'combination'),
(9733,2,'variant'),
(9735,2,'combination'),
(9736,2,'core_pattern'),
(9737,2,'core_pattern'),
(9738,2,'combination'),
(9774,3,'core_pattern'),
(9776,3,'variant'),
(9777,3,'combination'),
(9778,3,'core_pattern'),
(9779,3,'core_pattern'),
(9780,3,'core_pattern'),
(9781,3,'combination'),
(9782,3,'combination'),
(9783,3,'core_pattern'),
(9811,4,'combination'),
(9813,4,'combination'),
(9827,4,'combination'),
(9828,4,'core_pattern'),
(9829,4,'combination'),
(9838,4,'variant'),
(9839,4,'combination'),
(9862,5,'combination'),
(9863,5,'variant'),
(9864,5,'combination'),
(10972,6,'combination'),
(10973,6,'combination'),
(10974,6,'combination'),
(10975,6,'combination'),
(10979,6,'core_pattern'),
(10980,6,'combination'),
(10981,6,'core_pattern'),
(9931,7,'combination'),
(9932,7,'combination'),
(9934,7,'core_pattern'),
(9935,7,'core_pattern'),
(10000,9,'combination'),
(10001,9,'combination'),
(10002,9,'core_pattern'),
(10003,9,'combination'),
(10004,9,'combination'),
(10005,9,'core_pattern'),
(10017,9,'combination'),
(10018,9,'variant'),
(10019,9,'variant'),
(10020,9,'core_pattern')
) as v(id, topic_id, role)
where p.id = v.id and p.topic_id = v.topic_id
  and p.is_required = true and p.curriculum_role is null;

-- Explicitly out-of-scope or trap rows: retain their records, IDs, and placement order.
update public.problems
set is_required = false, curriculum_role = 'out_of_scope'
where id in (9669,9671,9672,9688,9729,9731,9734,9775,9812,9861,9865,9866,10977,9933);

update public.problems
set is_required = false, curriculum_role = 'excluded_trap'
where id = 10978;

-- Existing duplicate-topic entries remain available as optional references,
-- while their canonical learning objectives are taught in their owning topics.
update public.problems
set is_required = false, curriculum_role = 'optional_reference'
where id in (9661,9662,9663);

-- A date-arithmetic exercise is not an interval-algorithm exercise.
update public.problems
set is_required = false, curriculum_role = 'out_of_scope'
where id = 10953;

-- Correct misleading algorithm notes discovered during the review.
update public.problems
set key_insight = 'Dynamic programming over indices: for each destination j, consider earlier i only when abs(nums[j] - nums[i]) <= target. The transition is a maximum over a value-bounded predecessor range; a single running maximum is not sufficient for arbitrary value windows.'
where id = 9865;

update public.problems
set sub_variant = 'Ratio binary search + 0/1 knapsack feasibility',
    key_insight = 'Binary-search the optimal talent-to-weight ratio. For a candidate ratio r, transform each item to talent - r * weight and use 0/1 knapsack DP over total weight (capped at the required threshold) to test whether a non-negative transformed total is achievable.'
where id = 10004;

with retained as (
 select id,topic_id,order_num,sub_variant
 from public.problems
 where topic_id in (1,2,3,4,5,6,7,9) and is_required = true
),
classified as (
 select *,
 case topic_id
 when 1 then case
  when sub_variant ilike '%fast/slow%' then 'Fast/slow pointers and cycle detection'
  when sub_variant ilike '%three-pointer%' or sub_variant ilike '%four-pointer%' or sub_variant ilike '%opposite-end%' then 'Sorted pair and multi-pointer scans'
  when sub_variant ilike '%greedy%' then 'Greedy and boundary integrations'
  when sub_variant ilike '%two-pointer + sorting%' or sub_variant ilike '%two pointers on two%' or sub_variant ilike '%bus%' or sub_variant ilike '%anchors%' then 'Two-sequence and boundary scans'
  else 'Two-end scans and in-place transformations' end
 when 2 then case
  when sub_variant ilike '%prefix%' or sub_variant ilike '%first-seen%' then 'Prefix-state and indexed lookup'
  when sub_variant ilike '%clone%' or sub_variant ilike '%adjacency%' then 'Identity maps and graph construction'
  when sub_variant ilike '%dll%' or sub_variant ilike '%composite%' or sub_variant ilike '%frequency stack%' or sub_variant ilike '%inverted%' or sub_variant ilike '%bidirectional%' or sub_variant ilike '%heap%' or sub_variant ilike '%binary search%' then 'Stateful maps and composite structures'
  when sub_variant ilike '%sliding window%' then 'Window and frequency-map integration'
  when sub_variant ilike '%dp%' then 'Set membership with DP and search'
  else 'Frequency, grouping and complement lookup' end
 when 3 then case
  when sub_variant ilike '%answer space (minimize)%' then 'Minimize a feasible answer'
  when sub_variant ilike '%answer space (maximize)%' then 'Maximize a feasible answer'
  when sub_variant ilike '%lis array%' then 'LIS tails and binary search'
  when sub_variant ilike '%floating point%' or sub_variant ilike '%greedy validation%' then 'Greedy and continuous feasibility'
  when sub_variant ilike '%pigeonhole%' or sub_variant ilike '%row-wise count%' then 'Value-domain counting'
  when sub_variant ilike '%answer space%' then 'Count-based answer search'
  else 'Search boundaries, rotations and ordered structures' end
 when 4 then case
  when sub_variant ilike '%deque%' or sub_variant ilike '%two heaps%' then 'Monotonic deque and window order statistics'
  when sub_variant ilike '%complement%' or sub_variant ilike '%prefix + suffix%' or sub_variant ilike '%two-pointer binary search%' then 'Complement windows and sorted joins'
  when sub_variant ilike '%fixed window%' then 'Fixed-size windows'
  when sub_variant ilike '%sorted%' then 'Sorted-value windows'
  when sub_variant ilike '%distinct%' or sub_variant ilike '%freq%' or sub_variant ilike '%exact-k%' or sub_variant ilike '%atmost%' or sub_variant ilike '%replacement%' then 'Frequency, distinctness and exact-K windows'
  else 'Variable-size windows and counting' end
 when 5 then case
  when sub_variant ilike '%deque%' then 'Constrained DP and monotonic deque'
  when sub_variant ilike '%2d%' or sub_variant ilike '%k non-overlapping%' or sub_variant ilike '%two non-overlapping%' or sub_variant ilike '%dual-array%' or sub_variant ilike '%two-path%' then 'Multi-segment and multidimensional extensions'
  when sub_variant ilike '%char%' or sub_variant ilike '%counting%' then 'Scored and counted subarray variants'
  else 'Maximum and minimum subarray state' end
 when 6 then case
  when sub_variant ilike '%weighted interval%' then 'Weighted interval scheduling'
  when sub_variant ilike '%dynamic%' or sub_variant ilike '%calendar%' or sub_variant ilike '%booking%' or sub_variant ilike '%segment tree%' or sub_variant ilike '%incremental%' then 'Dynamic interval structures'
  when sub_variant ilike '%sweep%' or sub_variant ilike '%skyline%' or sub_variant ilike '%difference array%' or sub_variant ilike '%2d interval%' then 'Sweep line and range aggregation'
  when sub_variant ilike '%room%' or sub_variant ilike '%overlap%' or sub_variant ilike '%partitioning%' then 'Overlap detection and interval partitioning'
  when sub_variant ilike '%cover%' or sub_variant ilike '%stabbing%' or sub_variant ilike '%activity%' or sub_variant ilike '%non-overlapping%' or sub_variant ilike '%arrows%' or sub_variant ilike '%implicit interval%' or sub_variant ilike '%min interval per query%' then 'Greedy coverage and interval selection'
  else 'Interval algebra and range compression' end
 when 7 then case
  when sub_variant ilike '%difference%' then 'Difference arrays and range updates'
  when sub_variant ilike '%fenwick%' or sub_variant ilike '%bit%' or sub_variant ilike '%segment tree%' then 'Dynamic prefix aggregates and Fenwick trees'
  when sub_variant ilike '%merge sort%' or sub_variant ilike '%hash map%' or sub_variant ilike '%modular%' or sub_variant ilike '%set intersection%' then 'Prefix-state counting and modular arithmetic'
  when sub_variant ilike '%2d%' then 'Two-dimensional prefix and difference methods'
  when sub_variant ilike '%product%' or sub_variant ilike '%xor%' then 'Prefix products and XOR states'
  else 'Static prefix aggregates and transforms' end
 when 9 then case
  when sub_variant ilike '%matroid%' then 'Matroid and exchange-proof greedy'
  when sub_variant ilike '%monotone stack%' then 'Monotone-stack greedy'
  when sub_variant ilike '%heap%' or sub_variant ilike '%regret%' or sub_variant ilike '%delayed decision%' then 'Heap scheduling and deferred decisions'
  when sub_variant ilike '%activity selection%' or sub_variant ilike '%interval coverage%' or sub_variant ilike '%prefix-reach%' then 'Reachability, coverage and activity selection'
  when sub_variant ilike '%sliding window%' or sub_variant ilike '%binary search%' then 'Greedy feasibility with search and windows'
  when sub_variant ilike '%bit groups%' then 'Bitwise and invariant-driven greedy'
  when sub_variant ilike '%group-and-keep%' or sub_variant ilike '%range tracking%' or sub_variant ilike '%two-pass%' or sub_variant ilike '%circular scan%' then 'Stateful and constrained greedy scans'
  else 'Sorting, exchange arguments and local choices' end
 end as path_name
 from retained
),
ordered as (
 select *,case topic_id
 when 1 then case path_name when 'Sorted pair and multi-pointer scans' then 1 when 'Fast/slow pointers and cycle detection' then 2 when 'Two-end scans and in-place transformations' then 3 when 'Two-sequence and boundary scans' then 4 else 5 end
 when 2 then case path_name when 'Frequency, grouping and complement lookup' then 1 when 'Prefix-state and indexed lookup' then 2 when 'Window and frequency-map integration' then 3 when 'Stateful maps and composite structures' then 4 when 'Identity maps and graph construction' then 5 else 6 end
 when 3 then case path_name when 'Search boundaries, rotations and ordered structures' then 1 when 'Value-domain counting' then 2 when 'Minimize a feasible answer' then 3 when 'Maximize a feasible answer' then 4 when 'Count-based answer search' then 5 when 'Greedy and continuous feasibility' then 6 else 7 end
 when 4 then case path_name when 'Variable-size windows and counting' then 1 when 'Frequency, distinctness and exact-K windows' then 2 when 'Fixed-size windows' then 3 when 'Monotonic deque and window order statistics' then 4 when 'Complement windows and sorted joins' then 5 else 6 end
 when 5 then case path_name when 'Maximum and minimum subarray state' then 1 when 'Scored and counted subarray variants' then 2 when 'Multi-segment and multidimensional extensions' then 3 else 4 end
 when 6 then case path_name when 'Interval algebra and range compression' then 1 when 'Greedy coverage and interval selection' then 2 when 'Overlap detection and interval partitioning' then 3 when 'Weighted interval scheduling' then 4 when 'Dynamic interval structures' then 5 else 6 end
 when 7 then case path_name when 'Static prefix aggregates and transforms' then 1 when 'Prefix-state counting and modular arithmetic' then 2 when 'Two-dimensional prefix and difference methods' then 3 when 'Difference arrays and range updates' then 4 when 'Prefix products and XOR states' then 5 else 6 end
 when 9 then case path_name when 'Sorting, exchange arguments and local choices' then 1 when 'Reachability, coverage and activity selection' then 2 when 'Stateful and constrained greedy scans' then 3 when 'Heap scheduling and deferred decisions' then 4 when 'Monotone-stack greedy' then 5 when 'Greedy feasibility with search and windows' then 6 when 'Matroid and exchange-proof greedy' then 7 else 8 end
 end as path_order
 from classified
),
ranked as (
 select *,row_number() over(partition by topic_id,path_order,path_name order by order_num) as path_problem_order
 from ordered
)
update public.problems p
set curriculum_path = r.path_name,
    curriculum_path_order = r.path_order,
    path_problem_order = r.path_problem_order
from ranked r
where p.id = r.id;

do $$
declare n_required integer; n_complete integer; n_null_roles integer; n_bad_paths integer;
begin
 select count(*) into n_required from public.problems
 where topic_id in (1,2,3,4,5,6,7,9) and is_required=true;
 select count(*) into n_complete from public.problems
 where topic_id in (1,2,3,4,5,6,7,9) and is_required=true
   and curriculum_path is not null and curriculum_path_order is not null and path_problem_order is not null;
 select count(*) into n_null_roles from public.problems
 where topic_id in (1,2,3,4,5,6,7,9) and is_required=true and curriculum_role is null;
 select count(*) into n_bad_paths from (
   select topic_id,curriculum_path_order
   from public.problems
   where topic_id in (1,2,3,4,5,6,7,9) and is_required=true
   group by topic_id,curriculum_path_order
   having count(distinct curriculum_path)>1
 ) x;
 if n_required <> n_complete then raise exception 'Path backfill incomplete: required %, complete %', n_required,n_complete; end if;
 if n_null_roles <> 0 then raise exception 'Required rows still have null curriculum_role: %',n_null_roles; end if;
 if n_bad_paths <> 0 then raise exception 'Conflicting path labels share a path order in % topic/order groups',n_bad_paths; end if;
end $$;
