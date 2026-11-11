-- Fourth semantic gap pass from the 3,549-row LeetCode dump.
-- Adds validated GCD, time-dependent shortest-path, partition-DP and geometry patterns.
begin;

update public.topic_content
set sub_variants = sub_variants || '[
 "Divisor-sieve characterisation of all attainable subsequence GCDs",
 "LCM frontier for contiguous ranges with a bounded target and monotone early termination",
 "Two-dimensional GCD-state DP for pairs of disjoint subsequences"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Count all distinct GCDs obtainable from non-empty subsequences when values are bounded","breaks_when":"The value domain is too large for scanning every possible divisor or the input permits zero/negative values outside the proof assumptions","sub_variant":"For each candidate g, scan its present multiples and compute their GCD; g is achievable exactly when that GCD equals g"},
 {"trigger":"Count subarrays whose LCM equals a fixed positive target k","breaks_when":"Values are large and LCM arithmetic can overflow; use gcd reduction and stop as soon as LCM exceeds k","sub_variant":"Extend each start/end range; LCM is monotone non-decreasing, and any value not dividing k or any LCM > k makes all longer extensions invalid"},
 {"trigger":"Count pairs of disjoint subsequences with equal GCDs","breaks_when":"The numeric value bound is too large for a dense gcd-state DP","sub_variant":"DP over (gcd1,gcd2); each item is assigned to neither subsequence, the first, or the second, maintaining disjointness by construction"}
]'::jsonb,
core_idea = core_idea || E'\n\nSubsequence-GCD divisor scan: a value g can be the GCD of some non-empty subsequence only if every chosen element is a multiple of g. Taking all available multiples cannot increase their GCD beyond g; therefore g is achievable exactly when the GCD of all input values divisible by g equals g. Iterate candidate g over the bounded value domain and scan its multiples. This is a divisor sieve, not the subarray frontier (subarrays have contiguous endpoints).\n\nLCM target windows: for a fixed left endpoint, extending the right endpoint can only keep or increase the LCM. If an element does not divide k, or the running LCM exceeds k, no longer extension can return to k. Use gcd before multiplication and check the threshold to avoid overflow.\n\nDisjoint-subsequence GCD DP: maintain counts for pairs (g1,g2). Each new element can be skipped, appended to the first subsequence, or appended to the second; gcd(0,x)=x seeds an empty side. Because each input index chooses at most one destination, the two subsequences remain disjoint.'
where topic_id=10
and not (sub_variants @> '["Divisor-sieve characterisation of all attainable subsequence GCDs"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '["Time-dependent Dijkstra with alternating move costs / phase-aware transitions"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"The time to traverse an edge depends on the move phase (for example, alternate one-second and two-second moves) and vertices have earliest-entry times","breaks_when":"Travel-time transitions violate FIFO or a time-dependent edge can improve by deliberately delaying at a non-waitable vertex","sub_variant":"Represent phase explicitly in the state, or infer it from a bipartite grid colour when every move flips colour; relax arrival = max(currentTime, openTime[next]) + phaseCost"}]'::jsonb,
core_idea = core_idea || E'\n\nPhase-dependent travel time: ordinary Dijkstra can still be used when the earliest-arrival transition is FIFO. If move cost alternates by step, the state must include the phase (next move costs 1 or 2); on a bipartite grid, the phase may be inferred from cell-colour parity because every move flips colour. Combine phase cost with a cell opening time using max(currentTime, openTime[next]) + moveCost(phase). For a general graph without a parity invariant, expand the graph to (vertex, phase) states.'
where topic_id=25
and not (sub_variants @> '["Time-dependent Dijkstra with alternating move costs / phase-aware transitions"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '["Sorted-value row/column DP with same-value batch updates to prevent equal-value transitions"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"A matrix move may go to any strictly larger value in the same row or column, and the matrix is too large to build all row/column edges","breaks_when":"Equal values are allowed as transitions or the graph has additional adjacency constraints","sub_variant":"Process cells in ascending value order; query rowMax and colMax for the best smaller-value path, then batch all cells with the same value before updating those maxima"}]'::jsonb,
core_idea = core_idea || E'\n\nImplicit row/column DAG DP: cells are vertices and a directed edge exists from a cell to every strictly larger cell in its row or column. Materialising all such edges can be quadratic. Sort cells by value; dp[cell] = 1 + max(bestForRow[row], bestForColumn[col]). Crucially, evaluate all cells with the same value before updating row/column maxima, otherwise equal values incorrectly chain into one another despite the strict-increase rule. This is an alternative to DFS+memo on an implicit matrix graph.'
where topic_id=31
and not (sub_variants @> '["Sorted-value row/column DP with same-value batch updates to prevent equal-value transitions"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '[
 "Partition DP with two monotone validity bounds and a sliding minimum of transformed predecessor costs",
 "Monotonic-stack DP for maximising the number of non-decreasing segment sums after adjacent merges"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Partition an ordered sequence into batches with both a maximum count and maximum total weight; each batch cost depends on adjacent category changes","breaks_when":"Feasible predecessor indices are not a contiguous sliding interval or the transformed predecessor cost is not stable","sub_variant":"Prefix sums determine a monotone valid-start interval; transform the DP cost so the remaining predecessor term is constant, then maintain its minimum in a monotone deque or range-min structure"},
 {"trigger":"Merge adjacent subarrays into a non-decreasing sequence of segment sums and maximise the number of resulting segments","breaks_when":"Elements may be negative, so prefix-sum monotonicity and the stack dominance proof no longer hold","sub_variant":"Use prefix sums and a DP state representing the best number of completed segments; maintain only non-dominated boundary candidates in a monotonic stack"}
]'::jsonb,
core_idea = core_idea || E'\n\nBounded-batch partition DP: let dp[i] be the minimum cost for the first i items. A batch [j,i) is feasible when i−j≤maxCount and prefixWeight[i]−prefixWeight[j]≤maxWeight. If the batch cost decomposes into a term depending only on i plus a predecessor term dp[j]−changePrefix[j+1], the answer is a sliding minimum over a monotonically advancing valid-start interval. A monotone deque gives amortised O(1) insertion/expiry/query; a segment tree is a general range-min alternative.\n\nNon-decreasing segment-sum partition DP: merging adjacent elements means choosing a partition whose segment sums are non-decreasing. The transition compares the new segment sum with the previous segment sum; prefix sums express a candidate segment sum as a difference of prefixes. A monotone stack retains only predecessor boundaries that are not dominated in both DP value and required previous sum. State and stack invariants must be proved carefully; the positivity constraint is essential.'
where topic_id=42
and not (sub_variants @> '["Partition DP with two monotone validity bounds and a sliding minimum of transformed predecessor costs"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '[
 "Minimum path through a rectangle with circular obstacles via circle-intersection DSU and boundary-side connectivity",
 "Minimum-area rectangle in arbitrary orientation via equal-length diagonals with a common midpoint"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Determine whether two opposite rectangle corners can be connected inside a rectangle while avoiding a union of circular obstacles","breaks_when":"The path may touch rectangle boundaries elsewhere, obstacles are non-circular, or the obstacle-boundary intersection predicate is approximate","sub_variant":"Build a graph of circles and four rectangle sides; union intersecting/touching circles and circle-side contacts; test whether a blocking component connects one of the separating side pairs"},
 {"trigger":"Find the minimum-area rectangle from a small set of points when sides need not be axis-aligned","breaks_when":"Point count is too large for diagonal-pair enumeration or floating-point hashing is used for geometric keys","sub_variant":"A rectangle's diagonals have equal length and the same midpoint; group point pairs by doubled midpoint and squared diagonal length, then combine pairs and compute area by a cross product"}
]'::jsonb,
core_idea = core_idea || E'\n\nCircular-obstacle connectivity: a continuous path is blocked when a connected union of circles forms a barrier between the relevant sides of the rectangle. Create DSU nodes for every circle and each of the four rectangle sides. Union two circles when their closed disks intersect or touch; union a circle with every side segment it intersects. The path is impossible when one obstacle component connects a separating pair of sides (the four forbidden pairs are determined by the start/end corner topology). Use exact squared-distance predicates and explicit circle-to-segment distance checks; circles outside the rectangle may still matter only if they intersect its boundary or another blocking circle.\n\nArbitrary-orientation rectangles: in any rectangle the diagonals are equal and bisect one another. For each point pair as a candidate diagonal, key it by (x1+x2, y1+y2, squaredLength), avoiding fractions and floating-point hashing. Two distinct diagonals with the same key define four rectangle corners. Compute the area as the absolute cross product of two adjacent side vectors and take the minimum positive area. This detects rotated rectangles that axis-aligned coordinate-pair methods miss.'
where topic_id=48
and not (sub_variants @> '["Minimum path through a rectangle with circular obstacles via circle-intersection DSU and boundary-side connectivity"]'::jsonb);

-- Distinct additional examples: required for new reusable invariants, optional for narrower/overlapping applications.
insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(10,24,'Hard','1819','https://leetcode.com/problems/number-of-different-subsequences-gcds/','Number of Different Subsequences GCDs','Hard',false,'Divisor-sieve characterisation of attainable subsequence GCDs','A candidate g is the GCD of some non-empty subsequence iff the GCD of all present input values divisible by g is exactly g. Scan g over the bounded value domain and aggregate gcd over its multiples. This turns subsequence enumeration into a divisor sieve; it is distinct from maintaining GCD frontiers for contiguous subarrays.',true,'combination','GCD/LCM frontiers and divisor counting',6,2),
(10,25,'Variants','2470','https://leetcode.com/problems/number-of-subarrays-with-lcm-equal-to-k/','Number of Subarrays With LCM Equal to K','Med',false,'Monotone LCM extension with target divisibility pruning','For each left endpoint, extend the right endpoint while maintaining lcm. LCM never decreases; if an element does not divide k or the running LCM exceeds k, no longer extension can become k. Compute lcm as (a/gcd(a,b))*b and guard multiplication. The input bound permits O(n²) with early termination.',false,'optional_reference',null,null,null),
(10,26,'Hard','3336','https://leetcode.com/problems/find-the-number-of-subsequences-with-equal-gcd/','Find the Number of Subsequences With Equal GCD','Hard',false,'Two-dimensional GCD-state DP for disjoint subsequence pairs','Maintain dp[g1][g2] counts for two subsequences. For each input x, choose exactly one of three actions: skip x, assign x to subsequence 1, or assign it to subsequence 2. Update gcd states with gcd(0,x)=x. This enforces disjointness by construction and counts ordered pairs of non-empty subsequences with equal GCD.',false,'optional_reference',null,null,null),
(25,22,'Variants','3342','https://leetcode.com/problems/find-minimum-time-to-reach-last-room-ii/','Find Minimum Time to Reach Last Room II','Med',false,'Phase-aware Dijkstra with alternating one/two-second movement','The next move costs 1 or 2 seconds according to the move phase. On a grid, every step flips checkerboard colour, so phase is implied by cell parity; in a general graph, explicitly expand to (vertex, phase). The earliest-arrival relaxation is max(currentTime, openTime[next]) + moveCost(phase). This combines time-window constraints with state-dependent edge costs.',true,'variant','State-expanded and time-constrained shortest paths',4,5),
(31,32,'Hard','2713','https://leetcode.com/problems/maximum-strictly-increasing-cells-in-a-matrix/','Maximum Strictly Increasing Cells in a Matrix','Hard',false,'Sorted-value row/column DP with same-value batch updates','Sort cells by value. The best path ending at cell (r,c) is 1 + max(bestRow[r],bestCol[c]), where the row/column maxima contain only strictly smaller values. Evaluate all cells of one equal value before updating either maximum; updating one-by-one would create illegal equal-value transitions. O(mn log(mn)).',false,'optional_reference',null,null,null),
(42,28,'Hard','1687','https://leetcode.com/problems/delivering-boxes-from-storage-to-ports/','Delivering Boxes from Storage to Ports','Hard',false,'Partition DP with count/weight bounds and monotone-deque predecessor minimum','Let dp[i] be the minimum trips for the first i boxes. Prefix weights and box count define a sliding valid predecessor interval. The trips for a batch decompose into the number of port changes plus a constant, so transform the predecessor term to dp[j]−changePrefix[j+1]. Maintain the minimum over valid j with a monotone deque; every index enters and leaves once. O(n) time, O(n) space.',true,'optimization','Constrained partition DP and monotonic predecessor structures',5,1),
(42,29,'Hard','2945','https://leetcode.com/problems/find-maximum-non-decreasing-array-length/','Find Maximum Non-decreasing Array Length','Hard',false,'Monotonic-stack optimisation for non-decreasing segment-sum partition DP','After merging adjacent values, the goal is a partition with non-decreasing segment sums. Prefix sums express each candidate segment sum as a difference of prefix values. The DP keeps the best number of segments and the minimum previous-segment sum needed; a monotonic stack removes dominated predecessor boundaries. Positivity of nums is essential to the dominance argument.',true,'optimization','Constrained partition DP and monotonic predecessor structures',5,2),
(48,20,'Hard','3235','https://leetcode.com/problems/check-if-the-rectangle-corner-is-reachable/','Check if the Rectangle Corner Is Reachable','Hard',false,'Circle-obstacle barrier connectivity with DSU','Model every circle and each rectangle side as a DSU node. Union circles whose disks overlap or touch, and union a circle with every rectangle side it intersects. The path is blocked when one obstacle component connects a separating pair of sides (left-right, left-bottom, right-top or top-bottom). Use squared distances for circle-circle tests and exact point-to-segment distance predicates for circle-side contacts.',true,'combination','Circle geometry and enclosing disks',5,2),
(48,21,'Hard','963','https://leetcode.com/problems/minimum-area-rectangle-ii/','Minimum Area Rectangle II','Med',false,'Rotated rectangle detection through equal-length diagonals and common midpoint','A rectangle''s diagonals have equal length and the same midpoint. Group unordered point pairs by (x1+x2,y1+y2,squaredDiagonalLength). Two non-identical pairs in one group are its diagonals; compute area with the absolute cross product of adjacent side vectors. With n≤50, pair grouping plus combinations is feasible and avoids floating-point midpoint keys.',true,'variant','Arbitrary-orientation rectangles',8,1);

-- Update the relevant topic counts/labels.
update public.topics set summary_meta='26 problems · sieve, SPF, totient, segmented, Möbius, GCD/LCM frontiers and subsequence-GCD divisor sieves' where id=10;
update public.topics set summary_meta='22 problems · classic, minimax, grid, implicit, state-expanded and time-dependent Dijkstra' where id=25;
update public.topics set summary_meta='32 problems · path DP, multi-agent, grid states, sorted row/column DP and histogram reductions' where id=31;
update public.topics set summary_meta='29 problems · deque DP, segment-tree DP, CHT, divide-and-conquer, Knuth, CDQ and monotonic-stack partition DP' where id=42;
update public.topics set summary_meta='20 problems · predicates, polygons, hulls, sweeps, circle barriers, enclosing disks, rotated rectangles and Manhattan transforms' where id=48;

do $$
declare seq_name text;
begin
  seq_name := pg_get_serial_sequence('public.problems','id');
  if seq_name is not null then
    perform setval(seq_name, greatest((select coalesce(max(id),1) from public.problems), 1), true);
  end if;
end $$;

commit;
