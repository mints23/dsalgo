# Progressive Concept Audit — Phase 3B (Topics 25–29)

**Source:** Live production problem rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 25 — Dijkstra

**Inventory:** 21 placements; 19 Medium/Hard plus 2 rows with missing/diagnostic metadata.  
**Verdict:** **Strong advanced shortest-path coverage. The best sequence is from standard SSSP to alternative path objectives, state expansion, and implicit graphs.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Path with Maximum Probability | Max-heap Dijkstra with multiplicative relaxation | Core objective mutation |
| 2 | Undirected SSSP Template Drill (custom) | Standard positive-weight SSSP and bidirectional adjacency construction | Core implementation drill; statement/source required |
| 3 | Reachable Nodes in Subdivided Graph | Dijkstra on original nodes plus edge-budget accounting for virtual subdivided nodes | Core integration |
| 4 | Find the City With the Smallest Number of Neighbors at a Threshold Distance | Repeated SSSP vs Floyd-Warshall when V is small | Diagnostic / cross-link Floyd-Warshall |
| 5 | Network Delay Time | Canonical directed positive-weight SSSP; answer is maximum settled distance | Core foundation |
| 6 | Number of Ways to Arrive at Destination | Count shortest paths alongside distances; handle equal-distance relaxation | Core extension |
| 7 | Number of Restricted Paths From First to Last Node | Dijkstra from sink induces a DAG; count paths by increasing distance | Advanced integration |
| 8 | Minimum Weighted Subgraph With Required Paths | Three Dijkstra runs and optimize over a shared meeting node | Advanced multi-source composition |
| 9 | SSSP With Negative Edges (No Negative Cycles) | Dijkstra's settlement invariant fails with negative edges; use Bellman-Ford | Diagnostic trap |
| 10 | Modify Graph Edge Weights | Assign unknown weights using forward/reverse shortest-distance structure | Advanced construction; independently verify detailed assignment proof |
| 11 | Path With Minimum Effort | Minimize maximum edge difference; minimax Dijkstra relaxation | Core objective generalization |
| 12 | Swim in Rising Water | Minimize maximum cell height along a path | Reinforcement / same minimax family |
| 13 | Minimum Cost to Make at Least One Valid Path in Grid | 0-1 BFS is preferable when edge weights are only 0/1 | Core algorithm-selection extension |
| 14 | The Maze II | Implicit graph of wall-stop positions; rolling distance is edge weight | Core implicit weighted graph |
| 15 | Minimum Time to Visit a Cell in a Grid | Time/parity-constrained waiting; parity-adjusted arrival time | Advanced state/time model |
| 16 | Cheapest Flights Within K Stops | Expand state to (city, stops used); resource dimension limits path length | Core state-expanded shortest path |
| 17 | Minimum Cost to Reach City With Discounts | Add coupon count to state and choose full/discounted transition | Core resource-token extension |
| 18 | Shortest Path in Grid With Obstacles Elimination | Same state expansion with unit edges; BFS rather than Dijkstra | Cross-link BFS; compare edge weights |
| 19 | Minimum Cost of a Path With Special Roads | Reduce continuous coordinate space to special endpoints, then run Dijkstra | Advanced graph reduction |
| 20 | Second Minimum Time to Reach Destination | Track first and strict second arrival with traffic-light waiting | Diagnostic: specialized second-arrival BFS, not ordinary Dijkstra |
| 21 | Multi-Coupon Minimum Path (custom) | Exponential coupon bitmask state makes naive expanded Dijkstra infeasible | Diagnostic trap; statement/source required |

### Recommended changes

- Sequence #5 → #6 → #7 → #8 to build from shortest distances to path counts, distance-induced DAGs, and shared meeting points.
- #1, #11, and #12 show that Dijkstra can optimize different monotone path objectives; require proof that the relaxation preserves label-setting correctness.
- #13 should be a distinct 0-1 BFS lesson; #15 is a time-dependent Dijkstra lesson, not BFS.
- #16 → #17 → #18 form a useful state-expansion family. Require an explicit state-space size calculation before choosing an algorithm.
- #4 belongs canonically to Floyd-Warshall; #9 to Bellman-Ford; #20 to BFS/second-shortest paths. Keep them as decision-boundary diagnostics.
- #10 needs an independent correctness review; the current explanation's formula and edge-processing order are subtle.
- #2 and #21 need complete statements and bounds.
- #3 and #19 are strong graph-reduction questions; teach why only original/special nodes need to be represented.
- Final capstone should make learners choose among Dijkstra, 0-1 BFS, Bellman-Ford, Floyd-Warshall, and state-expanded shortest path from weight and state constraints.

---

## Topic 26 — Floyd-Warshall

**Inventory:** 13 placements; 12 Medium/Hard and 1 Easy reference.  
**Verdict:** **Good coverage of all-pairs closure, semiring-like recurrence changes, path reconstruction, and limitations. Several rows currently use Floyd-Warshall as an unnecessary or incorrect canonical technique.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Find City With Smallest Number of Neighbors at Threshold Distance | Standard APSP then count threshold-reachable nodes | Core foundation |
| 2 | Minimum Score of Path Between Two Cities | Connected-component membership and minimum edge scan; Floyd is unnecessary | Diagnostic trap / Graph Traversal |
| 3 | Number of Good Paths | DSU by value threshold is the scalable solution, not APSP | Diagnostic trap / DSU |
| 4 | Find Center of Star Graph | Direct common endpoint of first two edges | Easy reference / method selection |
| 5 | Count Pairs of Nodes | Current metadata claims Floyd/APSP, but the official problem's scalable solution is degree sorting plus correction for shared edges | Review urgently; likely misclassified algorithm |
| 6 | Evaluate Division | Multiplicative path closure or DFS per query | Core alternate algebra |
| 7 | Strange Printer II | Build color dependency graph and detect cycle with topo sort; Floyd closure is not needed | Diagnostic / Topological Sort |
| 8 | Minimum Cost to Convert String I | 26-node weighted character graph makes Floyd-Warshall practical | Core application |
| 9 | Path Reconstruction via next[][] matrix (custom) | Maintain next-hop matrix alongside distances | Core output extension; statement/source required |
| 10 | Minimax Bottleneck All-Pairs Path (custom) | Replace additive path composition with max-edge, then minimize bottleneck | Advanced recurrence generalization; formalize semiring interpretation |
| 11 | Using Floyd-Warshall on V > 500 | O(V³) feasibility boundary and algorithm choice | Diagnostic trap |
| 12 | Negative Cycle Not Detected | Negative diagonal after closure indicates a negative cycle | Diagnostic trap |
| 13 | Integer Overflow on dist[i][k] + dist[k][j] | Guard infinity before addition and choose safe numeric range | Diagnostic trap |

### Recommended changes

- #1 → #8 → #9 → #10 is the true core path: ordinary min-plus closure, fixed small graph application, path reconstruction, then changed path algebra.
- #5 must be corrected or removed from the Floyd core. The problem's constraints and intended solution do not support the current claimed Floyd-Warshall method.
- #2, #3, #4, and #7 are valuable "don't reach for APSP" diagnostics; do not list them as Floyd-Warshall variants.
- #6 is a valid multiplicative closure, but use the correct semiring interpretation and account for inconsistent cycles / contradictory ratios if the problem requires it.
- #10 needs a fully specified graph/query statement and a proof that the recurrence computes a minimum bottleneck path.
- Explain O(V³) time and O(V²) memory, negative-edge support, and negative-cycle detection.
- Final capstone should ask learners to select an all-pairs method, reconstruct an actual route, and change the path-combination operator for a bottleneck objective.

---

## Topic 27 — Bellman-Ford

**Inventory:** 13 placements; all Medium/Hard.  
**Verdict:** **Strong coverage of negative edges, bounded-edge shortest paths, and negative-cycle applications, but several entries are Dijkstra/DP/Prim alternatives rather than Bellman-Ford concepts.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Network Delay Time | Bellman-Ford template on a positive graph; Dijkstra is faster | Core template drill / method comparison |
| 2 | Cheapest Flights Within K Stops | Exactly K+1 snapshot relaxations bound path edge count | Core progression |
| 3 | Minimum Cost to Reach Destination in Time | Time-indexed DP over transitions; Bellman-Ford-like layers | Cross-link DP |
| 4 | Forced Negative-Edge SSSP (custom) | Concrete counterexample proving Dijkstra fails with negative edges | Core negative-edge motivation; statement required |
| 5 | Find Negative Cycle in Graph | Relaxation on Vth pass proves negative cycle; propagate affected nodes | Core extension |
| 6 | Currency Arbitrage Detection | Log-transform product >1 into negative cycle | Advanced application |
| 7 | Minimum Cost to Reach City With Discounts | State-expanded Dijkstra/Bellman-Ford with coupon count | Cross-link Dijkstra |
| 8 | Second Minimum Time to Reach Destination | Track two arrival times with BFS and traffic-light timing | Diagnostic / BFS |
| 9 | Minimum Cost to Connect All Points (Prim's) | Dense MST via Prim, not shortest-path relaxation | Diagnostic / MST |
| 10 | SPFA Implementation with Negative-Cycle Detection | Queue-based relaxation; often fast but worst-case O(VE) | Advanced variant; verify cycle-detection counter semantics |
| 11 | Cheapest Flights — Multi-hop in One Pass | Snapshot-copy requirement prevents multiple-edge relaxation in one iteration | Diagnostic trap |
| 12 | Applying Dijkstra to Negative-Edge Graph | Settlement invariant invalidated by negative edges | Diagnostic trap |
| 13 | Overflow in dist[u] + w When dist[u] = ∞ | Guard unreachable source before addition | Diagnostic trap |

### Recommended changes

- #1 should not imply Bellman-Ford is the preferred algorithm for positive weights; teach it as a template, then contrast with Dijkstra.
- #2 is the best core follow-up because it changes the number of relaxation passes and requires a snapshot of the previous layer.
- #4 should be a short counterexample assessment immediately before #5.
- #5 → #6 is a strong progression from negative-cycle detection to log-domain arbitrage.
- #3 and #7 are state-expanded/time-constrained shortest path, not unique Bellman-Ford concepts.
- #8 and #9 are BFS and Prim respectively; move to method-selection diagnostics.
- #10 needs careful validation: distinguish number of successful relaxations, path-edge count, and enqueue count. Not every casual counter variant is a sound negative-cycle detector.
- Add a clear note that Bellman-Ford handles negative edges but cannot produce finite shortest paths for nodes affected by reachable negative cycles.
- Final capstone should require a negative-cycle-aware SSSP with affected-node reporting and a proof of V−1 relaxation sufficiency.

---

## Topic 28 — Union-Find / DSU

**Inventory:** 20 placements; 18 Medium/Hard and 2 rows with missing-difficulty trap metadata.  
**Verdict:** **A strong progression from components and cycle detection to MST, weighted DSU, offline reversal, and DSU applications. The curriculum should explicitly teach DSU invariants and separate directed-graph traps.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Number of Provinces | DSU component count and successful-union decrement | Core foundation |
| 2 | Redundant Connection | First edge joining already-connected endpoints closes an undirected cycle | Core progression |
| 3 | Graph Valid Tree | Edge-count and cycle checks establish connected acyclic tree | Core property |
| 4 | Number of Connected Components | Maintain component counter during unions | Reinforcement / alternative formulation |
| 5 | Min Cost to Connect All Points | Kruskal: sort edges and accept only successful unions | Core MST integration |
| 6 | Find Critical and Pseudo-Critical MST Edges | Recompute MST excluding/forcing candidate edge | Advanced MST analysis |
| 7 | Number of Operations to Make Network Connected | Count spare edges and components; need C−1 spare links | Core resource accounting |
| 8 | Accounts Merge | DSU over email identity; group by root and reconstruct records | Core identity integration |
| 9 | Evaluate Division | Weighted DSU stores multiplicative ratio to root | Core weighted DSU |
| 10 | Similar String Groups | Pairwise similarity test creates DSU components | Core custom relation |
| 11 | Smallest String With Swaps | Connected component indices can be freely permuted | Core component payload |
| 12 | Making A Large Island | Component size metadata and unique-neighbor merge after one flip | Advanced grid integration |
| 13 | Last Day Where You Can Still Cross | Reverse time and restore cells; first connected state yields answer | Advanced offline reversal |
| 14 | Redundant Connection II (Directed) | Directed arborescence has two-parent and cycle cases; DSU alone is insufficient | Diagnostic trap |
| 15 | DSU Without Path Compression | Degenerate find chains cause linear-time operations | Diagnostic trap |
| 16 | Using DSU on Directed Graphs for Cycle Detection | DSU connectivity is undirected; directed cycle needs DFS/SCC | Diagnostic trap |
| 17 | Not implementing path compression in find() | Path compression prevents repeated root traversal | Diagnostic trap |
| 18 | Not using union by rank/size | Union by size/rank prevents tall trees | Diagnostic trap |
| 19 | Using DSU for directed cycle detection | Repeated method-selection trap | Consolidate with #16 |
| 20 | Forgetting to initialize parent[i] = i | Root identity is required for valid DSU initialization | Diagnostic trap |

### Recommended changes

- Teach DSU as a reusable structure with explicit invariants: parent forest, find/root, path compression, union by size/rank, and component count.
- #1 → #2 → #3 → #5 is a good opening progression; #4 is reinforcement, not a new algorithm.
- #8 → #9 adds component payload and then weighted relationships; explain path-compression updates to weights carefully.
- #12 adds component metadata and multi-neighbor deduplication; #13 adds offline time reversal.
- #6 belongs to MST analysis and should build on #5, not appear as an unrelated trick.
- #14 is a specialized directed-tree case and should explain why standard DSU is insufficient.
- #15, #17, and #18 overlap; merge them into one DSU implementation diagnostic with separate tests for path compression, union by size, and initialization.
- #16 and #19 are duplicate directed-cycle traps; retain one canonical diagnostic.
- Add missing advanced DSU patterns if mastery scope requires them: rollback DSU, parity DSU, offline dynamic connectivity, and DSU-on-tree/small-to-large (cross-link Trees).
- Final capstone should combine offline query reversal, component metadata, and weighted/parity constraints, while requiring the learner to justify why a rollback or ordinary DSU is appropriate.

---

## Topic 29 — Advanced Graphs

**Inventory:** 20 placements; all Medium/Hard, with all 15 LeetCode URL rows now carrying canonical IDs and 5 custom/competitive-programming entries.  
**Verdict:** **Valuable advanced material, but it currently combines bridges/articulation points, SCC, functional graphs, Eulerian paths, MST, matching, and tree pruning. Use it as an advanced graph atlas with separate subtracks.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Critical Connections in a Network | Tarjan low-link bridge condition; parent edge ID required for multigraphs | Core bridge foundation |
| 2 | Minimum Number of Days to Disconnect Island | Articulation-point existence plus theorem that answer is at most two | Core bridge/AP application |
| 3 | Minimize Malware Spread II | Exclusive ownership of clean components by infected sources | Advanced component attribution |
| 4 | Find All Articulation Points (custom) | Root/non-root articulation conditions using discovery and low values | Core AP extension; statement required |
| 5 | Collect Coins in a Tree | Prune zero-coin leaves, then two additional leaf layers | Tree pruning; cross-link Trees |
| 6 | Find Eventual Safe States | Reverse terminal reachability or SCC cycle classification | Cross-link SCC/Topo |
| 7 | Minimum Number of Vertices to Reach All Nodes | In-degree-zero source selection in DAG; no SCC needed | Misclassified; move to Topological Sort |
| 8 | Longest Cycle in a Graph | Functional graph timestamps identify cycle length in linear time | Core functional graph |
| 9 | Count Visited Nodes in a Directed Graph | Separate cycle nodes from incoming tails and memoize cycle reach | Core functional graph extension |
| 10 | Reconstruct Itinerary | Hierholzer's algorithm for lexicographically smallest Euler trail | Core Eulerian path |
| 11 | Valid Arrangement of Pairs | Directed pairs become edges; use degree imbalance and Hierholzer | Core Eulerian reduction |
| 12 | Cracking the Safe | De Bruijn graph maps length-k strings to edges and seeks Euler circuit | Advanced Eulerian construction |
| 13 | Min Cost to Connect All Points | Dense Prim MST; array-based O(V²) beats materializing all edges | Cross-link MST |
| 14 | Maximum Students Taking Exam | Maximum independent set in bipartite conflict graph via Konig/max matching; bitmask DP is practical for small width | Advanced matching/bitmask integration |
| 15 | Optimize Water Distribution in a Village | Virtual source node turns well-building choices into MST edges | Core MST reduction |
| 16 | Critical and Pseudo-Critical MST Edges | Forced/excluded Kruskal tests, including equal-weight alternatives | Cross-link MST |
| 17 | Multigraph bridge — parent node vs edge ID | Parallel edges require skipping parent edge ID, not parent vertex | Diagnostic trap |
| 18 | Euler path — skipping connectivity check | Degree conditions are insufficient if edge-bearing graph is disconnected | Diagnostic trap |
| 19 | Tarjan SCC output is reverse topological | Condensation order orientation must be interpreted correctly | Diagnostic trap |
| 20 | Tarjan SCC: visited vs on_stack | Only back edges to active stack nodes update low-link | Diagnostic trap |

### Recommended changes

- Divide the advanced graph track into bridges/articulation, SCC/condensation, functional graphs, Eulerian paths, MST reductions, and matching/flow.
- #1 → #2 → #4 is a strong low-link progression; use edge IDs for all multigraph implementations.
- #8 → #9 is a strong functional-graph progression: detect cycle, then compute reach counts for tails.
- #10 → #11 → #12 is a strong Eulerian progression: use every edge once → degree-based trail → de Bruijn reduction.
- #13, #15, and #16 are MST and belong canonically with DSU/MST; #14 is matching/bitmask DP.
- #5 is tree pruning and should be owned by Trees; #6 by SCC/Topological Sort; #7 is explicitly not an SCC problem.
- #3 needs a clear proof that only uniquely owned clean components contribute to removal benefit.
- #19 and #20 should be a single Tarjan implementation diagnostic with separate ordering and on-stack tests.
- #4 needs a complete source and statement; #17–20 should be short targeted diagnostics.
- Consider whether Network Flow deserves a standalone topic. Current coverage touches matching/Konig but does not yet establish max-flow/min-cut, residual graphs, Dinic, or min-cost flow.
- Final capstone should be a realistic graph problem where the learner must identify whether the right tool is low-link, SCC, functional-graph analysis, Euler trail, MST, matching, or flow.

---

## Status

Topics 01–29 have now received progressive concept-delta reviews. Topics 30–43 remain. No production curriculum rows have been modified.
