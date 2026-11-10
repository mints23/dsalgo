# Phase 3 Curriculum Audit — Dynamic Programming

**Scope:** Live production topics 30–43. Inventory and metadata review; detailed recurrence/proof review is the next pass.

## Inventory

| ID | Topic | Rows | Easy excluded | Medium | Hard | Missing key insight | Missing LC URL |
|---:|---|---:|---:|---:|---:|---:|---:|
| 30 | 1D Linear DP | 52 | 0 | 33 | 19 | 0 | 1 |
| 31 | 2D Grid DP | 31 | 0 | 14 | 17 | 0 | 2 |
| 32 | Knapsack Family | 32 | 0 | 19 | 13 | 0 | 2 |
| 33 | Strings & Subsequences | 32 | 1 | 12 | 19 | 0 | 2 |
| 34 | State Machine DP | 29 | 1 | 16 | 12 | 0 | 3 |
| 35 | Interval DP | 28 | 0 | 13 | 15 | 0 | 3 |
| 36 | Partition DP | 26 | 0 | 9 | 17 | 0 | 2 |
| 37 | Game Theory & Minimax | 28 | 0 | 17 | 11 | 0 | 4 |
| 38 | Tree DP | 35 | 0 | 17 | 18 | 35 | 4 |
| 39 | Digit DP | 26 | 0 | 7 | 19 | 26 | 5 |
| 40 | DAGs & Probability DP | 16 | 0 | 12 | 4 | 16 | 4 |
| 41 | Combinatorial & Modulo DP | 16 | 0 | 9 | 7 | 16 | 4 |
| 42 | Data Structure Optimized DP | 27 | 0 | 7 | 20 | 27 | 10 |
| 43 | Profile / Broken Profile DP | 25 | 0 | 8 | 17 | 25 | 11 |

All counts are live problem rows. Missing key insight in topics 38–43 is a structured-field gap: many rows have detailed explanatory `sub_variant` text. It must not be treated as proof that the teaching content is absent. The content should be reviewed and the explanation mapped to the correct field without losing detail.

## Structural observations

- Topics 40 (DAGs & Probability DP) and 41 (Combinatorial & Modulo DP) have `show_in_sidebar = false`, but each has 16 problem rows and substantial topic content. These are not empty or speculative topics; they are currently hidden from the normal sidebar. Decide whether to publish them after reviewing prerequisites and sequence.
- Topics 42 and 43 are advanced and dense: 20/27 and 17/25 rows respectively are Hard. Preserve them as advanced material; do not simplify them to increase beginner accessibility.
- Tree DP includes rerooting, tree knapsack, distance-state DP, small-to-large and virtual-tree concepts. It overlaps with the Trees topic by design; clarify ownership: Trees owns structural algorithms and query structures, Tree DP owns state transitions and optimization over rooted trees.
- Strings & Subsequences is DP-focused (LCS, edit distance, subsequence counting, palindrome/string DP). It does not replace an advanced string-algorithm topic (suffix arrays, suffix automata, Manacher, rolling hash).
- Data Structure Optimized DP includes CHT, Li Chao, BIT/segment-tree DP, CDQ, divide-and-conquer optimization, Knuth optimization, monotone deque DP and SMAWK-related concepts. This is a substantial existing advanced curriculum; a separate Divide & Conquer topic must avoid copying these examples and should focus on the general paradigm and non-DP applications.
- Profile DP includes column/broken profiles, k-ary profiles, two-column profiles, plug/connectivity DP and transfer-matrix exponentiation. Coordinate it with Bit Manipulation so bit-level techniques are taught once and Profile DP focuses on frontier-state modeling.
- Combinatorial & Modulo DP contains both DP and direct combinatorial/formula alternatives. Retain trap entries that demonstrate when a formula or modular exponentiation is preferable to DP.

## Priority follow-ups

1. Review recurrence/state correctness and proof explanations in topics 30–43, especially advanced optimizations.
2. Repair or map the missing key-insight fields in topics 38–43 only after checking the body and sub_variant content.
3. Verify the source/statement for all custom DP entries and add source URLs or complete original statements.
4. Decide sidebar visibility and prerequisite placement for topics 40 and 41.
5. Define cross-links among Trees ↔ Tree DP, Strings & Subsequences ↔ Advanced String Algorithms, and Profile DP ↔ Bit Manipulation.
6. Keep Easy problems out of the required path, including the one Easy row in topic 33 and one in topic 34.

## Status

The DP catalogue is broad and genuinely advanced in several areas. The remaining risk is not simply missing topics: it is structured metadata, source traceability, prerequisite sequencing, and whether the stated optimizations are explained and proven correctly.
