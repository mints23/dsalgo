# Progressive Concept Audit — Phase 2C (Topics 15–16)

**Source:** Live production problem rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 15 — Top K Elements / Heap

**Inventory:** 52 placements; 51 Medium/Hard and 1 Easy reference.  
**Verdict:** Strong breadth, but the topic has expanded from Top-K into many heap use cases. Organize by heap invariant and distinguish heaps from better alternatives.

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Kth Largest Element in an Array | Size-K min-heap gate; root is the Kth largest | Core foundation |
| 2 | Last Stone Weight | Max-heap extraction and transformed reinsertion | Core max-heap contrast |
| 3 | Kth Largest in a Stream | Persistent heap state across online queries | Core online extension |
| 4 | Top K Frequent Elements | HashMap-derived frequency key with size-K heap | Core derived-key extension |
| 5 | K Closest Points to Origin | Computed distance key; max-heap retains K smallest | Core key transformation |
| 6 | Top K Frequent Words | Compound comparator and deterministic tie-breaking | Core ordering extension |
| 7 | Min Ops to Halve Array Sum | Reinsert transformed maximum; stop at aggregate threshold | Core greedy simulation |
| 8 | Sort Characters By Frequency | Bucket sort beats heap when K=n and frequency is bounded | Method-selection transfer |
| 9 | Min Cost to Connect Sticks | Huffman-style repeated merge of two smallest values | Core min-heap greedy |
| 10 | Number of Orders in Backlog | Two opposing heaps match buy/sell orders by boundary condition | Core dual-heap model |
| 11 | Meeting Rooms II | Min-heap of active end times; heap size gives concurrency | Cross-topic Intervals |
| 12 | Reorganize String | Max-heap scheduling with previous-character exclusion | Core scheduling |
| 13 | Task Scheduler | Max-heap plus cooldown queue and time advancement | Core scheduling extension |
| 14 | Longest Happy String | Temporarily skip top frequency when consecutive-use limit is hit | Core constrained scheduling |
| 15 | Kth Smallest in Sorted Matrix | Multi-source frontier heap with row/column coordinates | Core frontier expansion |
| 16 | Find K Pairs with Smallest Sums | Lazy enumeration of Cartesian-product neighbors | Core implicit product |
| 17 | K-th Smallest Prime Fraction | Heap over implicit sorted fractions; binary-search count as alternative | Integration / algorithm choice |
| 18 | Merge K Sorted Lists | K-way merge with node-pointer advancement | Core multiway merge |
| 19 | Smallest Range Covering K Lists | Multiway merge plus running maximum; optimize a two-sided range | Advanced integration |
| 20 | Find Median from Data Stream | Two heaps partition lower and upper halves with size/order invariants | Core dual-heap structure |
| 21 | Employee Free Time | K-way merge of interval streams; track maximum end outside heap | Integration with Intervals |
| 22 | Meeting Rooms III | Two min-heaps with different keys: free room ID and occupied end-time | Advanced scheduling |
| 23 | Minimum Number of Refueling Stops | Max-heap of passed stations; make refuel decisions retroactively | Core delayed-decision greedy |
| 24 | Furthest Building You Can Reach | Min-heap keeps largest climbs assigned to ladders by evicting smallest | Reinforcement / opposite heap direction |
| 25 | Maximum Subsequence Score | Sort by multiplier and keep K largest values in a min-heap | Advanced top-K under hidden threshold |
| 26 | Min Difference in Sums After Removal | Two directional heap scans maintain smallest-left and largest-right sums | Advanced split integration |
| 27 | Sliding Window Median | Two-heap partition with lazy deletion and effective-size counters | Advanced dynamic median |
| 28 | Trapping Rain Water II | Min-heap as a priority-BFS frontier from boundary cells | Advanced graph/grid integration |
| 29 | CF 1526C Potions | Accept then retroactively evict worst negative choice when feasibility breaks | Advanced regret greedy |
| 30 | Maximum Average Pass Ratio | Heap by marginal gain; key is recomputed after each allocation | Core marginal-optimization greedy |
| 31 | Total Cost to Hire K Workers | Two candidate-frontier heaps grow inward from both ends | Advanced dual-frontier model |
| 32 | Swim in Rising Water | Min-heap Dijkstra minimizes path bottleneck, not path sum | Advanced shortest-path integration |
| 33 | Kth Largest (QuickSelect variant) | Randomized partition and recurse into one side; expected O(n) | Method-selection alternative to #1 |
| 34 | Top K Frequent (bucket sort variant) | Bounded frequency domain permits O(n) bucket extraction | Method-selection alternative to #4 |
| 35 | Find K-th Smallest Pair Distance | Binary search on distance with two-pointer count oracle | Diagnostic; not a heap problem |
| 36 | Kth Smallest in Multiplication Table | Binary search on value with arithmetic count oracle | Diagnostic; not a heap problem |
| 37 | CF 1354C Not Sitting | Precompute/rank candidate distances; selection by rank | Diagnostic; source/problem statement review |
| 38 | The K Weakest Rows in a Matrix | Count soldiers and select by compound key | Easy reference |
| 39 | Seat Reservation Manager | Min-heap as an online ordered resource pool with reserve/unreserve API | Core data-structure design |
| 40 | IPO | Sort by capital to unlock projects; max-heap chooses best available profit | Core two-heap unlock pattern |
| 41 | Construct Target Array With Multiple Sums | Reverse simulation; modulo collapses repeated subtraction | Advanced reverse greedy |
| 42 | Maximum Number of Eaten Apples | Min-heap by expiry; consume earliest-expiring resource | Core deadline/expiry greedy |
| 43 | Minimum Interval to Include Each Query | Offline query sweep plus min-heap of active interval sizes and lazy expiry | Integration; canonical also Intervals |
| 44 | Process Tasks Using Servers | Free-server heap and busy-server heap with release times and tie-breaks | Advanced dual-heap scheduler |
| 45 | Find Servers That Handled Most Number of Requests | Ordered free-server set plus busy release-time heap and cyclic successor search | Advanced ordered-set + heap integration |
| 46 | Minimum Cost to Hire K Workers | Sort by wage/quality ratio and maintain K smallest qualities | Advanced ratio threshold + heap |
| 47 | Maximum Number of Points From Grid Queries | Offline sorted queries plus min-heap BFS frontier | Advanced offline graph integration |
| 48 | Find K Closest Elements | Sorted input allows binary search + two-pointer expansion, better than heap | Diagnostic trap |
| 49 | Median of Two Sorted Arrays | Binary partition gives O(log min(m,n)); heap merge is inferior | Diagnostic trap |
| 50 | Sliding Window Maximum | Monotonic deque gives O(n), better than heap | Diagnostic trap |
| 51 | Stone Game VI | Sort by combined value a[i]+b[i] for optimal alternating picks | Diagnostic trap / Greedy |
| 52 | Solving Questions with Brainpower | Single-player take/skip DP; not priority scheduling | Diagnostic trap / 1D DP |

### Recommended concept paths

1. Top-K gate and key design: #1 → #3 → #4 → #5 → #6 → #25.
2. Heap as evolving simulation: #2 → #7 → #9 → #41 → #42.
3. Scheduling and cooldown: #12 → #13 → #14 → #22 → #24 → #30.
4. Dual heaps and partitioning: #10 → #20 → #26 → #27.
5. Multi-source frontier / k-way merge: #15 → #16 → #18 → #19 → #21.
6. Delayed / regret decisions: #23 → #24 → #29.
7. Offline unlocking / queries: #40 → #43 → #44 → #45 → #47.
8. Heap versus alternatives: #8, #33–38, #48–52.

### Changes recommended (not yet applied)

- Split the topic into top-K, dual heaps, multiway merge, scheduling, delayed/regret greedy, frontier search, and heap-vs-alternative subpaths.
- #1–#6 are a particularly good progression. Require learners to state what the heap key represents and why heap direction discards the correct candidate.
- #11, #21, #22, and #43 overlap with Intervals; #28 and #32 overlap with Graphs; #27 overlaps with Sliding Window. Use one canonical solution and targeted transfer questions elsewhere.
- #23 and #24 are related retroactive resource-allocation patterns; teach the difference in heap direction and what is evicted.
- #33–37 and #48–52 are valuable method-selection questions, but should not count as new heap concepts.
- #27 requires explicit effective heap sizes and stale-entry pruning for both heaps.
- #45 depends on an ordered set with successor wrap-around, not a heap alone.
- #46's ratio proof should establish why the highest ratio in a selected group is the binding wage rate.
- #47 is a strong offline-query + priority-BFS capstone; explain why the reachable set grows monotonically as the query threshold increases.
- Final capstone: dynamic candidate set, unlock constraints, delayed choice, and tie-breaking; justify why a heap is necessary and sorting alone is insufficient.

---

## Topic 16 — Monotonic Stack / Queue

**Inventory:** 41 placements; all Medium/Hard.  
**Verdict:** Strong progression from next/previous greater elements into contribution counting, histogram geometry, and monotone deques. The topic mixes monotone stacks with ordinary stacks and DP deques; clarify the shared dominance invariant.

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Next Greater Element I | Stack of unresolved indices; pop event reveals next greater value | Core foundation |
| 2 | Daily Temperatures | Store indices because answer is distance, not value | Core progression |
| 3 | Online Stock Span | Merge popped spans into the current entry | Core online extension |
| 4 | Next Greater Element II | Circular traversal via second pass / modulo indexing | Core circular extension |
| 5 | 132 Pattern | Reverse scan and retain second-greater candidate | Core pattern extension |
| 6 | Previous Smaller Element Array (custom) | Previous rather than next relation; answer available at push time | Core direction/comparator variant; statement required |
| 7 | Largest Rectangle in Histogram | Previous and next smaller boundaries define each bar's maximal span | Core geometric application |
| 8 | Maximal Rectangle in Binary Matrix | Convert each row into histogram heights and reuse #7 | Core 2D reduction |
| 9 | Sum of Subarray Minimums | Each element owns a count of subarrays via left/right spans | Core contribution counting |
| 10 | Sum of Subarray Ranges | Compute sum(max) − sum(min) using two ownership passes | Core dual contribution |
| 11 | Sliding Window Maximum | Monotone deque: back pops remove dominated values; front pops expire indices | Core deque foundation |
| 12 | Longest Subarray with Abs Diff ≤ Limit | Maintain max and min deques simultaneously while window shrinks | Core dual-deque extension |
| 13 | Remove K Digits | Increasing stack plus deletion budget gives lexicographically smallest result | Greedy integration |
| 14 | Remove Duplicate Letters | Pop only when character appears later; last-occurrence feasibility | Greedy + HashMap integration |
| 15 | Trapping Rain Water | Decreasing stack computes basin volume when bottom is bounded by two walls | Core alternate water formulation |
| 16 | Sum of Total Strength of Wizards | Minimum ownership spans + double prefix sums for subarray-sum contribution | Advanced integration |
| 17 | Car Fleet II | Decreasing stack over computed collision times; discard cars that cannot remain next collision | Advanced dominance on derived values |
| 18 | Car Fleet | Arrival-time ordering and fleet merging | Reinforcement / simpler sibling |
| 19 | Asteroid Collision | Ordinary stack simulates directional collision chain; not a monotone stack | Reclassify as Stack fundamentals |
| 20 | Remove All Adjacent Duplicates in String | Ordinary stack accumulator; pop on equality | Reclassify as Stack fundamentals |
| 21 | Count Submatrices With All Ones | Histogram heights plus contribution counting for all rectangles | Advanced 2D integration |
| 22 | Maximum Width Ramp | Decreasing candidate stack prunes dominated left indices; scan right-to-left | Core dominance application |
| 23 | Maximum Score of a Good Subarray | Expand from fixed k while maintaining minimum; monotone-boundary reasoning | Cross-topic Two Pointers; verify stack ownership |
| 24 | Shortest Subarray with Sum ≥ K | Increasing deque over prefix sums; front answers, back maintains monotonicity | Core prefix-deque application |
| 25 | Max Value of Equation | Algebraic transform + decreasing deque over (y−x) in bounded x-window | Advanced integration |
| 26 | Jump Game VI | Decreasing deque over DP values to optimize predecessor maximum | DP optimization; canonical in DP |
| 27 | Minimum Number of Coins for Fruits | Increasing deque over DP costs with position-dependent window | DP optimization; canonical in DP |
| 28 | Constrained Subsequence Sum | Decreasing deque over DP states plus restart-at-zero choice | DP optimization; canonical in DP |
| 29 | ABC 236F — Spices | Metadata claims monotone stack + offline query reduction | Review exact statement and derivation |
| 30 | CF 1788E — Hemose on the Tree | Tree-to-array DFS-order reduction followed by stack pairing | Advanced custom transfer; verify title/source |
| 31 | Next Greater Node In Linked List | Linearize linked list to array, then apply next-greater stack | Core input-structure transfer |
| 32 | Buildings With an Ocean View | Elements never dominated by a later taller value survive | Core survival interpretation |
| 33 | Number of Visible People in a Queue | Count popped shorter candidates plus one surviving blocker | Core counting extension |
| 34 | Decode String | Ordinary stack preserves nested parser context across brackets | Reclassify as Stack fundamentals / parsing |
| 35 | Find the Most Competitive Subsequence | Increasing stack with a remaining-capacity proof for safe pops | Core selection-budget extension |
| 36 | Next Greater Element IV | Two-stage eviction pipeline finds second greater element | Advanced core extension |
| 37 | Steps to Make Array Non-decreasing | Propagate cascade-removal step counts through stack pops | Advanced core extension |
| 38 | Beautiful Towers II | Two monotone passes and clamped-height contribution sums for each peak | Advanced core extension |
| 39 | Min Stack | Auxiliary minimum invariant, not monotone dominance | Diagnostic trap |
| 40 | Longest Valid Parentheses | Stack of unmatched structural indices, not monotone values | Diagnostic trap / Stack fundamentals |
| 41 | Merge Intervals | Sort + greedy merge; no monotone dominance relation | Diagnostic trap / Intervals |

### Recommended concept paths

1. Next/previous greater/smaller: #1 → #2 → #3 → #4 → #5 → #6.
2. Boundary ownership and contribution: #7 → #8 → #9 → #10 → #16 → #21.
3. Monotone deque: #11 → #12 → #24 → #25.
4. Greedy stack applications: #13 → #14 → #35.
5. Dominance and derived state: #17 → #18 → #22 → #33 → #36 → #37 → #38.
6. Method boundary / ordinary stack: #19 → #20 → #34 → #39 → #40 → #41.
7. DP + deque transfer: #26 → #27 → #28.

### Changes recommended (not yet applied)

- Clarify that monotone stack/deque is a dominance technique; ordinary stacks for parsing, collisions, and auxiliary minima are related but not monotone patterns.
- Teach the amortized proof: every index is pushed once and popped at most once. Distinguish answer-on-pop (next greater) from answer-on-push (previous smaller).
- #7 should be the central histogram boundary lesson; #8 and #21 extend it to 2D maximum/counting objectives.
- #9 and #10 should teach strict vs non-strict comparisons and tie ownership to avoid double-counting equal values.
- #11 and #12 are canonical deque paths; #24 is a different deque over prefix sums and should explain why front and back pops have separate semantics.
- #13/#14/#35 overlap with Greedy; #19/#20/#34/#40 belong to general Stack fundamentals.
- #15 is a valid alternate formulation of Trapping Rain Water alongside Two Pointers; teach two different proofs, not duplicate problem inventory.
- #23 needs correctness review: metadata says two-pointer expansion, not necessarily a monotone stack.
- #26–28 belong canonically to DP with monotone deque optimization; cross-link them here as transfer exercises.
- #29 and #30 need full statement/source and independent algorithm verification.
- #39–41 are useful diagnostics, but should not be called monotone-stack core problems.
- Final capstone: choose monotone stack versus deque versus ordinary stack, design the invariant, and prove amortized O(n).

---

## Status

Topics 01–16 have now received progressive concept-delta reviews. Topics 17–43 remain. No production curriculum rows have been modified.
