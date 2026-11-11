-- Sixth semantic gap pass: add the remaining high-value patterns found in the dump.
-- Seven required placements establish missing interview techniques and progression;
-- three optional references preserve specialised breadth without bloating the core path.
begin;

-- Topic 8: backtracking in an unknown, action-only environment.
update public.topic_content
set sub_variants = sub_variants || '["Unknown-grid exploration with relative coordinates, orientation state and reversible DFS backtracking"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"The grid is not supplied; an agent exposes only move, turn and clean operations, and the task is to visit every reachable cell","breaks_when":"The environment cannot be safely reversed after recursive exploration, or the objective is a globally optimal weighted route rather than exhaustive coverage","sub_variant":"Assign relative coordinates from the start, track visited cells and facing direction, DFS through each unvisited open neighbour, then physically reverse the last move and restore the original orientation"}]'::jsonb,
core_idea = core_idea || E'\n\nUnknown-grid exploration with reversible robot DFS: the map is not given, so the algorithm constructs a virtual coordinate system rooted at (0,0). Track (row,column) and direction; clean each newly discovered cell once and try the four directions. When move() succeeds, recurse into the neighbour. On return, turn 180 degrees, move back to the parent, and restore the original facing direction. The key invariant is that every recursive call begins at its recorded virtual coordinate with the expected heading, and every completed child call restores the robot to its parent. A visited set prevents cycles. Each reachable cell is explored once, giving O(V) cell visits and O(V) map/recursion space.'
where topic_id = 8
and not (sub_variants @> '["Unknown-grid exploration with relative coordinates, orientation state and reversible DFS backtracking"]'::jsonb);

-- Topic 10: modular exponentiation and a GCD reachability invariant.
update public.topic_content
set sub_variants = sub_variants || '[
 "Modular exponentiation with a large exponent represented as base-B digits",
 "GCD invariants for reachability under subtraction and coordinate doubling"
]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Compute a^b mod M when b is too large for a machine integer and is supplied as its digits","breaks_when":"The modulus is not fixed or modular multiplication can overflow the chosen numeric type without a safe multiplication strategy","sub_variant":"Process exponent digits left-to-right in base B: ans = ans^B * a^digit mod M; implement modular exponentiation by repeated squaring"},
 {"trigger":"Determine whether a coordinate pair is reachable when operations subtract one coordinate from the other or double one coordinate","breaks_when":"The allowed operations differ so that the GCD can change by factors other than powers of two","sub_variant":"Track gcd(x,y): subtraction preserves it, while doubling one coordinate can only preserve it or multiply it by two; a necessary and sufficient target condition is that the GCD is a power of two"}
]'::jsonb,
core_idea = core_idea || E'\n\nLarge-exponent modular power: when the exponent is represented as decimal digits, never parse it into a primitive integer. If the processed prefix has value q and the next digit is d, the new prefix is 10q+d, so update ans = ans^10 × a^d mod M. Compute each small exponent by repeated squaring, reducing after every multiplication. This is digit-DP over the exponent representation, not ordinary binary exponentiation over a machine integer.\n\nGCD reachability invariant: subtraction operations (x,y)→(x,y−x) or (x−y,y) preserve gcd(x,y). Doubling one coordinate changes the GCD from g to either g or 2g, so starting from gcd(1,1)=1, every reachable target must have a power-of-two GCD. Reversing the operations or applying the constructive reduction proves sufficiency. The essential interview move is to search for a quantity preserved by most operations and only changed in a tightly bounded way.'
where topic_id = 10
and not (sub_variants @> '["Modular exponentiation with a large exponent represented as base-B digits"]'::jsonb);

-- Topic 11: value-predecessor queries plus a suffix aggregate.
update public.topic_content
set sub_variants = sub_variants || '["Ordered-set predecessor query paired with suffix maxima for increasing-triplet optimisation"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"For each middle index j, choose the best earlier value strictly below nums[j] and the best later value strictly above nums[j]","breaks_when":"The objective or constraints do not decompose around a fixed middle index, or values cannot be ordered consistently","sub_variant":"Precompute suffix maxima; scan the middle index left-to-right while maintaining an ordered set of prior values and query its strict predecessor. A Fenwick tree with coordinate compression can implement the predecessor by rank"}]'::jsonb,
core_idea = core_idea || E'\n\nPredecessor plus suffix maximum: fix the middle index j of an increasing triplet. The best right value is the suffix maximum strictly after j. The best left value is the largest previously seen value strictly smaller than nums[j], which is an ordered-set predecessor query. Insert nums[j] only after evaluating it so indices remain strictly ordered. With coordinate compression, a Fenwick frequency tree can find the predecessor rank; a balanced ordered set is the direct alternative. This decomposes a three-index optimisation into one suffix aggregate and one dynamic predecessor query.'
where topic_id = 11
and not (sub_variants @> '["Ordered-set predecessor query paired with suffix maxima for increasing-triplet optimisation"]'::jsonb);

-- Topic 18: the simpler trie-DP version precedes the hard weighted matcher in Topic 46.
update public.topic_content
set sub_variants = sub_variants || '["Minimum-cost word segmentation with trie-guided dynamic programming"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Build a target string by concatenating dictionary words, each with a cost, and find the minimum total cost","breaks_when":"The total dictionary/target constraints make restarting a trie walk at every target position too expensive; use Aho-Corasick or hashing for the larger version","sub_variant":"Insert words into a trie, store the minimum cost at terminal nodes, and run prefix/suffix DP by walking the trie from each reachable target position"}]'::jsonb,
core_idea = core_idea || E'\n\nWeighted trie segmentation DP: define dp[i] as the minimum cost to construct target[0..i). Insert every dictionary word into a trie and keep the minimum cost among duplicate words at each terminal node. From every reachable position i, walk the trie along target[i..]; whenever a terminal node is reached at j, relax dp[j+1] = min(dp[j+1], dp[i] + terminalCost). Stop the walk at the first missing edge. This is the trie-guided baseline for weighted word segmentation; the harder large-constraint version requires a faster multi-pattern matching strategy such as Aho-Corasick or carefully verified hashing.'
where topic_id = 18
and not (sub_variants @> '["Minimum-cost word segmentation with trie-guided dynamic programming"]'::jsonb);

-- Topic 25: basic opening-time Dijkstra is the prerequisite for the phase-aware variant.
update public.topic_content
set sub_variants = sub_variants || '["Earliest-arrival Dijkstra with per-cell opening times and wait-before-entry relaxation"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Each destination vertex has an earliest entry time and movement has a fixed positive duration; waiting is allowed","breaks_when":"The time-dependent transition violates FIFO or waiting is prohibited in a way that makes a single earliest-arrival label insufficient","sub_variant":"For an edge u→v with duration w and opening time open[v], relax arrival[v] with max(dist[u], open[v]) + w; this is an earliest-arrival Dijkstra transition"}]'::jsonb,
core_idea = core_idea || E'\n\nTime-gated Dijkstra: a vertex can be entered only after its opening time, but movement itself still costs w seconds. From a state reached at time t, the earliest arrival at neighbour v is max(t, open[v]) + w. Because this earliest-arrival transition is FIFO (leaving later cannot produce an earlier arrival through the same edge), Dijkstra remains valid. This is the clean prerequisite for phase-dependent variants where w also depends on the move number or state.'
where topic_id = 25
and not (sub_variants @> '["Earliest-arrival Dijkstra with per-cell opening times and wait-before-entry relaxation"]'::jsonb);

-- Topic 44: the direct Hamming-weight primitive.
update public.topic_content
set sub_variants = sub_variants || '["Hamming weight by repeatedly clearing the lowest set bit (Brian Kernighan)"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Count the number of set bits in one integer, especially when the number of set bits is small","breaks_when":"A fixed-width constant-time lookup or parallel population-count intrinsic is available and preferred","sub_variant":"Repeatedly apply n &= n - 1; each iteration removes exactly the least significant set bit, so the loop executes popcount(n) times"}]'::jsonb,
core_idea = core_idea || E'\n\nHamming weight / Brian Kernighan: n & (n−1) clears exactly the least significant set bit. Repeating this operation until n becomes zero counts one iteration per set bit, so the running time is O(popcount(n)) rather than O(bit-width). For Java, remember int is signed: the bitwise operations still work on the 32-bit representation, but use an unsigned shift when scanning all bits and use Integer.bitCount when a library primitive is allowed.'
where topic_id = 44
and not (sub_variants @> '["Hamming weight by repeatedly clearing the lowest set bit (Brian Kernighan)"]'::jsonb);

-- Topic 45: inverse subset-sum reconstruction is optional, not another MITM counting drill.
update public.topic_content
set sub_variants = sub_variants || '["Inverse subset-sum reconstruction by pairing a sorted multiset of sums and recursively partitioning it"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Recover an unknown integer array from the multiset containing all of its subset sums","breaks_when":"The full 2^n subset-sum multiset is not available or multiplicities cannot be preserved","sub_variant":"Sort the multiset; the difference between its two smallest values gives the magnitude of one element. Pair each sum with its shifted partner, then choose the partition containing zero to determine the sign and recurse"}]'::jsonb,
core_idea = core_idea || E'\n\nInverse subset-sum reconstruction: sort all 2^n subset sums. The difference between the smallest two sums reveals the absolute value d of one unknown element. Partition the multiset into pairs (s,s+d), preserving multiplicities. One half corresponds to subsets excluding the recovered element and the other to subsets including it. The half containing zero determines the sign; recurse on that half. This is not meet-in-the-middle enumeration: it reverses the subset-sum transform by multiset pairing and recursive partitioning.'
where topic_id = 45
and not (sub_variants @> '["Inverse subset-sum reconstruction by pairing a sorted multiset of sums and recursively partitioning it"]'::jsonb);

-- Topic 48: compressed spatial partitioning and Boolean operations on quad-trees.
update public.topic_content
set sub_variants = sub_variants || '["Quad-tree construction by recursive four-way spatial partitioning and uniform-region compression","Quad-tree Boolean composition with leaf short-circuits and subtree coalescing"]'::jsonb,
pattern_triggers = pattern_triggers || '[
 {"trigger":"Represent a power-of-two binary matrix as a compressed tree in which every internal node represents four equal quadrants","breaks_when":"The region is not recursively divisible into four equal quadrants or the representation must support arbitrary non-square partitions","sub_variant":"Check whether the current square is uniform; if so emit one leaf, otherwise split into four quadrants and recurse"},
 {"trigger":"Combine two quad-trees with a Boolean operation without expanding either tree to a full matrix","breaks_when":"The operation is not compatible with uniform leaf short-circuits or the trees do not describe the same spatial region","sub_variant":"Apply Boolean identities when either operand is a uniform leaf; otherwise recurse on corresponding quadrants and collapse four equal-valued leaf children into one leaf"}
]'::jsonb,
core_idea = core_idea || E'\n\nQuad-tree construction: recursively partition a square region into four equal quadrants. If every cell in a region has the same value, represent the entire region by one leaf; otherwise create an internal node and recurse into its quadrants. This is a compressed spatial representation: uniform areas collapse, while detail is stored only where the matrix changes.\n\nQuad-tree Boolean composition: operate directly on compressed trees instead of materialising the underlying matrices. For OR, a true leaf short-circuits the whole region to true; a false leaf contributes the other operand unchanged. If both nodes are internal, recursively combine corresponding quadrants. Afterward, if all four children are leaves with the same value, coalesce them into one leaf. The same structural method generalises to other Boolean operations with the appropriate truth-table short-circuits.'
where topic_id = 48
and not (sub_variants @> '["Quad-tree construction by recursive four-way spatial partitioning and uniform-region compression"]'::jsonb);

-- Guard against accidental duplicate LeetCode IDs before inserting.
do $$
begin
  if exists (
    select 1 from public.problems
    where lc_number in ('489','372','191','2543','1982','3073','3253','3341','427','558')
  ) then
    raise exception 'Pass 6 aborted: one or more candidate LeetCode IDs already exist in public.problems';
  end if;
end $$;

insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(8,39,'Hard','489','https://leetcode.com/problems/robot-room-cleaner/','Robot Room Cleaner','Hard',true,'Unknown-grid exploration with relative coordinates and reversible DFS','The grid is hidden behind move/turn/clean operations. Maintain relative coordinates, heading and a visited set. DFS each newly discovered open cell; after exploring a child, turn around, move back and restore the original heading. The restoration invariant makes exhaustive exploration possible without knowing the map in advance.',true,'combination','Grid and graph constrained search',4,4),
(10,27,'Medium','372','https://leetcode.com/problems/super-pow/','Super Pow','Medium',false,'Modular exponentiation for an exponent represented as decimal digits','For each next decimal digit d, extend the already processed exponent q via 10q+d: ans = ans^10 × a^d mod 1337. Use repeated squaring for modular powers and reduce after every multiplication; never parse the exponent array into an integer.',true,'core_pattern','Modular exponentiation and arithmetic invariants',7,1),
(10,28,'Hard','2543','https://leetcode.com/problems/check-if-point-is-reachable/','Check if Point Is Reachable','Hard',false,'GCD invariant under subtraction and coordinate doubling','Subtraction preserves gcd(x,y); doubling one coordinate can only preserve the GCD or multiply it by two. Starting from gcd(1,1)=1, the target is reachable exactly when gcd(targetX,targetY) is a power of two. This is a compact invariant/proof exercise, retained as optional practice.',false,'optional_reference',null,null,null),
(11,19,'Medium','3073','https://leetcode.com/problems/maximum-increasing-triplet-value/','Maximum Increasing Triplet Value','Medium',true,'Ordered-set predecessor plus suffix maximum','Fix the middle index j. Precompute the maximum value strictly to its right; maintain an ordered set of values strictly to its left and query the greatest value below nums[j]. The candidate is predecessor - nums[j] + suffixMax[j]. This is an optional drill for predecessor queries and strict index ordering.',false,'optional_reference',null,null,null),
(18,27,'Medium','3253','https://leetcode.com/problems/construct-string-with-minimum-cost-easy/','Construct String with Minimum Cost (Easy)','Medium',true,'Weighted word segmentation with trie-guided DP','Insert dictionary words in a trie and store the cheapest terminal cost. From each reachable target position, walk matching trie edges and relax the minimum-cost DP at every terminal. This is the simpler trie-DP progression before the large-constraint Aho-Corasick/hashing treatment in LC 3213.',true,'combination','Trie-guided DP and grid search',3,4),
(25,23,'Medium','3341','https://leetcode.com/problems/find-minimum-time-to-reach-last-room-i/','Find Minimum Time to Reach Last Room I','Medium',false,'Earliest-arrival Dijkstra with per-cell opening times','From a cell reached at time t, entering neighbour v with opening time open[v] and unit move cost takes max(t,open[v])+1. The transition is FIFO, so ordinary Dijkstra over earliest arrival times is correct. This establishes the time-gated baseline before LC 3342 adds alternating movement costs.',true,'variant','State-expanded and time-constrained shortest paths',4,5),
(44,19,'Easy','191','https://leetcode.com/problems/number-of-1-bits/','Number of 1 Bits','Easy',false,'Hamming weight by clearing the lowest set bit','Repeatedly execute n &= n - 1. Each iteration clears exactly one set bit, so the number of iterations equals the Hamming weight. This is the canonical Brian Kernighan bit-counting primitive.',true,'variant','Bitwise primitives and XOR invariants',1,8),
(45,6,'Hard','1982','https://leetcode.com/problems/find-array-given-subset-sums/','Find Array Given Subset Sums','Hard',false,'Inverse subset-sum reconstruction by multiset pairing','Sort the 2^n subset sums. The difference between the smallest two reveals an element magnitude; pair each sum with its shifted partner and retain the half containing zero to determine its sign. Recurse while preserving duplicate multiplicities. Optional advanced reconstruction, distinct from MITM enumeration.',false,'optional_reference',null,null,null),
(48,23,'Medium','427','https://leetcode.com/problems/construct-quad-tree/','Construct Quad Tree','Medium',false,'Recursive four-way spatial partitioning with uniform-region compression','Recursively split a power-of-two square into four quadrants. Emit a leaf when the whole region is uniform; otherwise create an internal node and recurse. This is the construction prerequisite for compressed spatial operations on quad-trees.',true,'core_pattern','Quad-tree partitioning and recursive region algebra',9,1),
(48,24,'Medium','558','https://leetcode.com/problems/logical-or-of-two-binary-grids-represented-as-quad-trees/','Logical OR of Two Binary Grids Represented as Quad-Trees','Medium',false,'Recursive Boolean composition with leaf short-circuits and coalescing','Combine corresponding quadrants directly without expanding the represented grids. A true leaf short-circuits OR to true; a false leaf returns the other operand. Recurse only when both nodes are internal, then coalesce four same-valued leaf children. This teaches algebra over compressed spatial trees.',true,'combination','Quad-tree partitioning and recursive region algebra',9,2);

-- LC 3342 is the advanced phase-aware continuation of the new LC 3341 baseline.
update public.problems
set path_problem_order = 6
where topic_id = 25 and lc_number = '3342'
  and curriculum_path = 'State-expanded and time-constrained shortest paths';

-- Refresh visible topic counts/coverage summaries.
update public.topics set summary_meta='36 problems · 5 stages · subsets, permutations, grid, CSP, memoised backtracking and unknown-grid exploration' where id=8;
update public.topics set summary_meta='28 problems · sieve, SPF, totient, segmented, Möbius, GCD/LCM frontiers, modular exponentiation and reachability invariants' where id=10;
update public.topics set summary_meta='19 problems · point update, range update, 2D BIT, inversions, order statistics and predecessor queries' where id=11;
update public.topics set summary_meta='27 problems · standard, XOR, wildcard, trie+DP, weighted segmentation, Aho–Corasick, persistent and paired-character tries' where id=18;
update public.topics set summary_meta='23 problems · classic, minimax, grid, implicit, state-expanded and time-dependent Dijkstra' where id=25;
update public.topics set summary_meta='19 problems · XOR invariants, Hamming weight, bit counting, range operations, Gray code, SOS DP, XOR basis and AND frontiers' where id=44;
update public.topics set summary_meta='6 problems · split exponential search, subset counting, closest sum, modular residues, multidimensional states and inverse subset-sum reconstruction' where id=45;
update public.topics set summary_meta='23 problems · predicates, polygons, hulls, sweeps, circle barriers, enclosing disks, quad-tree spatial partitioning and Manhattan transforms' where id=48;

do $$
declare seq_name text;
begin
  seq_name := pg_get_serial_sequence('public.problems','id');
  if seq_name is not null then
    perform setval(seq_name, greatest((select coalesce(max(id),1) from public.problems), 1), true);
  end if;
end $$;

commit;
