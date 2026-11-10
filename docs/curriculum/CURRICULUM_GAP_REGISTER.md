# Curriculum Gap Register — Proposed Topic Decisions

**Decision rule:** A new topic is created only when it has a distinct learning objective, prerequisite chain, and enough non-overlapping Medium/Hard/custom problems to justify a standalone learning path. A label alone is not evidence of a gap.

## Recommended candidates

| Candidate | Current overlap | Recommendation |
|---|---|---|
| Linked Lists — Advanced Patterns | Two Pointers has fast/slow, cycle, intersection, reversal-related entries; Trees and Graphs use pointer-like traversal but not list-specific invariants | **Create dedicated topic.** Cover in-place rewiring, reversal families, merge/sort, multi-list operations, random pointers, destructive vs persistent transformations, and pointer invariants. Keep Two Pointers as cross-reference, not duplicate catalogue. |
| Stack, Queue & Deque | Monotonic Stack/Queue covers monotonic structures; Top K covers heaps | **Create focused topic.** Cover non-monotonic stack/queue design, expression parsing, deque invariants, amortized analysis, min/max stack, queue-from-stacks, and parser state. Link monotonic patterns to existing topic. |
| Sorting & Selection | Sorting appears as a prerequisite in Intervals, Greedy, Two Pointers and LIS; QuickSelect appears in Top K | **Create topic.** Cover selection, partitioning, inversion counting, custom comparator proofs, non-comparison sorts, stable sorting and sorting-based reductions. Avoid repeating basic sort implementations. |
| Bit Manipulation & Bitmask Techniques | Backtracking, Knapsack, Profile DP and Game Theory use bitmasks; no dedicated standalone topic | **Create topic.** Cover bitwise algebra, XOR, subset/submask enumeration, SOS DP, bitsets, state compression, and optimization of bitmask transitions. Coordinate with Profile DP to prevent duplicate teaching. |
| Advanced String Algorithms | KMP and Trie/Aho-Corasick exist; Strings & Subsequences is DP-oriented | **Create topic.** Cover Z-function, rolling hash, Rabin–Karp, Manacher, suffix array/LCP, suffix automaton, and multi-pattern matching. Keep KMP as an existing focused topic and cross-link. |
| Mathematics & Number Theory | Sieve exists; Combinatorial & Modulo DP includes some math; no coherent math prerequisite path | **Create topic.** Cover gcd/extended Euclid, modular arithmetic, modular inverse, fast exponentiation, factorization, divisor functions, CRT, combinatorics, inclusion-exclusion, and Diophantine equations. Do not duplicate DP counting. |

## Candidates to keep as subtopics pending deeper audit

- **Matrix / multidimensional algorithms:** first inspect 2D Grid DP, Prefix Sums, Graph BFS, and advanced range-query material. A separate topic may be warranted for matrix exponentiation, matrix traversal and geometric transforms, but not merely for 2D arrays.
- **Divide & Conquer:** inspect Merge Sort, D&C DP optimization, CDQ, divide-and-conquer on answer, and tree decomposition coverage. Consider a topic if the algorithmic paradigm itself needs a coherent explanation.
- **Offline Algorithms:** inspect Mo's algorithm, parallel binary search, offline sweeps, DSU rollback, CDQ and query reordering. Likely deserves a standalone advanced topic if current guide lacks a coherent offline-query decision framework.
- **Computational Geometry:** inspect Advanced Graphs, Greedy and custom problem sets. Evaluate convex hull, line sweep, orientation, closest pair, and geometric sweeps as a possible separate advanced topic.

## Existing catalogue coverage to preserve

- Monotonic Stack/Queue, Top K Elements, Trees, Trie, Fenwick Tree, Segment Tree, KMP, LIS O(n log n), and the existing advanced DP topics are already separate topics. Do not create duplicates under new names.
- Prefix Sums already includes difference arrays, 2D prefix, BIT and segment-tree references. Clarify ownership and cross-links rather than copy the same problems into multiple required lists.
- Backtracking already includes bitmask-pruned permutations and exact-cover recognition; the proposed Bit Manipulation topic should teach bit-level operations and state compression as a general technique, with Backtracking linking to it.

## Required curriculum treatment

- Every Easy problem is excluded from the required path, including Easy traps. Existing rows are retained as optional reference only.
- Medium entries are included only if they test a distinct non-trivial technique or are a necessary bridge to an advanced problem.
- Hard and custom competitive-programming entries are reviewed for validity, clarity, and source. A Hard label alone does not guarantee quality.
- Custom entries need an identifiable source (Codeforces/AtCoder/CSES/USACO/etc.) or a fully specified original problem statement.
- Cross-topic appearances need an explicit role and a reason to solve the problem again.

## Decision status

These are recommendations based on live topic titles, variant labels, and problem inventory. They are not yet final additions. The full topic-body and question-by-question audit must confirm the gaps before any new topics are seeded into Supabase.
