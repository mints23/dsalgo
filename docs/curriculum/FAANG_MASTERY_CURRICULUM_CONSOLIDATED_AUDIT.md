# AlgoFrog FAANG Mastery Curriculum — Consolidated Audit & Architecture

**Audit date:** 2026-11-10  
**Scope:** Existing 43 topics, 919 required placements  
**Audit reports:** Batch 1 (Topics 1–10), Batch 2 (11–20), Batch 3 (21–30), Batch 4 (31–43).  
**Status:** Concept inventory and classification audit completed at first pass; solution and Java verification remains incomplete.

## Executive decision

The existing curriculum is extensive and contains many advanced concepts. It is not yet defensible to market it as a fully verified mastery curriculum. Its current weakness is not simply a shortage of questions. The key blockers are:

1. Inconsistent concept ownership and cross-topic duplication.
2. Some topic boundaries mix fundamentally different algorithm families.
3. A number of advanced concepts are advertised in topic metadata but lack a clearly identified required implementation.
4. The actual explanation and Java implementation quality has not been established for most required problems.
5. Topics 38–43 have 113 required rows with empty key_insight fields, despite long prose being present in sub_variant. The structured UI insight field is therefore incomplete.

The right strategy is to **repair the curriculum architecture first, then fill proven concept gaps, then build and verify the teaching artifacts**. Do not indiscriminately append problem rows.

## Verified production baseline

A fresh production query on 2026-11-10 confirms:

| Metric | Verified value |
|---|---:|
| Existing topics | 43 |
| Required problem placements | 919 |
| Required placements with problem_playback.solution | 11 |
| Required placements without problem_playback.solution | 908 |
| Required placements with empty key_insight | 113 |
| Empty key_insight rows in topics 38–43 | 113 |
| Temporary Topic 44 remaining | 0 |

The 11 playback records are in a Python-style explanation/visualisation schema; inspected snippets are not verified Java solutions. GitHub code searches for Java Solution sources returned no results. That search result does not prove no Java code exists elsewhere; a repository tree/file inventory or other source must still be inspected.

## Four audit batches

- [Batch 1 — Topics 1–10](MASTERY_AUDIT_BATCH_01_TOPICS_01_10.md)
- [Batch 2 — Topics 11–20](MASTERY_AUDIT_BATCH_02_TOPICS_11_20.md)
- [Batch 3 — Topics 21–30](MASTERY_AUDIT_BATCH_03_TOPICS_21_30.md)
- [Batch 4 — Topics 31–43](MASTERY_AUDIT_BATCH_04_TOPICS_31_43.md)

The per-topic reports contain concept inventories, required-problem mappings, gaps, classification risks and recommendations. These are first-pass concept audits, not final solution/code sign-offs.

## New concept families — final inclusion decision

These are required concept families in the target curriculum. Whether each becomes a standalone visible topic or a dedicated path is an information-architecture decision. A standalone topic must have enough distinct concepts and problem-solving outcomes to justify the navigation; otherwise it belongs in an existing topic.

| Concept family | Current coverage found | Decision |
|---|---|---|
| Bit manipulation & bitmask techniques | Prefix XOR, digit masks, subset DP, XOR tries are scattered across Prefix Sums, DP, Trie and Profile DP. Core bit algebra, subset/submask enumeration, Gray code, SOS DP and bitset acceleration are not owned coherently. | **Add a dedicated concept path.** Reuse existing placements where appropriate; add questions only for distinct uncovered outcomes. |
| Number theory & modular arithmetic | Sieve/SPF, totient, stars-and-bars, Lucas and modular inverses appear in isolated places. Extended Euclid, modular inverse derivation, CRT, linear congruences, Miller–Rabin, Pollard Rho and multiplicative-function toolkit lack coherent ownership. | **Add a dedicated concept path.** Sieve remains the prime-precomputation foundation. |
| Advanced string algorithms | KMP and Z are in Topic 13; Aho–Corasick and XOR trie are in Trie; Manacher, suffix array/LCP, suffix automaton and rolling-hash collision analysis lack coherent ownership. | **Add a dedicated concept path.** Avoid duplicating KMP/Aho–Corasick questions; focus on suffix/palindrome/multi-pattern families not yet taught. |
| Advanced tree techniques | Topic 17 already contains Euler tour, binary lifting, HLD, centroid decomposition, DSU-on-tree, virtual tree, offline LCA and link/path queries. Topic 38 contains tree DP. | **Do not add a separate topic yet.** Repair the boundary between Tree Algorithms (17) and Tree DP (38); no duplicate topic or question volume. |
| Offline queries & sqrt decomposition | BIT/DSU topics contain offline sorting, reverse-time connectivity and CDQ examples. Mo's algorithm, Mo with modifications/tree, rollback DSU and parallel binary search do not have clear primary ownership. | **Add a dedicated concept path** if the full audit confirms enough independent techniques; include rollback DSU and Mo's. |
| Meet-in-the-middle & subset optimisation | LC 2035 appears in Knapsack; subset masks appear in Backtracking, Knapsack, State Machine DP and Profile DP. SOS DP/subset convolution are not clearly taught. | **Add a dedicated concept path or a major Bitmask subpath.** Do not duplicate ordinary subset DP; focus on split enumeration, cardinality buckets and transforms. |
| Network flow & matching | Bipartite matching and Hopcroft–Karp appear in Topic 23; matching-related tasks also appear in Advanced Graph Algorithms. Dinic, max-flow/min-cut, capacity scaling, min-cost flow, potentials and circulation are absent from clear primary ownership. | **Add a dedicated graph topic/path.** Matching is not sufficient evidence of general flow mastery. |
| Computational geometry | Some geometric formulations are scattered (e.g. line/slope grouping, interval/sweep tasks), but orientation, intersection, convex hull, rotating calipers, closest pair and precision/degeneracy handling lack ownership. | **Add a dedicated concept path** with a practical interview-oriented core and advanced optional tier. |

### Additional family: Minimum Spanning Trees

MST appears in Graph Fundamentals and DSU, with Kruskal/Prim and critical/pseudo-critical edge analysis. It currently lacks a clean primary topic and progression. Establish a dedicated MST path under Graph Algorithms, covering cut/cycle properties, Kruskal, Prim, DSU, dense-vs-sparse trade-offs, sensitivity/critical edges and virtual-source modelling. This can initially reuse current placements; add only if a distinct MST concept is absent.

## High-priority reclassification backlog

The following changes should be prioritised because they affect the accuracy of what the learner believes they are practising:

| Existing placement | Problem | Recommended primary owner |
|---|---|---|
| Bipartite Graph | LC 2127 is functional graph/cycle decomposition | Advanced Graph Algorithms / Functional Graphs |
| Topological Sort | LC 2065 is time-constrained DFS/backtracking | Backtracking / Graph Search |
| Dijkstra | LC 2045 is modified BFS with two distances and traffic-light parity | BFS / State-expanded shortest path |
| Bellman–Ford | LC 743 has positive weights; LC 1928 is time-indexed constrained DP | Dijkstra for 743; constrained DP for 1928 |
| Floyd–Warshall | LC 1591 is topological feasibility | Topological Sort |
| Advanced Graph Algorithms | LC 1557 is an in-degree/source-vertex observation | Graph Fundamentals |
| Advanced Graph Algorithms | LC 1349 is bipartite matching / bitmask DP | Matching / Network Flow |
| Advanced Graph Algorithms | LC 1168 is MST with virtual source | MST |
| Advanced Graph Algorithms | LC 2603 is tree pruning | Trees / Tree DP |
| Interval DP | LC 920 is combinatorial counting DP | Combinatorial DP |
| Profile DP | LC 473 and LC 3276 are subset/bitmask DP, not frontier-profile DP | Bitmask / Subset DP |
| Partition DP | LC 2055 is prefix/range query, not DP | Prefix Sums / Range Queries |
| Strings & Subsequences | LC 2312 is interval DP on 2D dimensions | Interval DP |
| Strings & Subsequences | LC 1032 is Aho–Corasick / reverse Trie | Trie / Advanced String Matching |
| 1D Linear DP | LIS, state machine, knapsack, LCS, CHT and interval recurrences are mixed in | Specialist DP topics |
| Trees vs Tree DP | Pure LCA/HLD/centroid/virtual-tree algorithms mixed with DP recurrences | Trees (17) vs Tree DP (38) |

Cross-topic duplicate placements are not automatically wrong. They must be retained only where each placement teaches a distinct algorithm or implementation. Otherwise use a cross-reference and one primary owner. Important duplicate groups include LC 307, 347, 480, 239, 1438, 253, 1851, 327, 300, 472, 547, 1319, 1584, 827, 210, 802 and 1569.

## Curriculum architecture target

Keep the 43 existing topic identities stable during the audit. The target architecture should organise concepts into the following families (the visible topic count may change after a deliberate navigation redesign):

### Foundations and linear techniques
- Two pointers and partitioning
- Hashing and associative structures
- Binary search and parametric search
- Sliding windows and monotonic deques
- Prefix sums, difference arrays and range queries
- Greedy algorithms and proof techniques
- Intervals and sweep lines
- Bit manipulation and subset representation
- Number theory and modular arithmetic

### Data structures
- Fenwick trees
- Segment trees (lazy, persistent, implicit, beats)
- Heaps and priority queues
- Monotonic stacks/queues
- Tries and XOR tries
- Offline queries, Mo's algorithm and rollback structures

### Graphs and trees
- Graph modelling and traversal
- BFS, multi-source BFS and 0-1 BFS
- DFS and directed-cycle analysis
- Bipartite graphs and matching
- Topological ordering and DAG algorithms
- Dijkstra, Bellman–Ford and APSP
- DSU and offline connectivity
- MST
- SCC, bridges, articulation and Eulerian algorithms
- Network flow and min-cost matching
- Functional graphs
- Tree algorithms: LCA, Euler tour, HLD, centroid, virtual tree
- Tree DP

### Dynamic programming
- Linear and state-machine DP
- Grid and multi-agent DP
- Knapsack and subset DP
- Strings and subsequences DP
- Interval DP
- Partition DP and optimisation
- Game theory and minimax
- Digit DP
- DAG/probability/Markov DP
- Combinatorial DP
- Data-structure-optimised DP
- Profile/plug DP
- Meet-in-the-middle and subset transforms

### String and geometry algorithms
- KMP and Z
- Rolling hash
- Manacher and palindromic trees
- Suffix array/LCP
- Suffix automaton
- Aho–Corasick
- Computational geometry

## Mastery evidence standard

Every required problem must eventually have a complete teaching artifact:

1. Problem restatement and constraint analysis.
2. Naive baseline and reason it fails at scale.
3. Recognition signal and exact concept being taught.
4. Derivation of the algorithm from first principles.
5. Correctness proof (invariant, induction, exchange, cut, recurrence or other relevant proof).
6. Complete Java implementation, with types and data structures justified.
7. Complexity derivation from the implementation.
8. Dry run plus edge/adversarial cases.
9. Alternative solutions and trade-offs.
10. Common wrong approaches and counterexamples.
11. At least one transfer prompt or unseen variant.

A playback animation or pseudocode trace is supplemental; it is not a substitute for a compilable Java solution.

## Mastery assessment design

A topic is not Strong solely because its required set is complete. Each topic needs a small, carefully designed assessment set:

- A recognition test with unfamiliar wording.
- A derivation/proof prompt.
- A Java implementation under a time budget.
- An adversarial edge-case test.
- A transfer problem combining this topic with another.
- An explanation of when not to use the technique.

Assessment problems should be hidden or held back from the learning path where possible, so they measure transfer rather than memorisation.

## Execution plan

### Phase A — Architecture and evidence
1. Complete all four concept audits (done at first-pass level).
2. Reconcile primary ownership and path taxonomy.
3. Locate the repository's Java solution source of truth. The current GitHub code search did not surface Java files; inspect repository file inventory and build conventions before concluding code is absent.
4. Audit all 11 existing playback solutions for correctness, and check their relationship to the problem rows.

### Phase B — Solution quality
5. Establish a Java solution format and tests.
6. Review the 919 required placements in topic batches.
7. Fix incorrect explanations, complexity claims and Java implementations.
8. Populate the 113 empty key_insight fields in Topics 38–43 only after verifying their long sub_variant explanations; avoid blind copying.

### Phase C — Curriculum repair and gap filling
9. Apply the high-priority reclassifications while preserving stable problem IDs and learner progress.
10. Add concept paths for the families listed above where existing content is insufficient.
11. Add new questions only when the concept inventory and solution audit demonstrate a real learning gap. Prefer one-for-one replacement when an existing problem is redundant.
12. Validate all required paths, order uniqueness, role semantics, counts and cross-topic ownership.

### Phase D — Assessment and release
13. Add unseen-style mastery assessments.
14. Run data and UI tests, including navigation, progress persistence and free/premium gates.
15. Deploy through the normal GitHub Actions path and verify production.

## Final programme verdict

**Not yet mastery-certified.** The existing curriculum has substantial and in places genuinely advanced breadth. The strongest visible areas include Digit DP, Tree DP, Profile DP, Segment Tree, Trie and Data-Structure-Optimised DP. However, important classification errors, missing coherent concept families and the lack of verified Java solution artifacts prevent an authoritative FAANG mastery claim.

The next highest-value engineering task is not to append another hundred questions. It is to locate/establish the Java solution source of truth, inspect the actual teaching artifacts, and correct the concept ownership map. Then add the missing families and assessments with evidence.

**Target outcome:** a learner who can independently recognise, derive, prove, optimise and implement solutions to unfamiliar FAANG interview problems in Java—not merely complete a long list.
