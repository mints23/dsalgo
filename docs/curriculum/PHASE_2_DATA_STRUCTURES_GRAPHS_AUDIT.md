# Phase 2 Curriculum Audit — Data Structures and Graphs

**Scope:** Live production topics 10–29. Initial question metadata and sub-variant review; not yet a full solution-correctness review.

## Inventory

| ID | Topic | Rows | Easy excluded | Medium | Hard | Custom / no LC ID | Findings |
|---:|---|---:|---:|---:|---:|---:|---|
| 10 | Sieve of Eratosthenes | 18 | 0 | 12 | 6 | 2 | Covers classic/segmented sieve, SPF, totient, factor grouping and traps |
| 11 | Fenwick Tree / BIT | 18 | 1 | 4 | 13 | 3 | Covers 2D BIT, range updates, order statistics, compression and offline sweeps |
| 12 | Segment Tree | 20 | 0 | 4 | 16 | 2 | Covers lazy propagation, persistent/implicit trees, merge-sort tree, beats and DP nodes |
| 13 | KMP Pattern Matching | 18 | 0 | 10 | 8 | 1 | Includes failure function, automaton, Z-function and string borders; clarify topic ownership |
| 14 | LIS O(N log N) | 19 | 0 | 10 | 9 | 1 | Covers reconstruction, counting, multidimensional and constrained LIS |
| 15 | Top K Elements / Heap | 52 | 1 | 29 | 22 | 0 | Very broad heap catalogue; includes heaps, dual heaps, scheduling, lazy deletion and traps |
| 16 | Monotonic Stack/Queue | 41 | 0 | 24 | 17 | 2 | Broad monotone stack/deque patterns, contribution counting, DP windows and traps |
| 17 | Trees | 49 | 0 | 23 | 26 | 6 | Includes LCA, binary lifting, Euler tour, HLD, centroid decomposition, rerooting, DSU on tree and virtual tree |
| 18 | Trie | 25 | 0 | 14 | 11 | 3 | Includes binary/persistent XOR trie, Aho–Corasick, suffix trie, trie + DP and offline queries |
| 19 | Graph Fundamentals | 35 | 0 | 21 | 14 | 5 | Broad foundation including SCC, bridges, MST, functional graphs, DAGs and implicit graphs |
| 20 | BFS | 39 | 0 | 29 | 10 | 0 | Includes 0-1 BFS, state-expanded BFS, implicit graphs, multi-source/reverse BFS and correctness traps |
| 21 | DFS | 39 | 3 | 18 | 10 | 8 | Includes Tarjan-style cycle logic, Euler path, flood fill, postorder and backtracking overlap |
| 22 | Multi-Source BFS | 20 | 0 | 12 | 4 | 4 | Focused on source initialization, propagation, competing sources, state expansion and binary search |
| 23 | Bipartite Graph | 15 | 1 | 12 | 2 | 4 | Covers 2-coloring and some matching/DSU-on-2N; only 2 Hard rows |
| 24 | Topological Sort | 22 | 0 | 11 | 7 | 5 | Includes Kahn, DFS order, cycle validation, DAG DP, multi-level topo and uniqueness |
| 25 | Dijkstra | 21 | 0 | 11 | 10 | 3 | Covers state-expanded shortest paths, minimax/max-product, 0-1 BFS contrast and negative-edge traps |
| 26 | Floyd–Warshall | 13 | 1 | 8 | 4 | 5 | Covers APSP, path reconstruction, minimax recurrence and negative-cycle/overflow traps |
| 27 | Bellman–Ford | 13 | 0 | 11 | 2 | 5 | Covers negative cycles, bounded-edge DP, arbitrage and Dijkstra contrast |
| 28 | Union Find | 20 | 0 | 12 | 4 | 6 | Covers weighted DSU, reverse/offline DSU, Kruskal and directed-graph traps |
| 29 | Advanced Graphs | 20 | 0 | 5 | 11 | 20* | Includes bridges/articulation points, SCC, Eulerian paths, MST edge classification, functional graphs, matching and graph reductions |

*For topic 29, `lc_number` is null on all 20 rows even though most rows have LeetCode URLs and LeetCode problem titles. The reported custom count is therefore a metadata defect, not a reliable count of custom problems. Also, 16/20 rows have no `sub_variant`; key insights contain substantial explanations, so this is primarily a structured-metadata problem rather than proof of missing content.

## Findings and decisions

### Existing coverage is already advanced in several areas
- Trees already includes binary lifting, Euler tours, HLD, centroid decomposition, DSU on tree, rerooting and virtual trees. Do not add these as separate topics.
- Fenwick and Segment Tree already cover advanced variants including 2D BIT, persistent segment tree, segment tree beats and tree-based DP.
- Monotonic Stack/Queue is intentionally distinct from a general Stack/Queue topic. The latter should cover stack/queue design, parsing and amortized behavior without copying monotone patterns.
- Trie includes Aho–Corasick and persistent/binary XOR variants, but it does not replace suffix arrays, suffix automata or Manacher.
- BFS/DFS and graph fundamentals already include state-space search, SCC/bridges, MST and Eulerian ideas; a new graph topic should focus on a genuinely missing algorithm family.

### Priority gaps confirmed by the topic inventory
1. **Network Flow & Matching — add a dedicated advanced topic.** Bipartite Graph has only a small matching slice. Create a coherent progression through augmenting paths, residual graphs, max-flow/min-cut, Dinic, matching reductions, vertex/edge capacities, min-cost max-flow, and when matching/flow can be replaced by bitmask DP. Include correctness proofs and residual-network invariants.
2. **Offline Query Algorithms — add a dedicated advanced topic if the full body review confirms no coherent coverage.** Existing examples are scattered across BIT, Trees, DSU and Advanced Graphs. Cover query reordering, sweep-line, Mo's algorithm, parallel binary search, rollback DSU, offline LCA, CDQ and divide-and-conquer on time. Teach the decision framework and trade-offs, not a disconnected list.
3. **Advanced String Algorithms — add.** Existing KMP/Z and Trie/Aho–Corasick do not constitute a full suffix/palindrome/string-indexing curriculum. Include rolling hash, Manacher, suffix array + LCP, suffix automaton, and multi-pattern matching; cross-link existing KMP and Trie.
4. **Bit Manipulation & Bitmask Techniques — add.** Current use is embedded in Backtracking, Game Theory, Knapsack and Profile DP. Teach bit algebra, subset/submask enumeration, SOS DP, bitsets and state compression as reusable techniques.
5. **Sorting & Selection — add.** QuickSelect appears under Top K, but no coherent advanced treatment of partitioning, selection, inversion counting, stable ordering, comparator proofs, and non-comparison sorting exists as a standalone learning path.
6. **Linked Lists — add.** Two Pointers contains several list exercises, but no dedicated path for pointer rewiring, reversal families, merge/sort, random-pointer cloning, and structural invariants.
7. **Stack, Queue & Deque — add.** Monotonic Stack/Queue does not cover general-purpose stack/queue design, parsing, nested expressions, amortized queue constructions and deque API/invariants.
8. **Mathematics & Number Theory — add.** Sieve and Combinatorial & Modulo DP cover fragments but not a coherent prerequisite path for gcd/extended Euclid, modular inverses, CRT, factorization, divisor functions, combinatorics and Diophantine equations.

### Further topics to evaluate
- Computational Geometry: inspect actual content and problem statements for orientation, convex hull, line sweep, closest pair and geometric sweeps before deciding whether standalone.
- Divide & Conquer: some D&C DP and CDQ appear in Data Structure Optimized DP, but a general divide-and-conquer algorithm topic may still be justified.

## Data-quality work required
- Topic 29: populate canonical `lc_number` for LeetCode URLs and map all 20 rows to explicit sub-variants. Do not change title or URL without verifying the canonical source.
- Topics 21, 23 and 26 contain Easy rows; exclude them from required learning while preserving them as optional reference.
- Custom problems in topics 21–29 need source URLs or complete statements. A missing LeetCode URL is not itself an error for Codeforces/AtCoder/CSES/USACO items.
- Preserve all rows and source metadata during audit; do not seed replacements yet.

## Status

This is an initial inventory and topic-ownership review. It is not a final certification that every listed topic is complete. Detailed statement/solution review and mastery assessments are still required.
