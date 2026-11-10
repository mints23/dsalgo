# Cross-Topic Canonical Ownership Audit

**Scope:** Live production `public.problems` rows with numeric LeetCode IDs, across topics 1–43.  
**Status:** First-pass ownership and learning-contribution audit. No problem rows, topic HTML, learner progress, or playback records were changed during this pass.

## Live inventory

| Measure | Current value |
|---|---:|
| Problem records | 1,311 |
| Distinct numeric LeetCode IDs | 823 |
| IDs placed in more than one topic | 229 |
| Rows belonging to those 229 multi-topic IDs | 559 |
| Additional placements beyond one per ID | 330 |
| IDs repeated anywhere, including same-topic repeats | 238 |
| Rows belonging to all repeated IDs | 578 |
| Same-topic problem/topic pairs | 25 |
| Extra rows from same-topic repeats | 26 |

The 229 multi-topic IDs have uneven metadata quality. Based on the current `curriculum_role` field:
- 57 have exactly one topic with a `core_pattern` placement.
- 20 have `core_pattern` placements in multiple topics.
- 152 have no `core_pattern` placement.
- 53 have at least one diagnostic-trap placement.
- One repeated ID also has an `out_of_scope` placement (LC 56, already excluded from Kadane's topic path).

This means a database role alone cannot safely infer canonical ownership. In particular, pending roles and multiple core placements require a content-level decision.

## Ownership model

Every repeated problem should receive one primary ownership decision and an explicit reason for each secondary placement. The categories are:

1. **Canonical owner** — the topic that teaches the most direct, standard solution or the main invariant.
2. **Alternate algorithm** — a genuinely different correct approach with a distinct complexity or invariant.
3. **Cross-pattern bridge** — the same problem intentionally connects two reusable patterns.
4. **Prerequisite reinforcement** — repeats a foundational template in a later topic to make the transfer explicit.
5. **Diagnostic trap** — explains why a tempting technique is incorrect, incomplete, or unnecessarily expensive in this topic.
6. **Redundant placement** — repeats the same solution and learning objective without adding a new concept, proof, constraint, or implementation insight.

A repeated LeetCode ID is not itself a defect. A secondary placement should remain required only when its learning contribution is clear; otherwise it can be demoted to optional reference after review. Trap rows should remain when they are genuinely useful diagnostics for that topic. A trap should only be removed from a topic path when the underlying problem and its diagnostic lesson do not belong there. Preserve the database record and all learner history in either case.

## Verified examples of useful multiple placements

| LeetCode | Primary / strongest home | Secondary learning contribution | Decision |
|---|---|---|---|
| 1 — Two Sum | HashMap (unsorted input, complement lookup) | Two Pointers explains why unsorted input and original-index requirements invalidate the naïve two-pointer choice; sorted-input variant contrasts the correct alternative | Keep both diagnostics |
| 5 — Longest Palindromic Substring | Two Pointers (expand around centre) | 1D/string DP reuses a palindrome table; KMP and Interval DP placements warn against forcing those methods or missing Manacher's linear-time option | Keep distinct method lenses |
| 42 — Trapping Rain Water | Two Pointers (constant-space left/right maxima) | Monotonic Stack computes water by resolving a basin between walls | Keep both algorithms |
| 307 — Range Sum Query Mutable | BIT and Segment Tree are both canonical data-structure implementations | Prefix-sum placement introduces the static-to-dynamic transition | Keep as a data-structure comparison |
| 743 — Network Delay Time | Dijkstra for non-negative weighted single-source shortest path | Bellman-Ford is a deliberate template exercise; BFS placement is a weighted-edge counterexample | Keep the diagnostic and algorithm comparison |
| 139 — Word Break | Partition DP | General 1D DP placement teaches prefix-state transitions; Trie placement explains why exact dictionary membership does not require a trie | Keep the bridge and trap |
| 1584 — Min Cost to Connect All Points | MST: Prim / Kruskal (Topics 19, 28, 29) | Bellman-Ford topic placement uses Prim's MST as a contrast with shortest-path algorithms | Review the Bellman-Ford placement label; do not delete automatically |
| 2492 — Minimum Score of a Path Between Two Cities | BFS / connected-component scan (Topic 20) | Floyd-Warshall topic currently labels it core, although the task is component reachability plus minimum edge, not all-pairs shortest paths | Review Topic 26 classification |
| 2421 — Number of Good Paths | DSU with sorted edge activation; also appears in Trees / Tree DP | Floyd-Warshall placement explicitly says the optimal solution is DSU and APSP is overkill | Keep as a diagnostic contrast, not a Floyd core pattern |
| 282 — Expression Add Operators | Backtracking / expression construction (Topic 8) | Interval DP placement describes interval splitting, but the actual search is DFS/backtracking with last-term bookkeeping | Review Topic 35 classification |
| 363 — Max Sum of Rectangle No Larger Than K | 2D-to-1D compression + prefix sums + ordered set (Topics 5/31) | Profile DP placement currently calls a pair of column boundaries a “profile”; that is not frontier-mask/profile DP | Correct Topic 43 classification; retain only as a diagnostic if the lesson is made explicit |

The examples above are learning-contribution decisions, not instructions to collapse valid alternate solutions into one row.

## Same-topic duplicate review

The live inventory contains 25 repeated problem/topic pairs and 26 extra rows. Most are purposeful canonical-plus-diagnostic pairs:
- Implementation and invariant traps: LC 33, 34, 704, 875, 210, 269, 542, 785, 886, and 2258.
- Algorithm alternatives: LC 215 (heap vs Quickselect) and LC 347 (heap vs bucket sort).
- Complexity / modeling diagnostics: LC 128, 146, 290, 454, 560, and 952.
- Two revisit pairs need an explicit concept-delta check: LC 300 in Topic 30 and LC 1289 in Topic 31.

Do not remove the same-topic trap rows when they add a distinct implementation or reasoning lesson.

## Classification review queue

These placements deserve source-and-content review before being treated as canonical:

| Topic | Problem | Current issue | Safe next action |
|---:|---|---|---|
| 26 — Floyd-Warshall | LC 2492 | Currently `core_pattern`, but its optimal method is BFS/DFS over the connected component plus a minimum-edge scan; Floyd is not appropriate at the problem's scale | Reclassify as a method-selection diagnostic or move to review; retain the row until topic HTML is reconciled |
| 26 — Floyd-Warshall | LC 2421 | Currently a variant, but the content explicitly says “not Floyd-Warshall” and contrasts DSU with APSP | Mark the role as diagnostic trap if retained in this topic |
| 27 — Bellman-Ford | LC 1584 | Prim/Kruskal MST, not Bellman-Ford; possible shortest-path-vs-MST comparison but the learning objective must be explicit | Review the rationale and label; do not delete |
| 35 — Interval DP | LC 282 | The actual solution is backtracking with expression-state bookkeeping, not interval DP | Correct the algorithm label; retain as a diagnostic only if it teaches a clear contrast |
| 43 — Profile DP | LC 363 | Boundary-pair compression plus ordered-set prefix search is not frontier profile DP | Correct the label; retain as a diagnostic only if the distinction is explicit |

These are not all removal candidates. The review queue deliberately separates “wrong core/variant label” from “unrelated trap”; only the latter should be excluded from a topic path under the agreed curation rule.

## Data safety

- No problem rows were deleted.
- No repeated problem was automatically removed or demoted.
- No `user_progress` or `problem_playback` rows were changed.
- Authentication, subscriptions, Razorpay/payment flows, and learner-facing progress were not touched.
- The existing out-of-scope handling remains additive: excluded records keep their IDs and history.

## Next phase

1. Resolve the five classification-review items above against the topic HTML and official problem statements.
2. Assign canonical ownership and a concept-delta label to every multi-topic repeat.
3. Demote only demonstrably redundant non-trap placements to optional reference, after verifying that the secondary row teaches no distinct method or invariant.
4. Revisit the 145 missing `key_insight` values in Topics 38–43 after ownership is stable.
