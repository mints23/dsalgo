# AlgoFrog Mastery Curriculum Expansion Plan

Status: proposed additions pending concept-level validation and production rollout.

## Standard
A required question must teach a distinct reusable concept, invariant, proof, optimisation, failure boundary, or important application. Repeated problem identities are allowed only when the required placement explicitly teaches a different algorithmic solution. Topic coverage is not certified by titles or problem counts alone.

Every new required placement must have a precise concept/sub-variant, curriculum path and path order, curriculum role, non-empty transferable key insight, verified problem identity and difficulty, and reviewed solution/Java walkthrough.

## New standalone topics recommended
These are missing as independent learning units in the current 43-topic taxonomy. Add as topics 44 onward after validating questions and app navigation metadata.

### 44. Bit Manipulation & Bitmask Techniques
Concepts: bitwise algebra; set/clear/toggle/test; shifts and signed integer pitfalls; XOR cancellation; prefix XOR; Brian Kernighan; subset/submask enumeration; Gray code; bitset acceleration; bitmask state compression; SOS DP; subset convolution.
Questions: LC 136 Single Number; LC 137 Single Number II; LC 260 Single Number III; LC 191 Number of 1 Bits; LC 338 Counting Bits; LC 201 Bitwise AND of Numbers Range; LC 231 Power of Two; LC 342 Power of Four; LC 421 Maximum XOR of Two Numbers; LC 898 Bitwise ORs of Subarrays; LC 1318 Minimum Flips to Make a OR b Equal to c; LC 1863 Sum of All Subset XOR Totals; LC 1879 Minimum XOR Sum of Two Arrays; LC 1125 Smallest Sufficient Team; LC 847 Shortest Path Visiting All Nodes; LC 1681 Minimum Incompatibility; custom SOS DP, Gray-code iteration and bitset optimisation.

### 45. Number Theory & Modular Arithmetic
Concepts: gcd/lcm; Euclid and extended Euclid; linear Diophantine equations; modular inverses/division; fast exponentiation; primality; Miller–Rabin; Pollard Rho; factorisation; Euler phi; Möbius; divisor functions; CRT; Fermat/Euler theorems; linear congruences.
Questions: LC 1979 Find Greatest Common Divisor of Array; LC 1250 Check If It Is a Good Array; LC 2447 Number of Subarrays With GCD Equal to K; LC 2470 Number of Subarrays With LCM Equal to K; LC 858 Mirror Reflection; LC 1015 Smallest Integer Divisible by K; LC 1492 The kth Factor of n; LC 2521 Distinct Prime Factors of Product of Array; LC 2427 Number of Common Factors; custom extended Euclid/modular inverse, CRT, Miller–Rabin, Pollard Rho, Möbius inversion and Diophantine equations.

### 46. Advanced String Algorithms
Concepts: Z-function; Rabin–Karp/rolling hash and collision handling; double hashing; Manacher; suffix array and LCP; suffix automaton; suffix-tree concepts; Lyndon factorisation; Aho–Corasick; palindromic tree (Eertree); online matching.
Questions: LC 1044 Longest Duplicate Substring; LC 1062 Longest Repeating Substring; LC 2223 Sum of Scores of Built Strings; LC 3031 Minimum Time to Revert Word to Initial State II; LC 5 Longest Palindromic Substring (Manacher variant); LC 647 Palindromic Substrings (Manacher variant); LC 1698 Number of Distinct Substrings in a String; LC 1923 Longest Common Subpath; custom suffix array + Kasai LCP, suffix automaton, Aho–Corasick failure links, Manacher and Eertree.

### 47. Advanced Tree Techniques
Concepts: Euler-tour flattening; subtree range queries; binary lifting; HLD; centroid decomposition; DSU on tree/sack; virtual trees; link-cut trees; dynamic forests; path queries and updates.
Questions: LC 1483 Kth Ancestor of a Tree Node; LC 2846 Minimum Edge Weight Equilibrium Queries in a Tree; custom Euler-tour + BIT subtree queries; HLD path aggregates and updates; centroid decomposition counting paths at distance K; DSU-on-tree colour frequencies; virtual-tree marked-node queries; link-cut tree dynamic path aggregates; Euler-tour/RMQ LCA; tree differences; Tarjan offline LCA.

### 48. Offline Queries & Sqrt Decomposition
Concepts: offline vs online; sqrt decomposition; Mo's algorithm; Mo with modifications; Mo on trees; rollback DSU; CDQ offline queries; parallel binary search; coordinate compression; event ordering.
Questions: LC 1697 Checking Existence of Edge Length Limited Paths; LC 2076 Process Restricted Friend Requests; LC 1847 Closest Room; LC 1851 Minimum Interval to Include Each Query (cross-reference); LC 2736 Maximum Sum Queries; custom Mo range-distinct, Mo with updates, Mo on trees, rollback DSU dynamic connectivity, CDQ 3D dominance, parallel binary search and sqrt blocks with lazy tags.

### 49. Meet-in-the-Middle & Subset Optimisation
Concepts: split-and-enumerate; subset-sum halves; pair-sum counting; SOS DP; subset convolution; bitmask DP optimisation; branch-and-bound; memory/time trade-offs.
Questions: LC 805 Split Array With Same Average; LC 1755 Closest Subsequence Sum; LC 2035 Partition Array Into Two Arrays to Minimize Sum Difference; LC 956 Tallest Billboard (cross-reference); LC 1125 Smallest Sufficient Team (cross-reference); LC 1986 Minimum Number of Work Sessions to Finish the Tasks; LC 1681 Minimum Incompatibility; custom subset count in [L,R], SOS DP, subset convolution and Held–Karp Hamiltonian path DP.

### 50. Network Flow & Matching
Concepts: residual networks; augmenting paths; max-flow/min-cut theorem; Dinic; capacity scaling; bipartite matching; Hopcroft–Karp; min-cost max-flow; potentials; Hungarian assignment; vertex/edge-disjoint paths; circulation with demands.
Questions: LC 1820 Maximum Number of Accepted Invitations; LC 1349 Maximum Students Taking Exam (compare matching and bitmask); LC 1595 Minimum Cost to Connect Two Groups of Points (compare assignment DP and flow); custom augmenting-path matching, Hopcroft–Karp, Dinic, min-cut extraction, node splitting, edge-disjoint paths, min-cost max-flow with potentials and Hungarian algorithm.

### 51. Computational Geometry
Concepts: orientation/cross product; point/line projection; segment intersection; sweep line; convex hull; rotating calipers; closest pair; half-plane intersection; polygon area; point-in-polygon; precision and degeneracies.
Questions: LC 587 Erect the Fence; LC 149 Max Points on a Line (cross-reference); LC 223 Rectangle Area; LC 836 Rectangle Overlap; LC 1401 Circle and Rectangle Overlapping; custom segment intersection including collinear overlap, monotone-chain convex hull, rotating calipers diameter, closest pair O(n log n), orthogonal segment sweep, shoelace/polygon containment and overflow-safe orientation.

## Existing-topic additions and fixes to validate
- Two Pointers: partition invariants, three-way partition proof, cyclic placement distinction, cycle length and entry derivations.
- HashMap: collisions, rehashing, load factor, expected vs worst-case, direct-address and ordered-map distinctions.
- Binary Search: first-true/last-true, monotone predicate proof, binary lifting, parametric search and overflow-safe midpoint.
- Sliding Window: monotonicity proof, negative-number boundary, deque amortised analysis and streaming constraints.
- Kadane: length-constrained max/min subarray, prefix-min/deque derivations; distinguish Kadane from non-adjacent selection DP.
- Intervals: endpoint semantics, half-open intervals, event tie ordering, weighted scheduling proof, containment and 2D union.
- Prefix Sums: XOR/group algebra, 2D difference arrays, negative-value hashing, prefix minima/deques.
- Backtracking: exact cover/DLX, branch-and-bound bounds, symmetry breaking, memoised search and ordering heuristics.
- Greedy: exchange/stays-ahead/cut proofs, matroid independence and counterexample construction.
- Sieve: linear/segmented sieve edge cases, Möbius and multiplicative functions; advanced primality belongs in topic 45.
- BIT: two-BIT derivation, 2D BIT, order-statistic binary lifting and offline compression.
- Segment Tree: iterative tree, lazy composition algebra, persistence, implicit tree, beats preconditions and merge-sort tree.
- KMP: Z-function cross-reference, automaton construction, streaming matching and failure-link proof.
- LIS: patience-sorting proof, reconstruction, duplicate counting, multidimensional sorting and constrained LIS.
- Heap: decrease-key/lazy deletion, indexed and d-ary heaps, external/k-way merge and complexity.
- Monotonic Stack/Queue: duplicate tie-breaking, amortised proof, Cartesian trees and online/offline distinction.
- Trees: Euler tours, binary lifting, LCA/RMQ, tree differences and path/subtree modelling; decomposition in topic 47.
- Trie: deletion/compression, radix trie, persistent trie and Aho–Corasick; coordinate with topic 46.
- Graph Fundamentals: edge classification, graph modelling, multigraph/self-loop handling and representation trade-offs.
- BFS/DFS: iterative stack safety, path reconstruction, edge classification, 0-1 BFS boundary and implicit-graph complexity.
- Multi-source BFS: weighted propagation contrast, Voronoi interpretation, competing fronts and multidimensional state.
- Bipartite: augmenting paths, matching proof, alternating paths and Konig theorem; full flow in topic 50.
- Topological Sort: uniqueness, cycle witness, DAG shortest/longest paths and topological DP.
- Dijkstra: non-negative-weight proof, stale entries, zero weights, overflow and multi-criteria state expansion.
- Floyd-Warshall: intermediate-vertex invariant, negative-cycle reachability propagation and reconstruction.
- Bellman-Ford: reachable negative-cycle detection, path reconstruction, edge-order independence and SPFA worst case.
- DSU: potential/weighted DSU, rollback DSU cross-reference, offline dynamic connectivity and DSU-on-tree distinction.
- Advanced Graph Algorithms: actual required implementations for SCC (Tarjan/Kosaraju), bridges/articulation and Euler path; move flow to topic 50 and remove unrelated placements.
- 1D DP: clarify ownership with specialised DP; state design, recurrence proof, rolling memory and optimisation boundaries.
- Grid DP: obstacle/state dimensions, diagonal transitions, multi-agent compression and path reconstruction.
- Knapsack: bounded/multiple knapsack, binary grouping, monotone-queue optimisation, bitset subset sum and reconstruction.
- Strings & Subsequences: LCS/edit-distance variants, subsequence automata and cross-references to topic 46.
- State Machine DP: explicit transition diagrams, transaction bounds, cooldown, parity and finite automata; reclassify unrelated problems.
- Interval DP: require a genuine interval recurrence and valid split dependency order.
- Partition DP: monotone optimisation, D&C DP, Knuth conditions and Aliens trick only where preconditions hold.
- Game Theory: Sprague–Grundy proof, disjunctive sums, misere caveats, impartial/partisan distinctions and retrograde analysis.
- Tree DP: rerooting derivations, tree knapsack, small-to-large, virtual tree and state compression invariants.
- Digit DP: signed/range boundaries, leading zeros, multiple tight bounds, digit automata and matrix acceleration.
- DAGs & Probability: separate DAG DP from stochastic DP; topological expectation, absorbing Markov chains and probability conservation.
- Combinatorial DP: inclusion-exclusion, Stirling numbers, derangements, Lucas/CRT and identity proofs.
- Data-Structure-Optimised DP: preconditions for deque, CHT/Li Chao, D&C DP, Knuth, SMAWK, CDQ and Aliens trick, including counterexamples.
- Profile DP: frontier-state definition, transition generation, symmetry/colour state, plug-DP connectivity labels and transfer-matrix exponentiation; keep ordinary subset DP out.

## Classification corrections to review
- LC 2065 is constrained DFS/search with a time budget, not Topological Sort.
- LC 2127 is functional-graph/cycle decomposition, not bipartite graph theory.
- LC 920 is combinatorial DP, not Interval DP.
- LC 473 and LC 3276 are subset/bitmask DP, not Broken Profile DP.
- LC 1557 is an in-degree/source-vertex observation, not an advanced graph algorithm.
- LC 329 is DAG DP on an implicit graph; cross-topic use must have a distinct learning objective.

## Rollout safeguards
1. Do not renumber or delete existing problem identities.
2. Do not alter user progress keys or problem_num identity.
3. New topics require unique IDs and complete navigation metadata.
4. Every required placement must have complete curriculum metadata and a non-empty key insight.
5. Validate topic counts, path-order uniqueness, role completeness, duplicate LC identities and cross-topic ownership.
6. Deploy database and application changes together where required.
7. Do not label a topic mastery-ready until solution content, Java implementations and transfer tests are reviewed.