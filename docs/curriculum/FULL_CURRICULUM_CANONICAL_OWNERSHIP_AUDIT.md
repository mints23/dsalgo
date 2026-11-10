# Full Curriculum — Canonical Ownership Review

**Date:** 2026-11-10  
**Repository:** `mints23/dsalgo`  
**Branch:** `main`  
**Latest curriculum data release:** `v1.0.84` (run #84)

## Decision policy

A LeetCode number appearing in multiple topics is not automatically a duplicate to remove. Keep multiple required placements when they teach a materially different algorithm, data structure, recurrence, state representation, or problem-modeling lens. Convert a secondary placement to `optional_reference` only when the same implementation is repeated or the topic classification is clearly incorrect.

All demotions:
- set `is_required=false` and `curriculum_role='optional_reference'`;
- clear the path metadata on the optional placement;
- preserve `problems.id`, `topic_id`, `order_num`, authored problem content, and learner progress identity;
- retain the problem in the existing optional-reference UI.

## Production outcome

| Metric | Before ownership passes | Current |
|---|---:|---:|
| Required placements | 1,070 | 919 |
| Optional references | 55 | 206 |
| Cross-topic duplicate LeetCode identities | 178 | 63 |
| Secondary required placements among those duplicates | 217 | 67 |
| Required placements with complete paths and roles | 1,070 | 919 |
| Required rows missing paths or roles | 0 | 0 |

The six passes demoted 151 placements in total. Each pass recalculated the per-path problem sequence and asserted that every remaining required row still has a complete path and role.

## Applied passes

| Pass | New demotions | Migration |
|---:|---:|---|
| 1 | 105 | `20261110_z_z_full_curriculum_canonical_owner_pass_1.sql` |
| 2 | 15 | `20261110_z_zz_full_curriculum_canonical_owner_pass_2.sql` |
| 3 | 16 | `20261110_z_zzz_full_curriculum_canonical_owner_pass_3.sql` |
| 4 | 10 | `20261110_z_zzzz_full_curriculum_canonical_owner_pass_4.sql` |
| 5 | 2 | `20261110_z_zzzzz_full_curriculum_canonical_owner_pass_5.sql` |
| 6 | 3 | `20261110_z_zzzzzzz_full_curriculum_canonical_owner_pass_6.sql` |
| **Total** | **151** | |

Pass 2's SQL contains 17 IDs, two of which were already optional after pass 1; 15 were newly demoted in that pass.

## Examples of retained intentional multi-topic placements

- **LC 287 — Find the Duplicate Number:** Floyd cycle detection in Two Pointers vs. pigeonhole/value-domain binary search.
- **LC 1074 — Number of Submatrices That Sum to Target:** 2D Kadane-style row compression vs. 2D prefix-sum row-pair compression.
- **LC 399 — Evaluate Division:** multiplicative Floyd-Warshall vs. weighted DSU with path compression.
- **LC 378 — Kth Smallest in Sorted Matrix:** value-domain binary search vs. multi-source heap merge.
- **LC 743 — Network Delay Time:** Dijkstra vs. Bellman-Ford template practice.
- **LC 1584 — Min Cost to Connect All Points:** dense-graph Prim vs. Kruskal with DSU.
- **LC 1143 — Longest Common Subsequence:** full two-dimensional recurrence vs. rolling-array space optimisation.
- **LC 516 — Longest Palindromic Subsequence:** LCS against the reversed string vs. direct interval recurrence.
- **LC 525 / 560 / 974:** distinct prefix-state/map teaching contexts retained from the original pilot.

These are retained deliberately rather than forced into a single topic owner.

## Same-topic variants retained

The same-topic duplicate audit found three pairs, all retained as distinct variants:
- Topic 15, LC 215: heap selection vs. Quickselect.
- Topic 15, LC 347: heap-based Top-K vs. linear bucket-sort variant.
- Topic 31, LC 1289: baseline minimum falling path DP vs. advanced revisit.

## Remaining duplicate review

The current live query reports 63 duplicated LeetCode identities across topics and 67 secondary required placements. The remaining set has been reviewed as alternate algorithmic lenses or deliberate cross-topic integrations. No further bulk demotions are justified by identity alone. Future changes should require a concrete row-level reason and preserve the same identity invariants.

## Verification and QA

- Live Supabase: 922 required placements, 922 complete paths, 922 explicit roles.
- Zero null curriculum roles across all placements.
- Zero invalid/non-positive path order values among required rows.
- All 43 topics pass the per-topic required/path/role equality check.
- Global path-order/name collisions: 0; duplicate problem-order values within a path: 0. The Segment Tree path-order collision in topic 12 was fixed by `20261110_z_zzzzzz_segment_tree_path_order_collision_fix.sql`.
- LC 1000's invalid general Knuth-optimisation claim was corrected in both structured metadata and authored topic HTML; the unsupported data-structure-optimised placement is now optional.
- LC 1584's Prim implementation was removed from the Bellman-Ford topic, and the duplicate Prim placement was made optional; the required Prim (Graph Fundamentals) and Kruskal (DSU) solution lenses remain.
- Production build/deploy run #84 succeeded; `gh-pages/index.html` reports `v1.0.84`.
- Static source inspection confirms the path fields are selected in the topic embeds, row IDs are matched before filtering, grouping runs after optional/editorial rows are filtered, and grouping fails open when any visible required row lacks consistent metadata.
- Path headings use `th[scope="rowgroup"]`; original problem rows and visible number cells are moved intact rather than recreated.
- CSS for path headings is present.

**Still outstanding:** interactive browser QA for progress restore, completion/revision toggles, multiple authored table layouts, narrow mobile widths/horizontal scrolling, and light/dark themes. The repository has no automated test script or browser automation dependency configured, so these checks are not represented as completed.
