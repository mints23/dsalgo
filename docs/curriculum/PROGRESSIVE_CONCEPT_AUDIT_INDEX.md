# AlgoFrog Progressive Concept Audit — Index

**Status:** First-pass review complete for all 43 curriculum topics.  
**Purpose:** Every required question must add a distinct transferable reasoning concept, build on prior concepts where appropriate, and contribute to a cumulative mastery challenge.

## Audit documents

1. [Topics 01–03: Two Pointers, HashMap, Binary Search](PROGRESSIVE_CONCEPT_AUDIT.md)
2. [Topics 04–05: Sliding Window, Kadane](PROGRESSIVE_CONCEPT_AUDIT_04_05.md)
3. [Topics 06–07: Intervals, Prefix Sums](PROGRESSIVE_CONCEPT_AUDIT_06_07.md)
4. [Topics 08–09: Backtracking, Greedy](PROGRESSIVE_CONCEPT_AUDIT_08_09.md)
5. [Topics 10–12: Sieve, Fenwick Tree, Segment Tree](PROGRESSIVE_CONCEPT_AUDIT_10_12.md)
6. [Topics 13–14: KMP, LIS](PROGRESSIVE_CONCEPT_AUDIT_13_14.md)
7. [Topics 15–16: Heap, Monotonic Stack/Queue](PROGRESSIVE_CONCEPT_AUDIT_15_16.md)
8. [Topics 17–18: Trees, Trie](PROGRESSIVE_CONCEPT_AUDIT_17_18.md)
9. [Topics 19–24: Graph Fundamentals, BFS, DFS, Multi-source BFS, Bipartite, Topological Sort](PROGRESSIVE_CONCEPT_AUDIT_19_24.md)
10. [Topics 25–29: Dijkstra, Floyd-Warshall, Bellman-Ford, DSU, Advanced Graphs](PROGRESSIVE_CONCEPT_AUDIT_25_29.md)
11. [Topics 30–33: 1D DP, Grid DP, Knapsack, Strings & Subsequences](PROGRESSIVE_CONCEPT_AUDIT_30_33.md)
12. [Topics 34–36: State Machine DP, Interval DP, Partition DP](PROGRESSIVE_CONCEPT_AUDIT_34_36.md)
13. [Topics 37–39: Game Theory, Tree DP, Digit DP](PROGRESSIVE_CONCEPT_AUDIT_37_39.md)
14. [Topics 40–43: DAGs & Probability, Combinatorial DP, Data-Structure-Optimized DP, Profile DP](PROGRESSIVE_CONCEPT_AUDIT_40_43.md)

## Review model

Every question is assessed as one of:
- **Core progression:** adds a new reusable concept or invariant.
- **Reinforcement:** reuses a prior concept under a changed constraint or output objective.
- **Integration:** combines previously learned techniques.
- **Diagnostic trap:** teaches when a tempting technique is incorrect or unnecessarily complex.
- **Reference:** useful for fluency, but not part of the advanced required path.
- **Move / split:** valuable content whose canonical home is another topic or sub-path.
- **Review:** source, statement, algorithm label, or correctness needs verification.

## Verified correction queue

[Source-verified algorithm classification corrections](VERIFIED_CLASSIFICATION_CORRECTIONS.md) records six high-confidence mismatches across Floyd-Warshall, Game Theory, Digit DP, and Profile DP. These need production content correction while preserving original problem IDs and learner progress.

## Major findings

- A topic can contain several parallel concept paths. Use a prerequisite graph rather than forcing unrelated patterns into one linear order.
- A unique problem ID is not the same as a unique learning objective. A problem repeated across topics should have one canonical solution and a clearly stated alternate learning lens.
- Diagnostic traps should be retained, but should not inflate the count of new core concepts.
- The 145 advanced-DP rows in Topics 38–43 lack structured key_insight values. Their existing sub_variant descriptions often contain useful detail, so each insight needs a careful concept-delta rewrite rather than blind copying.
- Several problem rows need source/algorithm verification before they can be accepted as canonical, including custom/competitive-programming entries and potentially misclassified techniques. The audit documents call out the exact topic and order.
- No production problem rows, user progress, playback, authentication, subscriptions, or payment data were modified during this first pass.

## Recommended next phase

1. Resolve the high-risk source and algorithm-classification flags.
2. Approve a canonical owner and concept path for every cross-topic repeat.
3. Design the final unseen mastery challenge for each topic.
4. Populate structured concept metadata only after review.
5. Update UI to show concept paths, prerequisites, and each question's new learning contribution.
6. Revisit required/optional flags after the new learning paths are approved.
