# Full 43-Topic Curriculum Path Rollout

**Date:** 2026-11-10  
**Repository:** `mints23/dsalgo`  
**Branch:** `main`  
**Curriculum data release:** `v1.0.82` (GitHub Actions run #82)  
**Database:** Supabase project `zxgcsotirznipjjiilim`

## Scope and outcome

The curriculum path and role taxonomy has been extended from the original eight-topic pilot to the entire 43-topic curriculum.

| Production invariant | Verified result |
|---|---:|
| Topics in curriculum | 43 |
| Required problem placements | 922 |
| Required placements with complete path metadata | 922 |
| Required placements with explicit curriculum role | 922 |
| Required placements missing path metadata | 0 |
| Required placements missing role | 0 |
| Placements with null curriculum role (all placements) | 0 |
| Optional references | 203 |

All 43 topics passed the same per-topic check: required count = complete path count = explicit-role count.

## Topic coverage

| ID | Topic | Required | Complete paths | Roles |
|---:|---|---:|---:|---:|
| 1 | Two Pointers | 27 | 27 | 27 |
| 2 | HashMap | 27 | 27 | 27 |
| 3 | Binary Search | 30 | 30 | 30 |
| 4 | Sliding Window | 46 | 46 | 46 |
| 5 | Kadane's Algorithm | 17 | 17 | 17 |
| 6 | Intervals | 31 | 31 | 31 |
| 7 | Prefix Sums | 24 | 24 | 24 |
| 8 | Backtracking | 33 | 33 | 33 |
| 9 | Greedy | 33 | 33 | 33 |
| 10 | Sieve of Eratosthenes | 15 | 15 | 15 |
| 11 | Fenwick Tree / Binary Indexed Tree | 15 | 15 | 15 |
| 12 | Segment Tree | 17 | 17 | 17 |
| 13 | KMP Pattern Matching | 15 | 15 | 15 |
| 14 | LIS | 13 | 13 | 13 |
| 15 | Top K / Heap | 41 | 41 | 41 |
| 16 | Monotonic Stack / Queue | 35 | 35 | 35 |
| 17 | Trees | 29 | 29 | 29 |
| 18 | Trie | 22 | 22 | 22 |
| 19 | Graph Fundamentals | 14 | 14 | 14 |
| 20 | BFS | 23 | 23 | 23 |
| 21 | DFS | 14 | 14 | 14 |
| 22 | Multi-Source BFS | 9 | 9 | 9 |
| 23 | Bipartite Graph | 10 | 10 | 10 |
| 24 | Topological Sort | 15 | 15 | 15 |
| 25 | Dijkstra | 16 | 16 | 16 |
| 26 | Floyd-Warshall | 6 | 6 | 6 |
| 27 | Bellman-Ford | 8 | 8 | 8 |
| 28 | Union Find / DSU | 13 | 13 | 13 |
| 29 | Advanced Graph Algorithms | 15 | 15 | 15 |
| 30 | 1D Linear DP | 24 | 24 | 24 |
| 31 | 2D Grid DP | 26 | 26 | 26 |
| 32 | Knapsack | 29 | 29 | 29 |
| 33 | Strings & Subsequences | 23 | 23 | 23 |
| 34 | State Machine DP | 24 | 24 | 24 |
| 35 | Interval DP | 23 | 23 | 23 |
| 36 | Partition DP | 24 | 24 | 24 |
| 37 | Game Theory & Minimax | 22 | 22 | 22 |
| 38 | Tree DP | 30 | 30 | 30 |
| 39 | Digit DP | 22 | 22 | 22 |
| 40 | DAGs & Probability | 11 | 11 | 11 |
| 41 | Combinatorial & Modulo DP | 12 | 12 | 12 |
| 42 | Data-Structure-Optimised DP | 22 | 22 | 22 |
| 43 | Profile / Broken Profile DP | 17 | 17 | 17 |
| **Total** | **43 topics** | **922** | **922** | **922**|

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

A production query identified 178 cross-topic duplicate LeetCode identities (217 secondary required placements) before canonical ownership work. Five ownership migrations have now demoted 148 confirmed redundant or misclassified placements to optional references, retaining all underlying records and stable identifiers.

Current live verification: **63 duplicate identities remain across topics, representing 70 secondary required placements**. These are retained because the remaining rows teach distinct algorithms, data structures, or deliberate cross-topic integrations. Examples include LC 287 (Floyd vs. value-domain binary search), LC 1074 (2D Kadane vs. 2D prefix compression), LC 399 (Floyd vs. weighted DSU), LC 378 (binary search vs. heap), LC 743 (Dijkstra vs. Bellman-Ford), and LC 1584 (Prim vs. Kruskal). Three same-topic duplicate IDs also remain as explicit solution variants/revisits: LC 215 (heap vs. Quickselect), LC 347 (heap vs. bucket sort), and LC 1289 (baseline vs. advanced revisit).

The canonical-owner pass did not use a blanket one-owner-per-LeetCode rule. A duplicate was retained when its algorithmic lens materially differs; it was made optional only when the same implementation or an incorrect topic classification was repeated. No problem was deleted or moved, and no learner progress records were changed.

## Release verification

- Supabase aggregate verification: 922 required rows, 922 complete paths, 922 explicit roles, zero incomplete required rows, zero null roles across all placements.
- Per-topic verification: all 43 topics passed; each topic's required count equals its complete path count and role count.
- Five canonical-owner migrations applied successfully; optional references increased from 55 to 203.
- GitHub Actions build and GitHub Pages publish job for run #78 completed successfully.
- The production `gh-pages/index.html` footer was inspected and reports `v1.0.78`.
- The production app uses the already-released path-grouping UI; the full data backfill makes path headings available across all topics.

## Remaining QA

Browser-level manual QA remains outstanding for:
- progress restore across a previously completed problem,
- completion and revision toggles after regrouping,
- authored tables with multiple sub-sections,
- narrow mobile widths and horizontal scrolling,
- light and dark theme readability.

The frontend's incomplete-metadata fail-open behavior is in place, but it does not replace these interaction checks.

## Canonical-owner migration files

- `20261110_z_z_full_curriculum_canonical_owner_pass_1.sql` — 105 placements.
- `20261110_z_zz_full_curriculum_canonical_owner_pass_2.sql` — 15 newly demoted placements (two IDs were already optional from pass 1).
- `20261110_z_zzz_full_curriculum_canonical_owner_pass_3.sql` — 16 placements.
- `20261110_z_zzzz_full_curriculum_canonical_owner_pass_4.sql` — 10 placements.
- `20261110_z_zzzzz_full_curriculum_canonical_owner_pass_5.sql` — 2 placements.

The five passes are committed directly to `main` and applied to production. The per-topic path order was recalculated after each pass. A subsequent Segment Tree metadata integrity migration fixed the only path-order/name collision discovered by the global audit. All required rows remain complete.

## Next phase

The remaining 63 cross-topic duplicate identities are retained as deliberate alternate solution lenses or topic integrations. The next outstanding work is browser-level QA of progress restore, completion/revision toggles, multiple authored tables, mobile widths, and light/dark themes. Static source and production bundle checks are complete; interactive browser QA is not claimed.
