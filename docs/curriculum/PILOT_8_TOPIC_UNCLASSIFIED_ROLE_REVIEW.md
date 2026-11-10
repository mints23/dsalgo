# Eight-Topic Pilot — Unclassified Required-Row Review

**Source of truth:** Live Supabase `public.problems` rows on 2026-11-10, joined to `public.topics`.  
**Branch:** `main`  
**Scope:** The 71 placements that originally had null `curriculum_role`, plus cross-topic ownership corrections in the eight-topic pilot.  
**Status:** Applied to production on 2026-11-10. All changes preserve problem IDs, topic IDs, `order_num`, and learner progress keys.

## Executive summary

The live pilot inventory originally contained 275 required placements across eight topics. All 71 previously unclassified placements have now been assigned an explicit role: 56 remain required and 15 are demoted (14 out_of_scope, one excluded_trap). Three duplicate Two Pointers rows and ten secondary cross-topic duplicates are retained as optional references; one already-classified date-arithmetic row is also demoted. The resulting pilot has 246 required placements, all with a complete path assignment.

The review distinguishes three outcomes:

- **Keep required:** The problem teaches a meaningful pattern or integration within this topic.
- **Reclassify as out of scope:** The row is a valid problem, but its canonical learning objective belongs to another topic. Preserve its record and stable ID; set `is_required=false` and `curriculum_role='out_of_scope'`.
- **Exclude trap:** The row is an explicit wrong-pattern / category-boundary trap. Preserve its record and stable ID; set `is_required=false` and `curriculum_role='excluded_trap'`.

The path labels below were used for the production backfill. They group rows within each authored table; they do not alter order_num or the visible progress number.

## Live counts

| Topic | Total placements | Required | Required with null role |
|---|---:|---:|---:|
| Two Pointers | 58 | 34 | 11 |
| HashMap | 48 | 32 | 12 |
| Binary Search | 44 | 34 | 10 |
| Sliding Window | 55 | 47 | 8 |
| Kadane's Algorithm | 28 | 22 | 6 |
| Intervals | 43 | 37 | 9 |
| Prefix Sums | 30 | 26 | 5 |
| Greedy | 47 | 43 | 10 |
| **Total** | **353** | **275** | **71** |

## Proposed row-level decisions

### Topic 01 — Two Pointers

| DB ID | Order | Problem | Proposed role | Required? | Proposed path | Reason |
|---:|---:|---|---|:---:|---|---|
| 9669 | 31 | LC 1658 — Minimum Operations to Reduce X to Zero | out_of_scope | No | — | Canonical reduction is longest subarray / prefix sum; belongs with Prefix Sums and Sliding Window. |
| 9671 | 33 | LC 454 — 4Sum II | out_of_scope | No | — | Pair-sum frequency map is the canonical O(n²) solution; HashMap owns it. |
| 9672 | 34 | LC 135 — Candy | out_of_scope | No | — | Two directional passes implement a greedy constraint propagation, not a two-pointer scan. Greedy owns it. |
| 9675 | 37 | LC 259 — 3Sum Smaller | core_pattern | Yes | Sorted pair counting | Fixed anchor plus monotone endpoint counting; count all remaining pairs when the current boundary is valid. |
| 9676 | 38 | LC 633 — Sum of Square Numbers | variant | Yes | Sorted pair search | Two monotone candidate values over a numeric domain; useful transfer from sorted-array pair search. |
| 9677 | 39 | LC 2563 — Count the Number of Fair Pairs | variant | Yes | Sorted pair counting | Difference of two countLess functions; strengthens duplicate-safe pair counting and bound handling. |
| 9678 | 40 | LC 143 — Reorder List | combination | Yes | Fast/slow + list rewiring | Compose midpoint discovery, second-half reversal, and alternating merge. |
| 9679 | 41 | LC 457 — Circular Array Loop | core_pattern | Yes | Fast/slow on implicit graph | Floyd cycle detection with direction and self-loop constraints in an index-transition function. |
| 9686 | 48 | LC 838 — Push Dominoes | combination | Yes | Boundary propagation | Two-sided boundary reasoning over runs; useful, but distinguish it from the canonical in-place two-pointer templates. |
| 9687 | 49 | LC 2332 — The Latest Time to Catch a Bus | combination | Yes | Two sorted sequences + greedy capacity | Merge-like passenger scan plus greedy boarding and predecessor search for a valid arrival time. |
| 9688 | 50 | LC 516 — Longest Palindromic Subsequence | out_of_scope | No | — | The key recurrence is interval DP; the two-pointer observation for substrings does not solve subsequences. |

### Topic 02 — HashMap

| DB ID | Order | Problem | Proposed role | Required? | Proposed path | Reason |
|---:|---:|---|---|:---:|---|---|
| 9727 | 31 | LC 149 — Max Points on a Line | core_pattern | Yes | Composite geometric key | Normalize slope with GCD and handle vertical / duplicate points; a high-value nontrivial key-design problem. |
| 9728 | 32 | LC 1711 — Count Good Meals | variant | Yes | Complement counting | For each value, count complements over a bounded power-of-two target set. |
| 9729 | 33 | LC 2266 — Count Number of Texts | out_of_scope | No | — | The standard solution is run-length DP; no hash map is needed. Its canonical learning objective belongs in Dynamic Programming. |
| 9730 | 34 | LC 355 — Design Twitter | combination | Yes | HashMap + heap / k-way merge | Maps model users, tweets, and followees; heap merges per-user timelines. |
| 9731 | 35 | LC 123 — Best Time to Buy and Sell Stock III | out_of_scope | No | — | Four-state transaction DP is the learning objective; HashMap is not required. |
| 9732 | 36 | LC 472 — Concatenated Words | combination | Yes | HashSet + DP / DFS | A set accelerates membership, but the central task is segmentation using DP/DFS. Keep as a deliberate hash-membership integration. |
| 9733 | 37 | LC 447 — Number of Boomerangs | variant | Yes | Frequency aggregation by distance | Per-anchor squared-distance buckets and ordered-pair counting. |
| 9734 | 38 | LC 273 — Integer to English Words | out_of_scope | No | — | Chunk decomposition and lookup arrays are not a hash-table pattern. |
| 9735 | 39 | LC 981 — Time Based Key-Value Store | combination | Yes | HashMap + per-key binary search | Map keys to timestamp-ordered histories; binary-search the latest timestamp not exceeding the query. |
| 9736 | 40 | LC 138 — Copy List with Random Pointer | core_pattern | Yes | Identity map / graph cloning | Map original object identity to clone to preserve shared references and cycles. |
| 9737 | 41 | LC 133 — Clone Graph | core_pattern | Yes | Identity map / graph cloning | Visited map prevents duplicate clones and terminates cycles during traversal. |
| 9738 | 42 | LC 269 — Alien Dictionary | combination | Yes | Adjacency map + topological sort | Hash maps build graph state; the actual algorithmic integration is graph construction and topological ordering. |

### Topic 03 — Binary Search

| DB ID | Order | Problem | Proposed role | Required? | Proposed path | Reason |
|---:|---:|---|---|:---:|---|---|
| 9774 | 30 | LC 668 — Kth Smallest in Multiplication Table | core_pattern | Yes | Binary search on answer | Count values at most mid with a monotone counting predicate. |
| 9775 | 31 | LC 862 — Shortest Subarray with Sum at Least K | out_of_scope | No | — | Negative values invalidate the ordinary monotone feasibility approach; prefix sums plus monotonic deque are canonical. Keep the concept in Prefix Sums / deque material. |
| 9776 | 32 | LC 702 — Search in a Sorted Array of Unknown Size | variant | Yes | Exponential bound + binary search | Discover a valid search interval before applying ordinary binary search. |
| 9777 | 33 | LC 287 — Find the Duplicate Number | combination | Yes | Binary search on value / pigeonhole | Count-based value-domain search is a distinct valid solution; retain as an alternate to Floyd's cycle method in Two Pointers. |
| 9778 | 34 | LC 1231 — Divide Chocolate | core_pattern | Yes | Maximize a feasible minimum | Greedy feasibility predicate and upper-mid binary search for the greatest valid threshold. |
| 9779 | 35 | LC 2141 — Maximum Running Time of N Computers | core_pattern | Yes | Maximize feasible time | Resource-capacity feasibility is monotone; reason about pooled energy rather than assigning batteries. |
| 9780 | 36 | LC 1482 — Minimum Number of Days to Make m Bouquets | core_pattern | Yes | Minimize a feasible threshold | Earliest day whose greedy contiguous grouping reaches m bouquets. |
| 9781 | 37 | LC 1964 — Longest Valid Obstacle Course at Each Position | combination | Yes | LIS tails + binary search | Patience sorting with upper-bound semantics for a non-decreasing subsequence. |
| 9782 | 38 | LC 354 — Russian Doll Envelopes | combination | Yes | Sort transform + LIS + binary search | Width ordering (descending height on ties) reduces 2D nesting to strict LIS. |
| 9783 | 39 | LC 300 — Longest Increasing Subsequence | core_pattern | Yes | LIS tails + binary search | Maintain the smallest tail for each subsequence length; clarify that tails are not themselves necessarily a subsequence. |

### Topic 04 — Sliding Window

| DB ID | Order | Problem | Proposed role | Required? | Proposed path | Reason |
|---:|---:|---|---|:---:|---|---|
| 9811 | 23 | LC 480 — Sliding Window Median | combination | Yes | Fixed window + dual heaps | Heap balancing and lazy deletion solve order statistics while the window advances. |
| 9812 | 24 | LC 862 — Shortest Subarray with Sum at Least K | out_of_scope | No | — | Negative values break the classic expand/shrink invariant; prefix sums plus monotonic deque are required. Preserve as a diagnostic cross-reference, not a required Sliding Window problem. |
| 9813 | 25 | LC 2398 — Maximum Number of Robots Within Budget | combination | Yes | Window + monotonic maximum + running sum | Two maintained aggregates enforce a nonlinear budget predicate. |
| 9827 | 39 | LC 1499 — Max Value of Equation | combination | Yes | Monotonic deque + distance window | Algebraically transform the objective and maintain a decreasing deque of candidate values. |
| 9828 | 40 | LC 2444 — Count Subarrays with Fixed Bounds | core_pattern | Yes | Last-seen boundary counting | Track last invalid, last min, and last max positions; count valid starts at each right endpoint. |
| 9829 | 41 | LC 2972 — Count the Number of Incremovable Subarrays II | combination | Yes | Sorted prefix/suffix + two pointers | Count removable middle ranges while joining a non-decreasing prefix and suffix. |
| 9838 | 50 | LC 2009 — Minimum Number of Operations to Make Array Continuous | variant | Yes | Sort + fixed value-range window | Deduplicate, then maximize retained values inside a range of width n; the window is over values, not original indices. |
| 9839 | 51 | LC 2953 — Count Complete Substrings | combination | Yes | Fixed windows by target distinct count | Enumerate the bounded alphabet cardinality, use fixed-size frequency windows, and split at invalid adjacent-character gaps. |

### Topic 05 — Kadane's Algorithm

| DB ID | Order | Problem | Proposed role | Required? | Proposed path | Reason |
|---:|---:|---|---|:---:|---|---|
| 9861 | 18 | LC 124 — Binary Tree Maximum Path Sum | out_of_scope | No | — | Tree postorder DP with a global path candidate is the canonical technique; not a direct Kadane array pattern. |
| 9862 | 19 | LC 1696 — Jump Game VI | combination | Yes | DP + sliding maximum deque | Transition is a bounded-window maximum over prior DP states; retain as a Kadane-to-DP generalization only if explicitly taught as such. |
| 9863 | 20 | LC 2272 — Substring With Largest Variance | variant | Yes | Constrained Kadane over character pairs | Run a signed-score maximum-subarray scan with the mandatory-minority-character state. |
| 9864 | 21 | LC 1425 — Constrained Subsequence Sum | combination | Yes | DP + monotonic deque | Generalizes max-subarray by allowing a bounded gap and skipping negative prior contributions. |
| 9865 | 22 | LC 2770 — Maximum Number of Jumps to Reach the Last Index | out_of_scope | No | — | General DAG-style DP over value-constrained predecessors; the stated linear running-max insight is not generally sufficient for arbitrary value windows. Reclassify and re-verify the solution explanation. |
| 9866 | 23 | Custom — Maximum Subarray Sum Divisible by K | out_of_scope | No | — | Prefix remainders and earliest-index / minimum-prefix state are central; move to Prefix Sums (or a dedicated prefix-modulo path). |

### Topic 06 — Intervals

| DB ID | Order | Problem | Proposed role | Required? | Proposed path | Reason |
|---:|---:|---|---|:---:|---|---|
| 10972 | 29 | LC 630 — Course Schedule III | combination | Yes | Deadline sort + max-heap | Interval deadlines plus exchange argument and heap eviction; a useful greedy scheduling integration. |
| 10973 | 30 | LC 1235 — Maximum Profit in Job Scheduling | combination | Yes | Weighted intervals + DP + binary search | Weighted interval scheduling is not ordinary interval merging; teach the DP transition and predecessor search. |
| 10974 | 31 | LC 2054 — Two Best Non-Overlapping Events | combination | Yes | Two-event scheduling + suffix max / binary search | Specialized k=2 weighted interval scheduling. |
| 10975 | 32 | LC 2008 — Maximum Earnings From Taxi | combination | Yes | Weighted intervals + DP | Same weighted scheduling recurrence under a ride/tip interpretation; keep only if its modeling delta is intentional. |
| 10977 | 34 | LC 2213 — Longest Substring of One Repeating Character | out_of_scope | No | — | Dynamic segment-tree maintenance of run summaries is the core data structure, not interval scheduling/merging. |
| 10978 | 35 | CF 981E — Count Good Numbers (Digit DP disguise) | excluded_trap | No | — | Explicit pattern-boundary trap: interval wording conceals digit DP. Current global trap policy keeps it out of the learner path. |
| 10979 | 36 | LC 228 — Summary Ranges | core_pattern | Yes | Consecutive range compression | Convert a sorted sequence into maximal contiguous value intervals with careful boundary handling. |
| 10980 | 37 | LC 763 — Partition Labels | combination | Yes | Greedy implicit interval merging | Last occurrence defines each character's interval; merge overlapping reach. Greedy is canonical owner; Intervals is a deliberate bridge. |
| 10981 | 38 | LC 2015 — Average Height of Buildings in Each Segment | core_pattern | Yes | Sweep line + segment aggregation | Event deltas define active aggregate values; emit maximal adjacent segments with the same result. |

### Topic 07 — Prefix Sums

| DB ID | Order | Problem | Proposed role | Required? | Proposed path | Reason |
|---:|---:|---|---|:---:|---|---|
| 9931 | 23 | LC 307 — Range Sum Query Mutable | combination | Yes | Prefix aggregation + Fenwick tree | Dynamic updates invalidate static prefix arrays; BIT supports point updates and prefix queries in O(log n). |
| 9932 | 24 | LC 308 — Range Sum Query 2D Mutable | combination | Yes | 2D prefix aggregation + 2D Fenwick tree | Extend BIT update/query mechanics to two dimensions. |
| 9933 | 25 | LC 2407 — Longest Increasing Subsequence II | out_of_scope | No | — | Segment-tree range maximum over value coordinates is the main technique; the word prefix refers to a value range, not a prefix-sum structure. |
| 9934 | 26 | CF 295A — Greg and Array | core_pattern | Yes | Second-order difference arrays | First accumulate how often each operation is used, then apply operation-range deltas to the original array. |
| 9935 | 27 | USACO — Haybale Stacking | core_pattern | Yes | Difference array | Range additions become two endpoint updates followed by one prefix reconstruction. |

### Topic 09 — Greedy

| DB ID | Order | Problem | Proposed role | Required? | Proposed path | Reason |
|---:|---:|---|---|:---:|---|---|
| 10000 | 24 | LC 1834 — Single-Threaded CPU | combination | Yes | Event sort + min-heap scheduling | Maintain arrived tasks and choose the shortest available duration with deterministic tie-breaking. |
| 10001 | 25 | LC 2402 — Meeting Rooms III | combination | Yes | Two-heap resource scheduling | Track free room IDs and busy room release times; both ordering requirements matter. |
| 10002 | 26 | LC 1675 — Minimize Deviation in Array | core_pattern | Yes | Normalize + greedy max reduction | Normalize odd values once, then repeatedly reduce the current maximum while tracking the global range. |
| 10003 | 27 | LC 2071 — Maximum Number of Tasks You Can Assign | combination | Yes | Binary search + greedy deque feasibility | Search the maximum task count; the feasibility check greedily allocates pills to hardest tasks that can be rescued. |
| 10004 | 28 | USACO — Talent Show | combination | Yes | Ratio binary search + knapsack feasibility | Binary search a continuous ratio and use a transformed DP/greedy feasibility check; verify the source statement and exact implementation before final classification. |
| 10005 | 29 | Custom — Weighted Matroid Greedy (Max Spanning Forest) | core_pattern | Yes | Matroid / graphic-matroid greedy | Explain the exchange property and why Kruskal's ordering is optimal over acyclic edge sets. |
| 10017 | 41 | LC 1383 — Maximum Performance of a Team | combination | Yes | Sort + size-k min-heap | Fix the minimum efficiency and maintain the k largest speeds. |
| 10018 | 42 | LC 2551 — Put Marbles in Bags | variant | Yes | Greedy split-point selection | Every partition is a choice of k−1 adjacent pair costs; choose the largest and smallest split sums. |
| 10019 | 43 | LC 2449 — Minimum Number of Operations to Make Arrays Similar | variant | Yes | Invariant-preserving sorted matching | Parity is invariant under ±2; sort parity classes and pair in order. |
| 10020 | 44 | LC 2571 — Minimum Operations to Reduce Integer to 0 | core_pattern | Yes | Bitwise local greedy | Choose increment/decrement to merge runs of set bits; prove the local carry decision. |

## Aggregate proposal

| Outcome | Count |
|---|---:|
| Keep required with an explicit role | 56 |
| Reclassify as `out_of_scope` and not required | 14 |
| Reclassify as `excluded_trap` and not required | 1 |
| **Total reviewed** | **71** |

The aggregate is a proposal for these 71 currently unclassified rows only. LC 2266 was explicitly demoted after checking that its standard run-length DP solution does not require a hash map. It does not include the already-classified rows in the 275-row required inventory.

## Implementation constraints

1. Preserve every `public.problems.id`, `topic_id`, and `order_num`. Existing progress is keyed by `topic_id` plus the visible problem number derived from the authored HTML.
2. Do not delete placements or reassign them to a different topic as part of this pilot. A canonical-owner correction should demote the secondary placement, not move its database row.
3. Keep the authored HTML and structured row in sync. The frontend matches authored rows to structured records by URL, LeetCode number, then normalized title; unmatched rows are excluded from the learner-facing curriculum.
4. Do not implement path grouping by mutating `order_num` or by relying on DOM row order as progress identity.
5. Before applying any data changes, verify every proposed decision against the canonical topic owner, the full topic audit, and any same-ID alternate-solution placement.
6. Path metadata is separate from the existing progress identity. The current pilot assigns one primary path to each retained placement. If a placement later needs to belong to multiple paths simultaneously, introduce a normalized membership table rather than overloading these columns.
7. The feature branch now contains the additive three-column schema migration and fail-open frontend grouping. The migration has not been applied to production; do not deploy the frontend until the schema migration is applied and the reviewed path data migration is ready.

## Verification items before production

- Re-check all 71 rows against the latest live data immediately before migration; IDs and role nullability must still match.
- Verify custom source statements for Talent Show, Weighted Matroid Greedy, Haybale Stacking, and Maximum Subarray Sum Divisible by K.
- Independently validate LC 2770's transition and solution claim; the current `key_insight` says a linear scan with a running maximum, which is not a generally valid solution for arbitrary value-range predecessors.
- Check cross-topic identity and canonical ownership before demoting LC 454, LC 135, LC 516, LC 862, LC 124, LC 2770, LC 2407, and other moved rows.
- Confirm the app's reference toggles, row identity patching, progress restore, and mobile table rendering after path grouping.
- Production data changes require a separate reviewed migration. This branch is documentation-only.


## Cross-topic identity and ownership audit

A live duplicate-identity query across the eight pilot topics found the following required placements sharing a LeetCode number. These are not automatically data errors: some are legitimate alternate-solution or integration examples. They must be explicitly adjudicated before the path backfill.

| LC | Current required placements | Review direction |
|---:|---|---|
| 3 | HashMap; Sliding Window | Sliding Window is canonical; HashMap may remain only as a clearly labelled frequency-map cross-reference. |
| 1074 | Kadane; Prefix Sums | Prefix Sums owns the prefix-compression/counting pattern; demote the Kadane placement unless it teaches a distinct, explicit 2D-Kadane objective. |
| 1326 | Intervals; Greedy | Legitimate interval-cover + greedy integration. Keep one canonical required placement and make the other a cross-reference, not a duplicate required drill. |
| 135 | Two Pointers; Greedy | Greedy owns the two-pass directional-constraint pattern; demote Two Pointers placement. |
| 253 | Intervals; Greedy | Intervals owns room overlap/partitioning; Greedy may cross-reference the heap scheduling implementation. |
| 287 | Two Pointers; Binary Search | Keep both only if the Two Pointers row explicitly teaches Floyd cycle detection and Binary Search explicitly teaches value-domain counting; make the alternate solutions visible. |
| 438 | HashMap; Sliding Window | Sliding Window should own the window mechanics; HashMap should only retain an explicit map-frequency learning objective if it is not a duplicate required drill. |
| 435 | Intervals; Greedy | Same activity-selection objective. Choose one required owner; cross-reference from the other topic. |
| 45 | Intervals; Greedy | Greedy owns reachability / minimum-jump expansion. Intervals may link it as an interval-cover reduction, but avoid two required copies. |
| 452 | Intervals; Greedy | Valid in both interval stabbing and activity-selection framing; choose one canonical required placement and label the second as a cross-reference. |
| 454 | Two Pointers; HashMap | HashMap owns pair-sum complement counting; demote Two Pointers placement. |
| 525 | HashMap; Prefix Sums | Prefix Sums owns prefix-state transformation; HashMap may cross-reference the first-seen-state map. |
| 560 | HashMap; Prefix Sums | Prefix Sums owns prefix-sum counting; HashMap may cross-reference the map implementation. |
| 630 | Intervals; Greedy | Greedy owns deadline scheduling with regret/max-heap; demote or cross-reference the Intervals placement. |
| 76 | Two Pointers; Sliding Window | Sliding Window owns minimum-covering-window; demote Two Pointers placement. |
| 763 | Two Pointers; Intervals; Greedy | Greedy owns last-occurrence reach expansion; retain at most one required placement and use cross-references elsewhere. |
| 862 | Binary Search; Sliding Window | Neither current framing is canonical. The solution is prefix sums + monotonic deque; demote both placements from these topics and consider a Prefix Sums advanced cross-reference. |
| 881 | Two Pointers; Greedy | Legitimate two-pointer + greedy pairing. Keep one required owner and cross-reference the other to avoid duplicate completion counts. |
| 974 | HashMap; Prefix Sums | Prefix Sums owns modular prefix-state counting; HashMap may cross-reference the remainder-frequency map. |

**Applied ownership decision:** Secondary duplicates were demoted to optional references, never deleted or moved. The production migration preserves all existing IDs and order numbers.


## Production application result (2026-11-10)

- 56 null-role rows retained with explicit roles: core_pattern, variant, or combination.
- 14 null-role rows demoted to out_of_scope.
- One null-role row demoted to excluded_trap (CF 981E digit-DP disguise).
- Thirteen secondary duplicate placements were made optional references: LC 76, 713, and 763 in Two Pointers; LC 3 and 438 in HashMap; LC 435, 452, 45, 881, 253, and 1326 in Greedy; and LC 630 and 763 in Intervals. Their stable rows remain available through the existing optional-reference control.
- LC 1360 (date arithmetic) was demoted from the Intervals required curriculum.
- All retained required rows now have non-null curriculum_path, positive curriculum_path_order, and positive path_problem_order.
- Final production verification: 246 required rows, 246 complete path assignments, zero required rows with null curriculum_role.
- No problem IDs, topic IDs, order_num values, or progress keys were changed.

The canonical-owner pass leaves five intentional multi-topic required identities because each placement teaches a materially different algorithmic lens: LC 1074 (2D Kadane vs 2D prefix compression), LC 287 (Floyd cycle detection vs value-domain binary search), LC 525 (first-seen index vs Boolean prefix transform), LC 560 (prefix-sum counting with a map in both topic contexts), and LC 974 (modular prefix remainder counting). All other reviewed duplicates have one required owner and secondary placements are optional references.
