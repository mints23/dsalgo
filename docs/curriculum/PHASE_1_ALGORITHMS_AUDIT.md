# Phase 1 Curriculum Audit — Initial Algorithm Topics

**Scope:** Live production inventory for topics 1–9. **Status:** Initial metadata/content scan; detailed correctness and completeness review remains in progress.

## Live inventory

| Topic | Rows | Easy (exclude) | Medium | Hard | Initial observation |
|---|---:|---:|---:|---:|---|
| Two Pointers | 58 | 18 | 37 | 3 | Large catalogue, only 3 Hard rows; review advanced transfer and pointer invariants |
| HashMap | 48 | 12 | 26 | 10 | Review key design, frequency aggregation, prefix-state maps, composite keys, combinations |
| Binary Search | 44 | 7 | 25 | 12 | Review monotone predicates, answer-space search, partition search, feasibility proofs |
| Sliding Window | 55 | 3 | 38 | 14 | Review exact-K, negative values, deque, multiple constraints, counting variants |
| Kadane's Algorithm | 28 | 0 | 20 | 8 | Review prefix minima, constrained subarrays, circular cases, DP framing |
| Intervals | 43 | 0 | 26 | 15 | Review sweep lines, event ordering, scheduling, weighted scheduling, endpoint semantics |
| Prefix Sums | 30 | 1 | 21 | 8 | Review multidimensional, difference arrays, modulo/prefix maps, offline queries, BIT boundary |
| Backtracking | 38 | 0 | 20 | 18 | Review pruning, duplicate control, constraint propagation, bitmasking, state-space bounds |
| Greedy | 47 | 1 | 32 | 14 | Review exchange proofs, scheduling, heap/regret methods, interval coverage, matroids |

Counts are live public.problems rows grouped by topic_id and exact stored difficulty labels. Med and Medium are both counted as Medium. Counts are inventory facts, not completeness scores.

## Course-wide metadata findings
- 1,311 total problem rows.
- 823 distinct non-empty LeetCode IDs.
- 155 rows have no LeetCode ID; some may be valid custom / competitive-programming problems.
- 51 rows are labelled Easy and should be excluded from the required path.
- 718 rows are labelled Medium (Med or Medium).
- 516 rows are labelled Hard.
- 26 rows have no difficulty.
- 145 rows have no key_insight.
- 138 rows have no lc_url.
- 234 LeetCode IDs occur more than once.

Repeated IDs are not automatically errors: a problem may legitimately demonstrate multiple techniques. Every repeated placement needs a primary/cross-pattern/trap role and justification. Custom problems need a stable source or internally stored statement.

## First-pass findings

### Two Pointers
The body lists opposite-end sorted/maximize/count, three/four pointers, Dutch National Flag, fast/slow cycle and linked-list variants, two-array traversal, fill-from-ends, greedy combinations, and heap combinations. Easy exercises are not required. Retain non-trivial Medium and Hard entries where they test distinct reasoning. Investigate the depth of the Hard layer (currently 3); do not add questions merely to meet a quota.

### HashMap
The body covers complement lookup, frequency counting, canonical grouping, prefix sum and modulo maps, first-seen index, bidirectional maps, sliding-window frequency maps, HashMap + doubly linked list, implicit maps, composite keys, inverted maps, frequency stack, and aggregation. Easy lookup/counting drills become optional reference. Prioritize key design, collision-free state representation, prefix-state invariants, and map + heap / linked-list / window combinations.

### Binary Search
The body lists classic and boundary search, rotated arrays, answer-space minimize/maximize, floating-point, matrix, peak, greedy validation, exponential/unbounded, and k-th element variants. Prioritize predicate monotonicity proofs, bounds, overflow safety, duplicate handling, and partition-based search; basic binary search drills are not required.

### Sliding Window
The body lists fixed and variable windows, maximize/minimize, frequency windows, exact-K via atMost, replacement windows, monotonic deque, 2D windows, window + binary search / prefix sums, circular windows, permutation matching, multi-pointer windows, and counting. Explicitly teach the correctness boundary: ordinary variable windows need a monotonic validity condition; negative values can invalidate standard shrinking. Teach when to switch to prefix sums, deque, or another method.

### Kadane's Algorithm
Review whether this is a focused advanced treatment of maximum-subarray state transitions or duplicates broad 1D DP. Ensure derivation, all-negative arrays, circular arrays, constrained lengths, and prefix-minimum formulations.

### Intervals
Audit endpoint conventions, sorting keys, sweep-line event ordering, interval scheduling proof, weighted interval scheduling and its DP relationship, room/resource allocation, and interval coverage transformations.

### Prefix Sums
Audit 1D/2D prefix sums, difference arrays, prefix + hash map, modulo classes, coordinate compression, offline queries, and Fenwick/segment-tree boundaries. Distinguish static range aggregation from dynamic updates.

### Backtracking
Audit state representation, duplicate elimination, pruning soundness, branch ordering, constraint propagation, bitmask state, memoization crossover, and complexity. Avoid required slots for elementary subset/permutation drills.

### Greedy
Audit exchange arguments, stays-ahead proofs, interval scheduling, deadline scheduling, heap-based regret, delayed decisions, sorting/comparator proofs, matroid foundations, and counterexamples.

## Next audit actions
1. Complete question-by-question review for these nine topics, including duplicate placement and source validity.
2. Review the remaining 34 topic bodies and problem lists.
3. Decide which proposed new topics are standalone gaps versus existing subtopic coverage.
4. Produce curated required lists (Medium/Hard/custom advanced only) and optional reference lists.
5. Create additive curriculum data and acceptance tests after the full audit.

## Safety
This report does not modify production data. Easy rows remain intact. No database migrations or payment/auth changes are included.
