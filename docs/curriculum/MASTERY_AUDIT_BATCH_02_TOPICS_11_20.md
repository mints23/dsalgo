# Mastery Audit — Batch 2: Topics 11–20

**Audit date:** 2026-11-10  
**Evidence:** Production required placements and stored concept metadata.  
**Status:** Concept ownership audit; solution and Java verification is still outstanding.

## Batch verdict

| Topic | Required | Concept coverage | Main finding | Readiness |
|---|---:|---|---|---|
| 11. Fenwick Tree / BIT | 15 | Partial | Strong applications; missing range-update and multidimensional proof depth | Not verified |
| 12. Segment Tree | 17 | Partial | Good advanced variants; duplicate ownership with BIT and interval structures | Not verified |
| 13. KMP Pattern Matching | 15 | Partial | KMP plus Z-function and automaton; suffix-family coverage is elsewhere | Partial |
| 14. LIS | 13 | Partial | Broad LIS reductions; counting/reconstruction semantics need precision | Not verified |
| 15. Top K / Heap | 41 | Partial | Strong breadth but too many adjacent heap applications; two non-heap variants are mixed in | Not verified |
| 16. Monotonic Stack / Queue | 35 | Partial | Rich coverage; some stack and deque concepts need clearer separation | Not verified |
| 17. Trees | 29 | Partial | Advanced tree techniques are already present; proposed new tree topic may duplicate | Partial |
| 18. Trie | 22 | Partial | Rich binary trie and Aho–Corasick coverage; advanced strings overlap | Partial |
| 19. Graph Fundamentals | 14 | Gap | Topic mixes MST, SCC, DAG DP, functional graphs and BFS; fundamentals are not a coherent progression | Not verified |
| 20. BFS | 23 | Partial | Broad state-space BFS; connected components and reverse graph processing need ownership clarity | Not verified |

## Topic 11 — Fenwick Tree / Binary Indexed Tree (15 required)

**Concept inventory:** point update + prefix sum; range sum by prefix difference; frequency counting; coordinate compression; inversion and dominance counting; 2D BIT; range update/range sum using two BITs; order-statistic selection via binary lifting; offline sorting + BIT; BIT-augmented LIS.

**Required mapping:** LC 307 point update/range sum; 1395 team counts; 315/493/1649 inversion/order counts; 2426 inequality counting; 327 prefix range counting; 2179 position mapping; 2736 offline 2D dominance; 308 2D BIT; 2659 removed-position counting; 3072 suffix count; custom two-BIT range update; custom kth order statistic; custom BIT-augmented LIS count.

**Issues:** LC 307 also appears in Segment Tree and should have one primary owner; its BIT implementation belongs here, while segment tree is an alternative. The custom two-BIT problem should derive the formula from a difference array, not present a memorised template. Order-statistic binary lifting requires non-negative frequencies and a valid k. Coordinate compression must preserve ordering, not numeric distance. 2D BIT memory/time constraints need explicit analysis. LC 327 also appears in Prefix Sums and should be owned by range counting (BIT/merge sort) with a prefix-sum cross-reference.

**Recommendation:** Retain all distinct BIT techniques, but make the proof of lowbit traversal, update/query correctness, coordinate compression and kth selection explicit. **Verdict: Partial concept coverage; Java not verified.**

## Topic 12 — Segment Tree (17 required)

**Concept inventory:** point update/range aggregate; lazy range add/assign/multiply; lazy composition order; implicit/dynamic trees; merge-sort tree; persistent segment tree; segment tree beats; custom DP monoids; coordinate-compressed sweep structures; first-index search; range contribution aggregation.

**Required mapping:** LC 307 point update/range sum; 731/732 lazy range add/max; 715 lazy assignment/range state; 1622 affine lazy tags; 699 falling squares; 2213 longest-run monoid; 3165 four-state non-adjacent DP monoid; 850 compressed sweep + tree; 2286 first feasible capacity search; 1157 merge-sort tree; 2589 greedy scheduling + lazy assignment; 2940 first index satisfying threshold; 2276 implicit tree; 2916 lazy contribution; custom persistent kth; custom beats chmin/sum.

**Issues:** LC 307 is duplicated with BIT and should be primary in Topic 11. LC 715/2276 are interval-set/range-coverage combinations; the lesson must distinguish a segment tree from ordered disjoint intervals. Lazy tags need function-composition semantics (e.g. add after assign vs assign after add), not a list of templates. Segment Tree Beats requires its exact node statistics and preconditions; it cannot be described as generic range chmin. Persistent tree needs node-count/memory analysis. Merge-sort tree is a static range-query structure, not a lazy segment tree.

**Recommendation:** Keep the advanced segment-tree family. Add no generic range-sum exercise. Ensure every custom exercise has complete constraints, implementation and amortised proof. **Verdict: Partial concept coverage; Java not verified.**

## Topic 13 — KMP Pattern Matching (15 required)

**Concept inventory:** prefix-function/LPS; failure-link fallback; borders and periodicity; rotation and repeated text; palindrome prefix via reverse concatenation; integer-array KMP; Z-function; KMP automaton; KMP + DP; multi-pattern search boundaries.

**Required mapping:** LC 28 classic match; 459 periodicity; 796 rotation; 1392 longest border; 214 shortest palindrome; 1764 integer sequence; 686 repeated text; 2223 Z score; 3006 dual pattern + two pointers; 1408 substring checks; 1397 automaton + digit DP; 3292 failure function + greedy/DP; 3303 Z + mismatch; 471 periodicity + interval DP; custom automaton streaming.

**Issues:** Topic title is KMP, but the required set deliberately includes Z-function; make this an explicit sibling algorithm and compare its invariant to prefix-function. LC 1397 combines automaton construction with digit DP; LC 471 combines periodicity with interval DP. The curriculum should explain borders, failure transitions and automaton construction from first principles. Advanced string topics such as suffix arrays, suffix automata, Manacher and Aho–Corasick are not all KMP; some Aho–Corasick coverage currently lives in Trie.

**Recommendation:** Rename the concept inventory (not necessarily the visible topic) to Single-Pattern Matching: KMP + Z + automata. Cross-reference multi-pattern matching with Trie. **Verdict: Partial concept coverage; Java not verified.**

## Topic 14 — LIS (13 required)

**Concept inventory:** O(n²) DP baseline; patience sorting/tails O(n log n); strict vs non-decreasing; reconstruction with parent/index arrays; counting LIS; 2D/3D sorting reductions; LIS on DAG/partial orders; mountain decomposition; bounded-difference subsequence; replacement variants; per-index LNDS.

**Required mapping:** LC 300 length; 673 count; 354 2D envelopes; 1691 3D cuboids; 1048 word-chain DAG; 2111 K-increasing; 646 pair chain; 1671 LIS+LDS mountain; 1964 per-index LNDS; 960 column order; 1187 replacement; 2370 bounded alphabet difference; custom reconstruction.

**Issues:** Counting distinct LIS sequences is not equivalent to counting index-distinct subsequences; LC 673 needs duplicate-aware semantics. LC 646 is often best solved greedily by end-time sorting; if retained as LIS, the alternative relationship must be explained. LC 1048 is a DAG DP/longest chain, not the classic tails array. LC 1187 is substantially a DP + ordered predecessor problem. LC 960 needs sorting/comparator interpretation. Need explicit proof of patience sorting tails invariant and strict/non-decreasing binary-search boundary.

**Recommendation:** Keep LIS as a compact advanced algorithm topic. Clarify primary owner for DAG/greedy/DP reductions and verify all Java binary-search boundaries. **Verdict: Partial concept coverage; Java not verified.**

## Topic 15 — Top K Elements / Heap / Priority Queue (41 required)

**Concept inventory:** bounded top-K min/max heap; online streaming top-K; heapify; repeated extraction/reinsertion; dual heaps; multi-source k-way merge; Cartesian-product lazy expansion; scheduling with cooldown; event simulation; marginal-gain heap; regret heap; dynamic expiry; two heaps for median; heap vs QuickSelect; heap vs bucket sort; offline sort + heap; greedy with heap.

**Required mapping:** LC 215/703/347/973/692 bounded top-K; 1046/2208/1167 transformations; 1801 dual heaps; 253/621/1353/630/1834/2402 scheduling; 767/1405 string construction; 378/373/23/632/759/407 k-way merge/frontier; 786 implicit sorted structure; 295/480 two-heap medians; 2542/2163/1383/857 top-K with sorting; 1642/871/CF 1526C regret; 1792 marginal gain; 2462/1882/1606 multi-queue scheduling; 1705 expiry; 1851 offline interval heap; 2503 offline grid frontier; 502 two-stage eligibility/profit; 1354 reverse max simulation; 215 QuickSelect; 347 bucket sort; CF 1354C seat-distance ranking.

**Issues:** 41 is a high count. LC 215 QuickSelect and LC 347 bucket sort are valuable alternatives but are not heap implementations; mark them as comparison lessons rather than heap variants. CF 1354C is not clearly a heap problem; verify its exact statement and primary algorithm. LC 347 duplicates HashMap's frequency/bucket treatment; retain separate required placements only if one teaches bucket sort and the other teaches bounded heap selection, otherwise use a cross-reference. LC 480 also appears in Sliding Window; one primary owner should be chosen. LC 253 appears in Intervals. LC 1851 appears in Intervals and is a good offline-sort + heap combination. Heap invariants, comparator overflow, tie-breaking and lazy deletion are key Java risks.

**Recommendation:** Split the concept inventory into heap primitives, streaming top-K, k-way frontier, scheduling, dual heaps and non-heap comparisons. Prune redundant applications after solution review; 41 should not be treated as inherently better than a smaller set. **Verdict: Partial breadth; Java not verified.**

## Topic 16 — Monotonic Stack / Queue (35 required)

**Concept inventory:** next/previous greater/smaller; online spans; circular NGE; 132 pattern; histogram boundaries; contribution counting with duplicate tie-breaking; monotonic deque for sliding extrema; increasing/decreasing subsequence stacks; greedy deletion; collision simulation; prefix-sum monotonic deque; DP deque optimisation; 2D histogram; cascade timing; two-pipeline next-greater.

**Required mapping:** LC 496/739/901/503/456/custom PSE → NGE/PSE; 84/85/1504 → histogram; 907/2104/2281/2866 → contribution counting; 239/1438 → monotonic deque; 402/316/1673 → greedy monotone subsequence; 42 → basin stack; 1776/853/735 → collision/fleet simulation; 1047/394 → stack parsing/accumulation; 962/1762/1944/2454 → visibility/width/second NGE; 862 → prefix-sum deque; 2944 → DP deque; 1793 → expand around fixed minimum; 2289 → cascade step propagation; custom/CF advanced cases need statement verification.

**Issues:** LC 239/1438 are deque + window and overlap Sliding Window. LC 42 overlaps Two Pointers. LC 2281 overlaps Prefix Sums. LC 2944 is a DP optimisation, not a generic monotonic stack problem. LC 394 is a general parsing stack, not monotonic. Need a clear distinction between stack pop-time and deque front-expiration. Duplicate tie-breaking in contribution counting must be explicit (strict vs non-strict comparisons on each side). LC 1793 uses a two-pointer expansion from k; it should not be mistaken for a monotonic-stack problem.

**Recommendation:** Create separate paths for monotonic stack, monotonic deque, contribution counting, greedy monotone subsequence and adjacent stack applications. Reclassify non-monotonic examples. **Verdict: Partial concept breadth; Java not verified.**

## Topic 17 — Trees (29 required)

**Concept inventory:** bottom-up and top-down DFS; path aggregates; diameter; forest creation; infection distance; LCA; deepest-leaf LCA; binary lifting and path aggregates; Euler-tour flattening; subtree range queries; HLD; DSU on tree/small-to-large; centroid decomposition; virtual trees; tree DP; tree-to-graph BFS; DSU over thresholded edges; subset tree enumeration.

**Required mapping:** LC 104/112/687/1245/1110/1448/1376/1932 basic DFS/tree transforms; 2385/742/863 BFS distance; 236/1123 LCA; 1483/2836/2509 binary lifting; custom Cow at Large Euler+BIT; Subtree Paths/Cow Land/343D HLD; CF 600E DSU on tree; CF 161D tree DP; CF 1017E centroid; ABC 133F offline LCA+BIT; IOI Holiday virtual tree; CF 741D tree knapsack/small-to-large; LC 2421 DSU; LC 1617 subset tree enumeration; custom interval containment tree.

**Issues:** This topic already contains nearly all the proposed Advanced Tree Techniques family: Euler tours, BIT, binary lifting, HLD, centroid decomposition, DSU on tree, virtual trees, tree DP and offline LCA. Creating a separate Topic 47 without restructuring would duplicate content. Need formalise rooted vs unrooted tree, subtree/path distinction, LCA variants, Euler entry/exit conventions and rerooting. LC 1617 is subset enumeration over small graphs; clarify whether tree structure is truly central. Tree DP also overlaps Topic 38.

**Recommendation:** Do not add a new advanced-tree topic as currently proposed. Expand the existing Trees and Tree DP concept inventory, then decide whether a path-level split improves navigation. **Verdict: Partial-to-strong concept breadth; solution/Java not verified.**

## Topic 18 — Trie (22 required)

**Concept inventory:** insert/search/prefix; pass/end counts; deletion; suffix trie; wildcard branching; top-K suggestions; binary XOR trie; dynamic insert/delete; range-count XOR trie; offline constrained queries; Trie + DP/DFS; reverse suffix search; palindrome pairs; combined prefix/suffix trie; persistent trie; Aho–Corasick failure links.

**Required mapping:** LC 208/648/2416/677/1804 standard and counted tries; 820 suffix trie; 1268 top-K suggestions; 211 wildcard; 421/CF 706D/1803/2935/1707 XOR trie; 2707/472 Trie + DP; 212 Trie-guided grid DFS; 1032 reverse trie stream; 336 palindrome pairs; 745 prefix/suffix; 1938 XOR trie + tree DFS; custom persistent XOR trie; custom Aho–Corasick.

**Issues:** This topic is already much more advanced than a standard prefix-trie chapter. Aho–Corasick overlaps Advanced Strings and KMP; decide primary ownership. Persistent XOR trie needs version semantics and range-query proof. LC 1268 may be solved more simply by sorting + binary search; if Trie is the chosen teaching objective, explain its complexity and top-K traversal. Trie node memory, alphabet representation and deletion/pruning need Java-specific treatment.

**Recommendation:** Keep Trie as the owner of multi-pattern trie structures and XOR tries; cross-reference KMP for failure-function foundations. Do not create duplicate Aho–Corasick coverage in a new string topic. **Verdict: Partial-to-strong concept breadth; Java not verified.**

## Topic 19 — Graph Fundamentals (14 required)

**Concept inventory currently mixed:** MST (Kruskal/Prim); SCC; directed reachability; DAG DP; functional graphs; grid flood fill; BFS; bidirectional BFS; bipartite/game-theory hybrid.

**Required mapping:** LC 1135/1584 MST; CF 427C SCC; LC 2101 directed reachability; CF 919D DAG DP; USACO Why Did the Cow Cross the Road functional graph; LC 733 flood fill; LC 1197 knight BFS; LC 417 reverse multi-source BFS; LC 1263 state BFS; LC 815 route BFS; LC 854 permutation BFS; CF 190E bipartite/game hybrid; custom bidirectional BFS.

**Issues:** This topic is not a clean “Graph Fundamentals” progression. It mixes algorithms that have dedicated topics elsewhere (BFS, SCC/Advanced Graphs, DAG DP, bipartite, MST) and has no clear representation/modelling foundation. Foundational concepts should include directed vs undirected, adjacency list/matrix, weighted edges, multigraph/self-loop handling, components, edge classification, graph modelling and complexity in V/E. MST has no dedicated topic and should have a deliberate primary owner; it may deserve a focused MST path/topic if existing graph coverage does not otherwise teach it adequately.

**Recommendation:** Rebuild this topic around graph modelling and representation, with MST as an explicit graph family and cross-references to BFS/SCC/DAG/functional graphs. Reclassify misplaced problems while preserving stable problem IDs. **Verdict: Gap in topic coherence and foundational progression.**

## Topic 20 — BFS (23 required)

**Concept inventory:** reachability; connected components; directed reachability; multi-state BFS; shortest paths in unweighted graphs; grid BFS; implicit graph modelling; reverse graph BFS; 0-1 BFS; bidirectional BFS; BFS layer graph + path reconstruction; multi-source BFS cross-reference; algebraic post-processing of distances.

**Required mapping:** LC 1971/547/1319/2492/841/1466/2359 reachability/components; LC 1129 state-expanded BFS; CF 1037 BFS order validation; LC 802 reverse graph; LC 1293 resource-constrained state BFS; LC 1368 0-1 BFS; LC 1091/1926 grid BFS; LC 433/127/752/2059/1345 implicit graphs; LC 815 route-level graph; LC 126 Word Ladder II layer graph + DFS reconstruction; LC 2039 distance + formula; LC 1210 orientation-expanded state.

**Issues:** Connected components and reachability should be taught as foundational graph traversal but not confuse BFS with DFS; topic 21 should be linked. LC 802 is reverse-topological elimination using queue (Kahn-style), not shortest-path BFS. LC 1368 is 0-1 BFS and needs deque proof, not ordinary FIFO. LC 815 has multiple modelling choices (stop graph vs route graph) and complexity trade-offs. LC 126 Word Ladder II needs all shortest-path parents/layer semantics, not first-discovery-only BFS.

**Recommendation:** Separate ordinary reachability, shortest-path BFS, state-expanded BFS, implicit graph modelling, reverse-graph processing and 0-1 BFS. **Verdict: Partial concept coverage; Java not verified.**

## Cross-topic actions

1. Topic 17 already covers the proposed advanced-tree family; do not create duplicate required placements.
2. Topic 18 already contains Aho–Corasick and advanced XOR tries; reconcile with the future advanced-string inventory.
3. Establish MST as a primary graph concept; Topic 19 currently buries it inside an incoherent fundamentals chapter.
4. Reconcile duplicate problem placements across BIT/Segment Tree (LC 307), HashMap/Heap (LC 347), Sliding Window/Heap (LC 480), Sliding Window/Monotonic Deque (LC 239, 1438), Intervals/Heap (LC 253, 1851), and Prefix Sums/BIT (LC 327).
5. Preserve multi-algorithm problems only when each placement teaches a demonstrably distinct algorithmic objective.
6. Do not add new questions yet. The first priority is concept ownership, proof quality and verified Java artifacts.

**Batch 2 final:** Topics 11–18 have substantial breadth but are not certified mastery-ready. Topic 19 has a structural concept-ownership gap. Topic 20 has useful BFS breadth but needs clearer algorithm families. No Java implementation quality is verified from the available playback evidence.
