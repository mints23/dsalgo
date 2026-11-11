-- Second semantic gap pass from the 3,549-row LeetCode dump.
-- Adds only distinct algorithmic invariants/representations identified in the audit.
-- Existing IDs and progress remain untouched; additive and idempotent.
begin;

-- Extend Number Theory: compressed GCD frontiers for all subarrays and GCD-pair inversion queries.
update public.topic_content
set sub_variants = sub_variants || '[
 "Distinct GCD frontier for all subarrays ending at each position; merge equal gcd states and aggregate counts",
 "LCM frontier for bounded-target subarray aggregation with early overflow/threshold termination",
 "Möbius/divisor inversion to count and order all pairwise GCD values"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Count subarrays whose GCD equals a target, with n too large for enumerating every subarray","breaks_when":"The number of distinct GCD states per endpoint is not bounded by the value bit width for the chosen operation/domain","sub_variant":"Maintain the compressed list of distinct GCDs for subarrays ending at the current index; gcd is idempotent and each strict change reduces the value by a factor"},
 {"trigger":"Answer order-statistic queries over all pairwise GCD values","breaks_when":"The value domain is too large for divisor enumeration or the number of queries is tiny","sub_variant":"Count pairs with gcd divisible by d, then use divisor Möbius inversion to recover exact-gcd frequencies and prefix counts"}
]'::jsonb,
core_idea = core_idea || E'\n\nSubarray GCD frontier: for each right endpoint, retain only distinct GCD values of subarrays ending there, together with their multiplicities. Extending every prior state with the new value maps g to gcd(g,x); adjacent/equal results coalesce, so the frontier has only O(log A) distinct values for positive values bounded by A. This is a different compression from a prefix-sum map: the aggregation operator is idempotent and monotonically decreases the positive GCD. For LCM, the value is monotone increasing; stop once it exceeds the target or a safe bound. Pairwise-GCD order statistics use a different divisor-counting/Möbius inversion argument.'
where topic_id=10
and not (sub_variants @> '["Distinct GCD frontier for all subarrays ending at each position; merge equal gcd states and aggregate counts"]'::jsonb);

-- Segment tree: search for first position meeting a threshold (leftmost feasible / first fit).
update public.topic_content
set sub_variants = sub_variants || '["Leftmost-position / first-fit search by descending on a segment-tree maximum or feasibility aggregate"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"For each request, find the leftmost index whose capacity is at least x, then consume or update that position","breaks_when":"The aggregate is not sufficient to decide whether an entire child interval contains a valid position","sub_variant":"Store the maximum in each segment; descend left if left.max ≥ x, otherwise right; update the selected leaf and recompute ancestors"}]'::jsonb,
core_idea = core_idea || E'\n\nFirst-fit segment-tree descent: a normal range query returns an aggregate, but a first-fit query must locate the earliest index satisfying a predicate. Store a node summary that can prove whether its interval contains any feasible position (for capacity, the maximum). If the left child can satisfy the request, descend left; otherwise descend right. This is O(log n), and the leaf can be consumed/updated after assignment. The proof is that the left-first descent preserves the invariant that the answer lies in the chosen child.'
where topic_id=12
and not (sub_variants @> '["Leftmost-position / first-fit search by descending on a segment-tree maximum or feasibility aggregate"]'::jsonb);

-- Heap / ordered structures: sliding trimmed mean with three partitions and maintained sum.
update public.topic_content
set sub_variants = sub_variants || '["Sliding-window trimmed mean / MKAverage with three ordered partitions and a maintained middle sum"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Maintain the average after discarding the k smallest and k largest values from the last m stream items","breaks_when":"The window is not bounded or a value-domain frequency tree is simpler for the constraints","sub_variant":"Partition the window into low, middle and high ordered multisets; maintain the sum of the middle partition and rebalance sizes after insert/expiry"}]'::jsonb,
core_idea = core_idea || E'\n\nTrimmed-window order statistics: maintain exactly k smallest values in a low partition, k largest in a high partition, and all remaining values in a middle partition whose sum is tracked. Every insertion and expiry can initially violate size/order invariants; move boundary elements between partitions until sizes are correct and low.max ≤ mid.min ≤ mid.max ≤ high.min. MKAverage is floor(middleSum/(m−2k)). Duplicates require multiset semantics, not plain sets.'
where topic_id=15
and not (sub_variants @> '["Sliding-window trimmed mean / MKAverage with three ordered partitions and a maintained middle sum"]'::jsonb);

-- BFS with a successor structure to enumerate each reachable interval index only once.
update public.topic_content
set sub_variants = sub_variants || '["BFS with successor-DSU / next-unvisited structure to skip already-discovered indices in parity-constrained intervals"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"A BFS state can reach a contiguous interval of indices, but scanning that interval for every state is quadratic","breaks_when":"A discovered index may become reachable again through a later transition or the reachable set is not deletable monotonically","sub_variant":"Maintain unvisited indices by parity (or another invariant) in a successor DSU; extract and delete each newly discovered index from the relevant interval"}]'::jsonb,
core_idea = core_idea || E'\n\nSuccessor-DSU BFS: some state transitions reach an interval of candidate indices, often with a parity restriction. A naive BFS loops over every index in each interval and revisits already-discovered positions. Maintain a successor structure that returns the next not-yet-visited index; once an index is discovered, delete it from the unvisited set by linking it to its successor. Each index is extracted at most once, so total interval enumeration is near-linear apart from sorting/initialisation and BFS overhead.'
where topic_id=20
and not (sub_variants @> '["BFS with successor-DSU / next-unvisited structure to skip already-discovered indices in parity-constrained intervals"]'::jsonb);

-- Topological order subset DP: states are ideals/down-sets of the prerequisite partial order.
update public.topic_content
set sub_variants = sub_variants || '["Bitmask DP over valid topological prefixes / order ideals of a DAG"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Choose a valid topological ordering of a small DAG and optimise a score depending on the position of each chosen vertex","breaks_when":"The number of vertices is too large for O(2^n) states or the objective has a simpler DAG recurrence","sub_variant":"DP[mask] over already placed vertices; a vertex is addable only when all predecessors are in mask; transition to mask∪{v}"}]'::jsonb,
core_idea = core_idea || E'\n\nTopological-order subset DP: a bitmask is valid only when it forms an order ideal—all predecessors of every selected vertex are also selected. From a valid prefix mask, a vertex v is an available next choice exactly when v is not selected and all its prerequisites are selected. Transition to mask∪{v}, adding the position-dependent score. This optimises over valid linear extensions of a partial order; ordinary Kahn sorting only finds an order and does not optimise over all valid orders.'
where topic_id=24
and not (sub_variants @> '["Bitmask DP over valid topological prefixes / order ideals of a DAG"]'::jsonb);

-- DSU extensions: same-time temporary connectivity, weighted consistency and component aggregates.
update public.topic_content
set sub_variants = sub_variants || '[
 "Time-batched DSU: union all edges at one timestamp, propagate from seeded components, then reset unseeded temporary components",
 "Potential / weighted DSU with cycle-consistency contradiction detection",
 "Reverse-time DSU for vertex/edge deletions with component-sum or maximum-component aggregates",
 "Component-level bitwise aggregate (for example, AND of all edges in a connected component)"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Edges/meetings at the same timestamp can transitively propagate information, but information must not leak to later timestamps unless the component is seeded","breaks_when":"An unseeded component can become connected to a seeded component only at a later timestamp; processing events one at a time changes semantics","sub_variant":"Group events by time, union the whole batch, propagate from the known source, then reset parents for batch components not connected to the source"},
 {"trigger":"Relations between variables are multiplicative/additive and a new equation may contradict an existing path","breaks_when":"The relation is not representable as a group potential or numeric precision is insufficient","sub_variant":"Weighted DSU stores each node''s potential to its representative; on a same-root edge compare the implied relation to detect inconsistency"},
 {"trigger":"Connectivity changes are deletions and the query asks component sums/maxima after each deletion","breaks_when":"Deletions are online and cannot be reversed or all future operations are unknown","sub_variant":"Process deletions in reverse as insertions; merge components and maintain root aggregates"}
]'::jsonb,
core_idea = core_idea || E'\n\nTime-batched DSU is not ordinary online union: process all edges at the same time as one graph, because paths through same-time meetings can propagate transitively. After identifying the components that contain a known source, reset every temporary component not connected to that source before moving to the next timestamp. Weighted DSU stores a potential from each node to its root; joining two nodes already in the same component permits an equation-consistency check. Reverse-time DSU turns deletions into insertions and can maintain component aggregates such as size, sum or maximum.'
where topic_id=28
and not (sub_variants @> '["Time-batched DSU: union all edges at one timestamp, propagate from seeded components, then reset unseeded temporary components"]'::jsonb);

-- Advanced graph: answer bottleneck threshold queries through a spanning tree path maximum + LCA.
update public.topic_content
set sub_variants = sub_variants || '["Minimum-bottleneck connectivity queries via an MST/maximum spanning forest plus LCA path-maximum queries"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Many queries ask whether two vertices are connected using only edges below a query-specific weight threshold","breaks_when":"Queries are online with arbitrary edge updates or the graph is directed","sub_variant":"Build a minimum spanning forest; the maximum edge on the unique tree path is the minimum possible bottleneck; answer path maxima with binary lifting/LCA"}]'::jsonb,
core_idea = core_idea || E'\n\nBottleneck connectivity through an MST: in a minimum spanning forest, the maximum edge on the unique path between u and v equals the minimum possible maximum edge over all u-v paths in the original graph. Therefore a query with limit L is true exactly when that tree-path maximum is < L. Precompute LCA ancestors with maximum-edge aggregates and answer each query in O(log n). This is an MST + tree-path query combination, not a partially persistent DSU.'
where topic_id=29
and not (sub_variants @> '["Minimum-bottleneck connectivity queries via an MST/maximum spanning forest plus LCA path-maximum queries"]'::jsonb);

-- Game theory: residue classes provide a small strategic state.
update public.topic_content
set sub_variants = sub_variants || '["Modulo-residue games: reduce moves to residue counts and derive winning/losing conditions by case analysis"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Removing an item changes a running sum modulo a small modulus, and a player loses when the sum hits a forbidden residue","breaks_when":"The actual values have additional move constraints not captured by residue classes or order matters","sub_variant":"Classify moves by residue, count each class, and derive the forced response/losing position under optimal play"}]'::jsonb,
core_idea = core_idea || E'\n\nModulo-residue game analysis: when the terminal condition depends only on a running sum modulo m, replace raw values with residue classes. The game state can often be compressed to the counts of remaining residues plus whose turn it is. Derive losing positions by considering the opponent''s forced responses; do not assume the game is ordinary Nim or apply XOR of pile sizes without proving impartial-game independence.'
where topic_id=37
and not (sub_variants @> '["Modulo-residue games: reduce moves to residue counts and derive winning/losing conditions by case analysis"]'::jsonb);

-- Combinatorics: stars and bars, lexicographic rank/unrank, and information capacity.
update public.topic_content
set sub_variants = sub_variants || '[
 "Stars and bars for distributing prime exponents among ordered factors",
 "Lexicographic rank/unranking of multiset permutations using multinomial completion counts",
 "Information-theoretic capacity: encode hidden states as outcome strings across repeated tests"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Factor k into prime powers and count ordered n-tuples whose product is k","breaks_when":"Zeros, signs or non-integer factors are allowed","sub_variant":"For each prime exponent e, distribute e indistinguishable copies among n ordered slots: C(e+n−1,n−1); multiply across primes"},
 {"trigger":"Find the k-th lexicographic distinct permutation of a multiset or palindrome","breaks_when":"The number of arrangements exceeds the exact arithmetic range and completion counts are not capped safely","sub_variant":"At each position, tentatively choose each available symbol in sorted order; count completions with multinomial coefficients and skip whole lexicographic blocks"},
 {"trigger":"A single test can produce one of q outcomes and tests are repeated to identify one of N possibilities","breaks_when":"Test outcomes are not independent or the process does not allow all q outcomes to be distinguished","sub_variant":"Encode candidates as length-t strings over q outcomes; require q^t ≥ N and interpret each experiment as one digit"}
]'::jsonb,
core_idea = core_idea || E'\n\nStars and bars with prime exponents: after factorising a target product k=∏p_i^{e_i}, each exponent e_i must be distributed among n ordered array positions. For each prime independently, the number of nonnegative distributions is C(e_i+n−1,n−1); multiply these counts modulo p.\n\nLexicographic multiset unranking: the number of completions after choosing a candidate symbol is a multinomial coefficient. Select a symbol by comparing k with that block size; subtract entire blocks when skipped, then continue on the suffix. For palindromes, construct only the first half and mirror it.\n\nInformation capacity: t independent tests with q distinguishable outcomes can encode at most q^t states. This gives a lower bound on the number of tests and a constructive strategy when outcomes can be assigned as base-q digits.'
where topic_id=41
and not (sub_variants @> '["Stars and bars for distributing prime exponents among ordered factors"]'::jsonb);

-- Bitwise AND frontiers are the monotone dual of the OR-frontier technique already taught.
update public.topic_content
set sub_variants = sub_variants || '[
 "Distinct bitwise-AND frontier for all subarrays ending at each position",
 "Bitwise-AND frontier combined with partition DP and endpoint-range optimisation"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Count subarrays by their bitwise AND value across a long array","breaks_when":"The number of distinct frontier states is not bounded by the bit width or per-value counts cannot be aggregated","sub_variant":"For each right endpoint, transform the prior distinct AND states with x, append x, merge equal values and add their multiplicities"},
 {"trigger":"Partition an array into segments whose bitwise AND must match a target sequence","breaks_when":"The number of target segments/state transitions makes the frontier too large for the given constraints","sub_variant":"Maintain the monotone AND frontier for each endpoint, then relax the DP only across the endpoint range that produces the required AND"}
]'::jsonb,
core_idea = core_idea || E'\n\nBitwise AND frontier: for fixed right endpoint, the AND of a subarray can only stay the same or lose set bits as the left endpoint moves left. Keep only distinct AND values and their multiplicities; when a new x is appended, transform every prior frontier value g to g & x, merge duplicates, and add the singleton x. The number of distinct values is bounded by the number of bits because each strict change clears at least one bit. This is the monotone dual of the bitwise-OR frontier already covered. Partition DP can use ranges of endpoints that share the same AND result.'
where topic_id=44
and not (sub_variants @> '["Distinct bitwise-AND frontier for all subarrays ending at each position"]'::jsonb);

-- Advanced strings: rolling-hash equality queries can support a DP over repeated deletions.
update public.topic_content
set sub_variants = sub_variants || '["Rolling-hash substring equality embedded in prefix DP for repeated-prefix deletions"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"A DP transition is allowed when two adjacent substrings of equal length are identical, and many equality checks are required","breaks_when":"Hash collisions cannot be tolerated and no deterministic verification is added","sub_variant":"Prefix rolling hashes compare the two blocks in O(1); use double hashing or verify candidate transitions, then relax the prefix DP"}]'::jsonb,
core_idea = core_idea || E'\n\nRolling-hash + deletion DP: define dp[i] as the best number of operations for a prefix ending at i. A transition exists when the suffix block immediately before i equals the adjacent block of the same length, allowing that block to be deleted and the remaining prefix to continue. Prefix hashes make each equal-length block comparison O(1), but the algorithm remains probabilistic unless double hashing or verification is used. This is a useful example of a string data structure serving as a fast transition predicate inside DP.'
where topic_id=46
and not (sub_variants @> '["Rolling-hash substring equality embedded in prefix DP for repeated-prefix deletions"]'::jsonb);

-- Geometry: fixed-radius circle centre enumeration, Welzl minimum enclosing circle and L1 transforms.
update public.topic_content
set sub_variants = sub_variants || '[
 "Fixed-radius circle coverage by enumerating candidate centres through pairs of boundary points",
 "Minimum enclosing circle via Welzl randomized incremental construction",
 "Manhattan metric transform: (x,y) → (x+y,x−y) to reduce L1 diameter to extrema",
 "Closest-pair extensions under Manhattan distance and orthogonal range constraints"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Find the maximum number of points covered by a circle of fixed radius","breaks_when":"The input is large enough that O(n³) pair-centre enumeration is infeasible","sub_variant":"An optimal circle can be shifted until two points lie on its boundary; enumerate the one or two candidate centres for every pair and count covered points"},
 {"trigger":"Find the smallest circle containing all points","breaks_when":"Deterministic worst-case complexity is required or numeric predicates are not robust","sub_variant":"Welzl randomized incremental algorithm with a boundary set of at most three points; expected linear time under random order"},
 {"trigger":"Minimise the maximum Manhattan distance after removing one point","breaks_when":"The metric is Euclidean or more than one point must be removed","sub_variant":"Transform each point to u=x+y and v=x−y; L1 distance becomes max(|Δu|,|Δv|), so diameter is determined by extrema in transformed coordinates"}
]'::jsonb,
core_idea = core_idea || E'\n\nFixed-radius circle coverage: an optimal radius-r disk can be translated until at least two input points lie on its boundary. For a pair at distance ≤2r, the possible centre(s) lie at the midpoint plus/minus the perpendicular offset of length sqrt(r²−d²/4). Enumerate these centres and count contained points.\n\nMinimum enclosing circle: Welzl''s randomized incremental algorithm maintains the minimum circle for the processed prefix with at most three boundary points; a newly outside point becomes a boundary constraint and recursively rebuilds the circle. Random permutation gives expected linear time; numeric robustness and degeneracies need explicit treatment.\n\nManhattan transform: define u=x+y and v=x−y. Then |dx|+|dy| = max(|du|,|dv|). Thus the Manhattan diameter is the maximum range of u or v; removing one point can be evaluated by tracking first/second extrema and their multiplicities.'
where topic_id=48
and not (sub_variants @> '["Fixed-radius circle coverage by enumerating candidate centres through pairs of boundary points"]'::jsonb);

-- Add concrete problem placements. Exact order/path positions are fixed and unique.
insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(10,22,'Variants','2447','https://leetcode.com/problems/number-of-subarrays-with-gcd-equal-to-k/','Number of Subarrays With GCD Equal to K','Med',false,'Distinct GCD frontier','For each right endpoint, maintain distinct GCD values of subarrays ending here and the number of subarrays producing each value. Extend each prior state g to gcd(g,x), merge equal results, and add the singleton x. The frontier has O(log A) distinct positive GCD values because every strict change decreases the value by at least a factor of two. This avoids O(n²) subarray enumeration.',true,'core_pattern','GCD/LCM frontiers and divisor counting',6,1),
(10,23,'Hard','3312','https://leetcode.com/problems/sorted-gcd-pair-queries/','Sorted GCD Pair Queries','Hard',false,'Möbius/divisor inversion for GCD-pair order statistics','Count how many input values are divisible by each d; this yields the number of index pairs whose GCD is a multiple of d. Process d in descending order and subtract contributions of proper multiples to recover the exact frequency of gcd=d (divisor Möbius inversion). Prefix counts over d answer each k-th-smallest query by binary search or cumulative scanning.',false,'optional_reference',null,null,null),
(12,23,'Variants','3479','https://leetcode.com/problems/fruits-into-baskets-iii/','Fruits Into Baskets III','Med',false,'Segment-tree first fit / leftmost feasible capacity','Sort/coordinate-compress basket capacities if needed, but preserve original-index priority. Store maximum remaining capacity in each segment-tree node. For each fruit x, descend left whenever the left child maximum is at least x; otherwise descend right. Consume the selected basket by setting its leaf to −∞. O((n+m)log n).',true,'variant','Search, dynamic domains and advanced trees',5,6),
(15,53,'Hard','1825','https://leetcode.com/problems/finding-mk-average/','Finding MK Average','Hard',false,'Sliding-window trimmed mean with three ordered partitions','Maintain the last m values split into low (k smallest), middle (m−2k values), and high (k largest) ordered multisets. Track the middle sum. On insertion and expiry, repair size and ordering invariants by moving boundary values between partitions. Return floor(middleSum/(m−2k)) when the window is full; handle duplicates with multiset counts.',false,'optional_reference',null,null,null),
(20,40,'Hard','2612','https://leetcode.com/problems/minimum-reverse-operations/','Minimum Reverse Operations','Hard',false,'BFS with parity-aware successor DSU','From a position p, reversing a length-k subarray maps the 1 to a contiguous interval of destination indices with parity determined by k and p. Maintain unvisited indices separately by parity in successor DSU structures. During BFS, repeatedly extract and delete every unvisited index in the reachable interval; each index is discovered once. This avoids scanning overlapping intervals repeatedly.',true,'combination','State-space BFS and implicit graphs',3,12),
(24,23,'Hard','3530','https://leetcode.com/problems/maximum-profit-from-valid-topological-order-in-dag/','Maximum Profit from Valid Topological Order in DAG','Hard',false,'Bitmask DP over topological prefixes / order ideals','dp[mask] is the best score after placing exactly the vertices in mask. A vertex v can be appended only when all its predecessors are already in mask. Its positional contribution is score[v]×(popcount(mask)+1). This explores all valid linear extensions in O(2^n·(n+m)) and relies on n being small.',true,'combination','Subset DP over topological orders',5,1),
(28,21,'Hard','2092','https://leetcode.com/problems/find-all-people-with-secret/','Find All People With Secret','Hard',false,'Time-batched DSU with selective reset','Sort meetings by time and process each timestamp as a batch: union every meeting in the batch before deciding who learns the secret, so same-time transitive propagation works. After the batch, retain the components connected to person 0 and reset every other temporary component to singletons. Processing meetings one-by-one is incorrect when a chain of meetings shares a timestamp.',true,'combination','Time-batched and weighted connectivity',4,1),
(28,22,'Hard','2307','https://leetcode.com/problems/check-for-contradictions-in-equations/','Check for Contradictions in Equations','Hard',true,'Weighted DSU consistency check','Represent variables as nodes and equations as multiplicative edge constraints. A weighted DSU stores each node''s ratio to its representative. When an equation joins nodes already in the same component, compare the implied ratio with the new constraint (within tolerance); a mismatch proves a contradiction. DFS over the equation graph is an alternative for smaller inputs.',false,'optional_reference',null,null,null),
(28,23,'Hard','2382','https://leetcode.com/problems/maximum-segment-sum-after-removals/','Maximum Segment Sum After Removals','Hard',false,'Reverse-time DSU with component sums and global maximum','Process removals backwards as insertions. Each inserted position creates a component with its own value; union with active neighbours and maintain the sum at the root. Update the global maximum after each reverse insertion; write the answer before undoing each forward removal. This is the standard offline transformation from deletion to insertion.',false,'optional_reference',null,null,null),
(28,24,'Hard','3108','https://leetcode.com/problems/minimum-cost-walk-in-weighted-graph/','Minimum Cost Walk in Weighted Graph','Hard',false,'DSU component aggregate: bitwise AND of all edge weights','For each connected component, aggregate the bitwise AND of every edge weight. Once u and v are connected, a walk may traverse edges repeatedly and the AND can include all edge weights in that component; the answer is the component aggregate. This is not a shortest-path problem: revisiting edges is allowed and bitwise AND only clears bits.',false,'optional_reference',null,null,null),
(29,29,'Hard','1724','https://leetcode.com/problems/checking-existence-of-edge-length-limited-paths-ii/','Checking Existence of Edge Length Limited Paths II','Hard',true,'Bottleneck path queries via MST + LCA path maximum','Build a minimum spanning forest. For any two connected vertices, the maximum edge on their unique MST path is the minimum achievable bottleneck over all original graph paths. Root each tree and binary-lift ancestors while storing maximum edge on each jump; answer each threshold query by the path maximum. This is a reusable MST + LCA combination.',true,'combination','MST variants and graph optimisation',4,4),
(37,30,'Med','2029','https://leetcode.com/problems/stone-game-ix/','Stone Game IX','Med',false,'Modulo-3 residue game strategy','Only the counts of stones with residues 0, 1 and 2 modulo 3 matter. A move that makes the running sum divisible by 3 loses immediately. Analyse the forced opening (remove a residue-1 or residue-2 stone), then reason about paired residue-1/residue-2 responses and the parity of residue-0 stones. Derive the winning condition rather than applying ordinary Nim XOR.',true,'variant','Impartial games, Nim and Grundy theory',1,10),
(41,17,'Hard','1735','https://leetcode.com/problems/count-ways-to-make-array-with-product/','Count Ways to Make Array With Product','Hard',false,'Stars and bars over prime exponents','Prime-factorise k=∏p^e. For each prime independently, distribute exponent e among n ordered array positions as non-negative integers; stars and bars gives C(e+n−1,n−1). Multiply the counts modulo 1e9+7, using factorials and modular inverses. This combines SPF/factorisation with combinatorial distribution.',true,'combination','Stars and bars and multiplicative distributions',4,1),
(41,18,'Hard','3518','https://leetcode.com/problems/smallest-palindromic-rearrangement-ii/','Smallest Palindromic Rearrangement II','Hard',false,'Lexicographic unranking of multiset permutations','A palindromic permutation is determined by its first half and optional centre character. At each half-position, try remaining characters in sorted order; the number of completions after choosing c is a multinomial coefficient from the remaining half-counts. Skip whole lexicographic blocks until the block containing k is found, then mirror the constructed half.',true,'combination','Combinatorial counting, permutations and order statistics',2,8),
(41,19,'Hard','1830','https://leetcode.com/problems/minimum-number-of-operations-to-make-string-sorted/','Minimum Number of Operations to Make String Sorted','Hard',false,'Lexicographic rank of a multiset permutation','The operations enumerate previous lexicographic permutations, so the answer is the rank of s among distinct permutations. At each position, count all lexicographically smaller available characters and multiply by the number of suffix permutations after each choice; use factorials and inverse factorials for multinomial counts. This is the ranking counterpart of k-th permutation unranking.',false,'optional_reference',null,null,null),
(41,20,'Hard','458','https://leetcode.com/problems/poor-pigs/','Poor Pigs','Hard',false,'Information-theoretic capacity and base-q outcome encoding','Each pig can produce q=minutesToTest/minutesToDie+1 distinguishable outcomes across the test rounds. With p pigs, the combined outcome space has q^p states, so require q^p≥buckets. Constructively, assign each bucket a base-q code and let each pig encode one digit through its death round (or survival). This is a state-capacity argument, not a search DP.',false,'optional_reference',null,null,null),
(44,17,'Hard','3209','https://leetcode.com/problems/number-of-subarrays-with-and-value-of-k/','Number of Subarrays With AND Value of K','Hard',false,'Distinct bitwise-AND frontier','For each right endpoint, maintain distinct AND results of all subarrays ending there and their counts. Extend each prior result g to g & x, merge equal results, and add the singleton x. Each strict change clears at least one bit, so there are O(B) distinct frontier values for B-bit inputs; sum counts for the target k.',true,'variant','Monotone bitwise frontiers and partition DP',5,1),
(44,18,'Hard','3117','https://leetcode.com/problems/minimum-sum-of-values-by-dividing-array/','Minimum Sum of Values by Dividing Array','Hard',false,'Bitwise-AND frontier combined with partition DP','Use dp over the number of target segments and the endpoint of the current segment. For each endpoint, compressed AND states identify contiguous ranges of possible segment starts that produce the required AND value; relax the minimum previous DP value over those ranges. The AND frontier changes only O(B) times per endpoint, avoiding enumeration of all segment starts.',true,'optimization','Monotone bitwise frontiers and partition DP',5,2),
(46,9,'Hard','2430','https://leetcode.com/problems/maximum-deletions-on-a-string/','Maximum Deletions on a String','Hard',false,'Rolling-hash equality queries inside prefix DP','Let dp[i] be the maximum deletions for the prefix ending at i. A prefix can be deleted in one move when it equals the adjacent block of the same length; prefix rolling hashes test each candidate equality in O(1), then DP relaxes the reachable prefix. Use double hashing or verify matches because a single hash is probabilistic.',true,'combination','Rolling hash with prefix DP',6,1),
(48,14,'Hard','1453','https://leetcode.com/problems/maximum-number-of-darts-inside-of-a-circular-dartboard/','Maximum Number of Darts Inside of a Circular Dartboard','Hard',false,'Fixed-radius circle centre enumeration','For any pair of points at distance at most 2r, calculate the one or two centres of radius-r circles passing through both points. Count all points within each candidate circle and take the maximum. An optimum can be shifted until at least two points lie on its boundary. O(n^3) is acceptable for the small n constraint; use squared-distance checks where possible.',true,'variant','Circle geometry and enclosing disks',5,1),
(48,15,'Hard','1924','https://leetcode.com/problems/erect-the-fence-ii/','Erect the Fence II','Hard',true,'Welzl randomized incremental minimum enclosing circle','Randomly permute the points and incrementally maintain the smallest circle containing the processed prefix, with at most three boundary points. When a point lies outside the current circle, rebuild the constrained circle through the boundary set. Expected linear time relies on random order; handle collinear triples and floating-point tolerance explicitly.',false,'optional_reference',null,null,null),
(48,16,'Hard','3102','https://leetcode.com/problems/minimize-manhattan-distances/','Minimize Manhattan Distances','Hard',false,'L1-to-L-infinity transform and extrema under one deletion','Transform each point (x,y) to u=x+y and v=x−y. Manhattan distance equals max(|Δu|,|Δv|), so the maximum pairwise distance is max(range(u),range(v)). To remove exactly one point, track first/second minima and maxima (with multiplicities) in both transformed coordinates and evaluate the remaining ranges for each removal candidate.',true,'combination','Manhattan geometry and metric transforms',6,1),
(48,17,'Hard','2613','https://leetcode.com/problems/beautiful-pairs/','Beautiful Pairs','Hard',true,'Closest pair under Manhattan metric with ordered range structures','This is a closest-pair problem under L1 distance with additional index/coordinate constraints. Sort by one coordinate and maintain a range-query structure over the other coordinate to prune candidate comparisons; the structure choice and coordinate transformation must follow the exact constraints. Kept optional because the statement is paywalled in this dump and the hint is not sufficient to teach the full invariant.',false,'optional_reference',null,null,null);

-- Additional problem metadata and counts.
update public.topics set summary_meta='23 problems · sieve, SPF, totient, segmented, Möbius and subarray GCD frontiers' where id=10;
update public.topics set summary_meta='23 problems · lazy propagation, DP nodes, persistent, beats, first-fit search, wavelet and treap' where id=12;
update public.topics set summary_meta='53 problems · top-K, k-way merge, dual heaps, scheduling, regret, selection and order statistics' where id=15;
update public.topics set summary_meta='40 problems · reachability, grid, implicit state, 0-1 BFS and successor-DSU pruning' where id=20;
update public.topics set summary_meta='23 problems · Kahn, DFS postorder, DAG DP, derived DAGs and subset topological-order DP' where id=24;
update public.topics set summary_meta='24 problems · DSU, Kruskal, weighted/potential DSU, time batches, reverse time and aggregates' where id=28;
update public.topics set summary_meta='29 problems · bridges, SCC, Euler paths, MST, flow and 2-SAT' where id=29;
update public.topics set summary_meta='30 problems · impartial games, Nim, Grundy, minimax, feedback search and residue games' where id=37;
update public.topics set summary_meta='20 problems · counting DP mod p, nCr, Stirling, Catalan, inclusion-exclusion, stars and bars, rank/unrank' where id=41;
update public.topics set summary_meta='18 problems · XOR invariants, bit counting, range operations, Gray code, SOS DP, XOR basis and AND frontiers' where id=44;
update public.topics set summary_meta='9 problems · rolling hash, suffix arrays, LCP, suffix automata, Manacher, weighted segmentation and hash-DP' where id=46;
update public.topics set summary_meta='17 problems · predicates, polygons, hulls, closest pair, sweeps, circle geometry and Manhattan transforms' where id=48;

do $$
declare seq_name text;
begin
  seq_name := pg_get_serial_sequence('public.problems','id');
  if seq_name is not null then
    perform setval(seq_name, greatest((select coalesce(max(id),1) from public.problems), 1), true);
  end if;
end $$;

commit;
