# Mastery Audit — Batch 3: Topics 21–30

**Audit date:** 2026-11-10  
**Evidence:** Production required placements and stored problem metadata.  
**Status:** Concept ownership and progression audit. Solution explanations and Java implementations remain unverified.

## Batch verdict

| Topic | Required | Concept coverage | Main finding | Readiness |
|---|---:|---|---|---|
| 21. DFS | 14 | Partial | Grid flood fill, tree serialisation and directed cycle states are mixed | Not verified |
| 22. Multi-Source BFS | 9 | Strong breadth | Good core pattern; advanced weighted/threshold combinations need proof | Not verified |
| 23. Bipartite Graph | 10 | Gap | Matching and functional graph problems mixed with 2-colouring | Not verified |
| 24. Topological Sort | 15 | Partial | Kahn/DFS and DAG DP are present, but non-DAG search placements remain | Not verified |
| 25. Dijkstra | 16 | Partial | Good variants; modified BFS and resource-constrained shortest paths need boundaries | Not verified |
| 26. Floyd–Warshall | 6 | Partial | Small, focused APSP family; two placements need classification/validation | Not verified |
| 27. Bellman–Ford | 7 | Partial | Negative-edge/cycle core is present; some placements are not Bellman–Ford | Not verified |
| 28. Union Find / DSU | 13 | Partial | Good weighted/offline DSU and MST; overlaps graph fundamentals and islands | Not verified |
| 29. Advanced Graph Algorithms | 14 | Gap | Strong algorithms are mixed with unrelated BFS, DSU, matching and MST | Not verified |
| 30. 1D Linear DP | 24 | Gap | Topic is not truly 1D linear DP; contains multiple distinct DP families and optimisations | Not verified |

## Topic 21 — DFS (14 required)

**Concept inventory:** recursive/iterative DFS; tree bounds and validation; serialization; connected-component flood fill; boundary-triggered inverse marking; reverse reachability; island recolouring; directed graph 3-colour cycle detection; safe-state classification; postorder/topological ordering; path/dead-end validation.

**Required mapping:** LC 98 BST bounds; 297 serialization; 200/695 component flood fill; 130/1254/1020 boundary elimination; 417 reverse reachability; 827 island recolouring; 1905 two-grid validity; 207/210/802/1059 directed cycle and safe-state DFS.

**Issues:** LC 210's postorder DFS topo solution is valid, but it also appears in Topological Sort; choose one primary teaching placement. LC 802 appears in BFS and Advanced Graph Algorithms as well; its reverse-graph queue algorithm is not a DFS-specific exercise unless the DFS colouring variant is explicitly taught. The topic should teach recursion-stack vs global-visited distinctions, iterative DFS stack safety, and why a visited state may need three colours (unvisited/visiting/done). Flood fill overlaps BFS; compare stack/queue memory and recursion-depth risks.

**Recommendation:** Split DFS into traversal/flood fill, tree recursion, directed-cycle state and postorder/DAG processing. Make the DFS-specific variant primary and cross-reference BFS. **Verdict: Partial concept coverage; Java not verified.**

## Topic 22 — Multi-Source BFS (9 required)

**Concept inventory:** initialise queue with all sources; distance-to-nearest-source; reverse source/target interpretation; level propagation; Voronoi partitioning; multi-source expansion followed by a second phase; state-expanded multi-source BFS; competing propagation fronts; binary search on safety/wait thresholds.

**Required mapping:** LC 994 rotting propagation; 542 nearest-zero transform; 1162 farthest-from-source; 1765 level assignment; 286 nearest gate; 934 DFS island + multi-source expansion; 2812 safety threshold; 847 all-node start states with visited mask; 2258 competing fire/person propagation with wait-time search.

**Issues:** This is a coherent topic. LC 847 is multi-source over a product state (node, visited mask), so it also teaches bitmask state-space BFS and may belong primarily in BFS/bitmask DP. LC 2812/2258 combine multi-source BFS with binary search or maximin path feasibility; those combined proofs must be explicit. Need discuss unreachable cells, queue initialisation, tie ownership/Voronoi interpretation, and why all sources start at distance zero.

**Recommendation:** Keep the topic. Teach the multi-source invariant once, then use the later problems to test combinations. No immediate addition required. **Verdict: Strong breadth; solution/Java not verified.**

## Topic 23 — Bipartite Graph (10 required)

**Concept inventory intended:** two-colouring; odd-cycle detection; conflict graph construction; DSU enemy-node technique; bipartite matching via augmenting paths; Hopcroft–Karp level graph; König's theorem / min vertex cover relationship.

**Required mapping:** LC 785/886/2493 2-colouring; LC 1042 greedy graph colouring (related but not bipartite); custom 2N DSU enemy nodes; LC 2127 functional graph (misclassified); LC 2410 greedy sorted matching; LC 1057 priority matching; LC 1820 augmenting path; custom Hopcroft–Karp.

**Issues:** LC 2127 is functional-graph cycle decomposition with two-cycle chain extensions, not bipartite graph. LC 2410 and 1057 are greedy matching variants, not general bipartite matching algorithms. LC 1042 is a bounded-degree graph-colouring observation, not bipartite colouring. Matching is a major concept family and needs augmenting-path correctness, alternating paths, matching/cover duality and Hopcroft–Karp complexity. A matching result alone does not teach max flow/min cut or min-cost matching.

**Recommendation:** Move LC 2127 to functional graphs / Advanced Graph Algorithms. Keep 2410/1057 as contrast exercises only if they teach why special sorted matching is easier than general matching. Make LC 1820 and Hopcroft–Karp the core matching progression. **Verdict: Gap in concept ownership; matching depth needs strengthening.**

## Topic 24 — Topological Sort (15 required)

**Concept inventory:** Kahn's algorithm; DFS postorder; cycle detection; unique ordering; leaf peeling on undirected trees; transitive closure/reachability; level/semester scheduling; hierarchical/group dependencies; recipe/supply propagation; DAG longest path and DP; bitmask scheduling on DAG.

**Required mapping:** LC 207/210 Kahn/DFS; 444 uniqueness; 310 leaf peeling; 1462 reachability; 269 derived alphabet graph; 1136 levels; 2392 independent DAG orders; 1203 hierarchical topo; 2115 supply propagation; 329 implicit DAG DP; 1494 DAG + bitmask scheduling; 2466 implicit-state DP; 2050 critical path; LC 2065 constrained DFS (misclassified).

**Issues:** LC 2065 Maximum Path Quality is constrained DFS/backtracking with time budget, not topological sort. LC 329 can be modelled as DAG DP, but its standard memoised DFS is a distinct implementation of implicit topological order. LC 2466 is counting DP on an implicit acyclic state graph, not a conventional graph problem. LC 310 is tree-centre leaf peeling, not general topological sorting. Need prove that a DAG has a topological ordering iff no directed cycle; explain uniqueness via the queue having exactly one available vertex at every step. For grouped dependencies, teach why a single global topo order is insufficient.

**Recommendation:** Reclassify LC 2065; keep DAG DP examples only with explicit state graph and topological dependency reasoning. Separate tree leaf peeling as an adjacent technique. **Verdict: Partial concept coverage; Java not verified.**

## Topic 25 — Dijkstra (16 required)

**Concept inventory:** non-negative edge weights; relaxation; priority queue with lazy stale-entry deletion; max-product probability path; counting shortest paths; shortest-path DAG post-processing; multi-source/meeting-point paths; unknown edge-weight assignment; minimax path; grid and implicit graph; time-dependent parity; resource-expanded state; special-road compression.

**Required mapping:** LC 1514 max-product; custom undirected SSSP; 882 subdivided edge counting; 743 standard SSSP; 1976 count shortest paths; 1786 shortest-path DAG DP; 2203 three-source meeting; 2699 edge-weight assignment; 1631/778 minimax grid paths; 505 rolling-state graph; 2577 parity waiting; 787 stop-constrained state; 2093 discount-state; 2662 special-road graph; 2045 second minimum with traffic lights (modified BFS).

**Issues:** LC 2045 is a modified BFS with two distances per node and traffic-light timing; it is not Dijkstra in the stated solution. LC 787 is a bounded-edge/resource problem where layered DP/Bellman–Ford is often the clearer primary model; if Dijkstra is used, state expansion and complexity must be proved. LC 2699 requires a careful constructive two-pass argument, not just standard Dijkstra. Need explicit non-negative-weight precondition, why settled distances are final, stale queue handling, overflow and zero-weight behavior. LC 1976 needs correct equal-distance path-count updates and modular arithmetic.

**Recommendation:** Reclassify LC 2045 to BFS. Keep state-expanded Dijkstra only where non-negative edge costs and expanded-state correctness are explicit. **Verdict: Partial concept coverage; Java not verified.**

## Topic 26 — Floyd–Warshall (6 required)

**Concept inventory:** all-pairs shortest paths; k-intermediate invariant; negative edges; negative-cycle detection/reachability; path reconstruction; semiring-like alternative path algebras (min-plus, minimax, max-product); small dense graph constraints.

**Required mapping:** LC 1334 standard APSP; 399 multiplicative ratio closure; 1591 dependency/reachability (may use DFS/topological closure); 2976 26-node transformation APSP; custom next-matrix reconstruction; custom minimax bottleneck closure.

**Issues:** LC 1591 is fundamentally topological feasibility over colour dependencies; Floyd–Warshall is an optional reachability implementation, not its primary lesson. LC 399 uses multiplicative transitive relations and can be taught as weighted graph traversal; if retained, explain the algebraic recurrence. The k-loop must be outermost for the standard in-place recurrence. Need negative-cycle propagation: if dist[k][k] < 0, every pair that can reach k and be reached from k is affected. Six problems may be enough if the custom exercises are complete and rigorous.

**Recommendation:** Keep the focused topic; move LC 1591 to Topological Sort and treat LC 399 as a semiring/closure comparison. No volume expansion required. **Verdict: Partial concept coverage; Java not verified.**

## Topic 27 — Bellman–Ford (7 required)

**Concept inventory:** repeated edge relaxation; V−1 rounds; early termination; negative edges; reachable negative-cycle detection on Vth round; path reconstruction; bounded-edge shortest paths; log transformation for arbitrage; SPFA queue heuristic and worst-case behavior.

**Required mapping:** LC 743 (positive-weight SSSP; Dijkstra is preferable, weak BF evidence); LC 787 bounded K-edge relaxation; LC 1928 time-layer DP (not Bellman–Ford); custom forced negative-edge SSSP; custom negative-cycle detection; custom currency arbitrage; custom SPFA.

**Issues:** LC 743 is a poor required Bellman–Ford example because all edge weights are positive and Dijkstra is more appropriate. LC 1928 is constrained shortest path / time-indexed DP, not Bellman–Ford. Need careful distinction between reachable negative cycles and any negative cycle in the graph (super-source construction). SPFA is not a better asymptotic algorithm; teach adversarial worst cases. For K-stop flights, use a copy of the previous distance array each round if the intent is at most a bounded number of edges; in-place relaxation changes the semantics.

**Recommendation:** Replace the two weakly classified LeetCode placements one-for-one with genuine negative-edge / cycle cases if custom exercises do not already supply complete, testable statements. **Verdict: Partial concept coverage; Java not verified.**

## Topic 28 — Union Find / DSU (13 required)

**Concept inventory:** parent/size/rank; path compression; union by size/rank; component counting; cycle detection; Kruskal; critical/pseudo-critical MST edges; offline reverse-time connectivity; weighted/potential DSU; DSU on transformed domains (emails, strings, prime factors); island flip queries.

**Required mapping:** LC 547/323/1319 components; 684 cycle; 261 tree validation; 1584/1489 MST; 721 account grouping; 399 weighted DSU; 839 string-similarity components; 1202 component sorting; 827 island flip; 1970 reverse-time connectivity.

**Issues:** LC 547/1319 duplicate concepts also taught in BFS. LC 1584 is also in Graph Fundamentals. LC 827 is also in DFS. Duplicates are justified only if one placement teaches BFS vs DSU contrast or DSU-specific component aggregation. Weighted DSU needs a precise potential invariant and direction convention. Reverse-time DSU needs explain why deleting forward edges becomes adding reverse edges. Need amortised inverse-Ackermann complexity and note that rollback DSU cannot use ordinary path compression.

**Recommendation:** Keep DSU-specific problems, but establish a primary owner for duplicate component/MST problems. Add rollback DSU only if later offline-query topics require it and there is no existing exercise. **Verdict: Partial concept coverage; Java not verified.**

## Topic 29 — Advanced Graph Algorithms (14 required)

**Concept inventory actually present:** bridges; articulation points; edge/vertex connectivity; SCC-related safe states; functional graph cycle decomposition; Eulerian path/circuit; itinerary reconstruction; de Bruijn sequence / Eulerian construction; tree pruning; bipartite matching; MST.

**Required mapping:** LC 1192 bridges; 1568 articulation/bridge-based disconnection; 928 malware/vertex-removal connectivity; custom articulation points; 2603 tree pruning; 802 safe states; 1557 source vertices (misclassified); 2360/2876 functional graphs; 332/2097 Eulerian trails; 753 de Bruijn/Eulerian cycle; 1349 bipartite matching; 1168 MST.

**Issues:** LC 1557 is an in-degree/source-vertex observation, not advanced graph algorithms. LC 802 belongs reverse graph / safe states. LC 1349 is bipartite matching (or bitmask DP alternative), not a generic advanced graph topic. LC 1168 is MST with a virtual source node; primary owner should be MST/DSU. LC 2603 is tree pruning/DP and belongs Trees. Topic lacks clearly identified required SCC implementations despite the concept family being important; CF 427C SCC currently sits in Graph Fundamentals. It also lacks Dinic max-flow, min-cut, vertex-disjoint paths and min-cost flow.

**Recommendation:** Rebuild Advanced Graph Algorithms around SCC (Tarjan/Kosaraju), bridges/articulation, biconnected structure, Eulerian paths and functional graphs. Reassign unrelated rows. Matching/flow should have a dedicated owner if added. **Verdict: Gap in coherent coverage.**

## Topic 30 — 1D Linear DP (24 required)

**Concept inventory actually present:** fixed-window recurrences; counting subarrays; house robber; circular independent set; state machines; Catalan; max/min subsequence states; LIS; LCS; palindrome DP; word break; paint house; D&C DP; CHT; bounded knapsack; ticket parsing.

**Required mapping:** LC 746/983 simple 1D transitions; 413 subarray counting; 198/213/740/1388 skip-one/circular; 639 decode count; 96 Catalan; 2708 max/min subsequence state; 256/552/265 state machine; 300/368 LIS; 873/1027 difference-indexed subsequence DP; 1143 LCS; 5 palindrome span; 472 word break; 2218 bounded knapsack; 1416 parsing; CF 311E D&C optimisation; custom CHT.

**Issues:** This topic is not a coherent 1D linear DP curriculum. It includes LIS (Topic 14), state machine DP (Topic 34), knapsack (Topic 32), strings DP (Topic 33), interval/span DP and advanced optimisation. LC 300 appears in LIS and Topic 30. LC 472 appears in HashMap and Trie. CHT and divide-and-conquer optimisation are not beginner 1D DP variants; they require their own preconditions and proof. LC 1143 is 2D DP with rolling memory, not inherently 1D. Need distinguish 1D array DP from rolling a 2D recurrence into one row.

**Recommendation:** Rebuild Topic 30 around genuine linear state recurrences and foundational DP proof. Reclassify LIS, state-machine, knapsack, string, interval and optimisation placements to their specialist topics. Preserve all problem IDs and use one primary owner. **Verdict: Gap in topic coherence and progression.**

## Cross-topic actions

1. Rebuild Graph Fundamentals (19) and Advanced Graph Algorithms (29) into coherent graph families.
2. Remove misclassified LC 2127 from Bipartite Graph; LC 2065 from Topological Sort; LC 2045 from Dijkstra; LC 1557 from Advanced Graph Algorithms; LC 1928 from Bellman–Ford.
3. Move LC 1591 from Floyd–Warshall to Topological Sort as primary owner.
4. Resolve duplicate ownership for LC 210, 802, 547, 1319, 1584, 827, 300 and 472.
5. Rebuild 1D DP around state/recurrence/proof, and assign specialist DP families to their dedicated topics.
6. Evaluate a dedicated MST family and a Network Flow/Matching family. Existing matching rows are insufficient to imply full flow/min-cut coverage.
7. No new required rows should be added until the full 43-topic concept inventory is complete and all duplicate ownership is reconciled.

**Batch 3 final:** Multi-source BFS is the strongest coherent chapter in this batch. Bipartite Graph, Advanced Graph Algorithms and 1D Linear DP have substantial classification/progression issues. The current graph curriculum does not yet demonstrate authoritative mastery of MST, SCC and network flow as distinct families. Solution and Java quality remain unverified.
