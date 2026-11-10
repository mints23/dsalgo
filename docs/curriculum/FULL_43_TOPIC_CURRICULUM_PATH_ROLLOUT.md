# Full 43-Topic Curriculum Path Rollout

**Date:** 2026-11-10  
**Repository:** `mints23/dsalgo`  
**Branch:** `main`  
**Production release:** `v1.0.70` (GitHub Actions run #70)  
**Database:** Supabase project `zxgcsotirznipjjiilim`

## Scope and outcome

The curriculum path and role taxonomy has been extended from the original eight-topic pilot to the entire 43-topic curriculum.

| Production invariant | Verified result |
|---|---:|
| Topics in curriculum | 43 |
| Required problem placements | 1,070 |
| Required placements with complete path metadata | 1,070 |
| Required placements with explicit curriculum role | 1,070 |
| Required placements missing path metadata | 0 |
| Required placements missing role | 0 |
| Placements with null curriculum role (all placements) | 0 |
| Optional references | 55 |

All 43 topics passed the same per-topic check: required count = complete path count = explicit-role count.

## Topic coverage

| ID | Topic | Required | Complete paths | Roles |
|---:|---|---:|---:|---:|
| 1 | Two Pointers | 27 | 27 | 27 |
| 2 | HashMap | 27 | 27 | 27 |
| 3 | Binary Search | 33 | 33 | 33 |
| 4 | Sliding Window | 46 | 46 | 46 |
| 5 | Kadane's Algorithm | 19 | 19 | 19 |
| 6 | Intervals | 32 | 32 | 32 |
| 7 | Prefix Sums | 25 | 25 | 25 |
| 8 | Backtracking | 35 | 35 | 35 |
| 9 | Greedy | 37 | 37 | 37 |
| 10 | Sieve of Eratosthenes | 15 | 15 | 15 |
| 11 | Fenwick Tree / Binary Indexed Tree | 16 | 16 | 16 |
| 12 | Segment Tree | 17 | 17 | 17 |
| 13 | KMP Pattern Matching | 15 | 15 | 15 |
| 14 | LIS | 16 | 16 | 16 |
| 15 | Top K / Heap | 46 | 46 | 46 |
| 16 | Monotonic Stack / Queue | 38 | 38 | 38 |
| 17 | Trees | 46 | 46 | 46 |
| 18 | Trie | 22 | 22 | 22 |
| 19 | Graph Fundamentals | 35 | 35 | 35 |
| 20 | BFS | 36 | 36 | 36 |
| 21 | DFS | 25 | 25 | 25 |
| 22 | Multi-Source BFS | 13 | 13 | 13 |
| 23 | Bipartite Graph | 11 | 11 | 11 |
| 24 | Topological Sort | 15 | 15 | 15 |
| 25 | Dijkstra | 18 | 18 | 18 |
| 26 | Floyd-Warshall | 8 | 8 | 8 |
| 27 | Bellman-Ford | 10 | 10 | 10 |
| 28 | Union Find / DSU | 13 | 13 | 13 |
| 29 | Advanced Graph Algorithms | 16 | 16 | 16 |
| 30 | 1D Linear DP | 49 | 49 | 49 |
| 31 | 2D Grid DP | 27 | 27 | 27 |
| 32 | Knapsack | 30 | 30 | 30 |
| 33 | Strings & Subsequences | 29 | 29 | 29 |
| 34 | State Machine DP | 24 | 24 | 24 |
| 35 | Interval DP | 25 | 25 | 25 |
| 36 | Partition DP | 26 | 26 | 26 |
| 37 | Game Theory & Minimax | 22 | 22 | 22 |
| 38 | Tree DP | 32 | 32 | 32 |
| 39 | Digit DP | 22 | 22 | 22 |
| 40 | DAGs & Probability | 14 | 14 | 14 |
| 41 | Combinatorial & Modulo DP | 14 | 14 | 14 |
| 42 | Data-Structure-Optimised DP | 24 | 24 | 24 |
| 43 | Profile / Broken Profile DP | 20 | 20 | 20 |
| **Total** | **43 topics** | **1,070** | **1,070** | **1,070** |

## Implementation batches committed directly to main

The following data migrations extend the pilot taxonomy. Each was committed to `main` and applied to the production Supabase project with per-topic assertions.

- `20261110_z_backtracking_curriculum_paths.sql`
- `20261110_z_sieve_bit_segment_tree_kmp_paths.sql`
- `20261110_z_lis_heap_monotonic_stack_paths.sql`
- `20261110_z_trees_and_tries_paths.sql`
- `20261110_z_graph_bfs_dfs_bipartite_toposort_paths.sql`
- `20261110_z_shortest_paths_floyd_bellmanford_dsu_advanced_graph_paths.sql`
- `20261110_z_dp_linear_grid_knapsack_strings_state_machine_paths.sql`
- `20261110_z_advanced_dp_digit_probability_profile_paths.sql`

The original eight-topic pilot migrations remain in the repository and production migration history.

## Preserved invariants

- No problem row was deleted or moved to another topic.
- Existing `problems.id`, `topic_id`, and `order_num` values were preserved.
- Existing visible problem numbers and progress identity were preserved.
- The path columns are presentation/teaching metadata only.
- Optional references and excluded/out-of-scope placements remain separate from required curriculum rows.
- The frontend groups only when the visible required rows in an authored table have complete metadata; it fails open otherwise.

## Cross-topic identity review

A production query identified **178 LeetCode numbers duplicated across topics**, representing **217 secondary required placements**. This is not automatically a data-integrity failure: several duplicates intentionally teach different algorithmic lenses (for example, alternate solution strategies or a topic-specific integration).

The original eight-topic pilot has a completed canonical-owner pass. The remaining curriculum's duplicate placements have not been automatically demoted. A dedicated ownership pass must inspect the problem's key insight and topic-specific learning objective before changing a secondary placement to `optional_reference`. Until that pass is complete, all existing placements remain intact and no learner progress is affected.

## Release verification

- Supabase aggregate verification: 1,070 required rows, 1,070 complete paths, 1,070 explicit roles, zero incomplete required rows, zero null roles across all placements.
- Per-topic verification: all 43 topics passed.
- GitHub Actions build and GitHub Pages publish job for run #70 completed successfully.
- The workflow-generated release footer is `v1.0.70`.
- The production app uses the already-released path-grouping UI; the full data backfill makes path headings available across all topics.

## Remaining QA

Browser-level manual QA remains outstanding for:
- progress restore across a previously completed problem,
- completion and revision toggles after regrouping,
- authored tables with multiple sub-sections,
- narrow mobile widths and horizontal scrolling,
- light and dark theme readability.

The frontend's incomplete-metadata fail-open behavior is in place, but it does not replace these interaction checks.

## Next phase

Complete the cross-topic canonical-owner review for the 178 duplicated identities, retaining intentional multi-topic algorithmic lenses and demoting only confirmed secondary references. Then perform the browser-level QA checklist above.
