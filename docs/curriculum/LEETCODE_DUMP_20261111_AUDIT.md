# LeetCode dump audit — 2026-11-11

## Executive result

The uploaded CSV contains **3,549 distinct LeetCode records**, with frontend IDs spanning 1–3,549. The exact-ID comparison against AlgoFrog found **820 distinct LeetCode IDs already represented** and **2,729 IDs not represented by an exact LeetCode ID**.

That gap is not a recommendation to import 2,729 questions. Many are alternative exercises for techniques already taught, duplicates of CSES/Codeforces/custom practice, API-specific exercises, or problems whose tags do not reveal a new algorithm. The audit therefore used exact-ID coverage plus a semantic review of the high-signal advanced candidates: problem statement, constraints, hints and available solution metadata were checked before deciding whether a question contributed a distinct invariant, data structure, proof or implementation pattern.

## Dump inventory

| Measure | Count |
|---|---:|
| Total rows | 3,549 |
| Unique frontend question IDs | 3,549 |
| Unique title slugs | 3,549 |
| Algorithms category | 3,142 |
| Database category | 302 |
| JavaScript category | 67 |
| pandas category | 15 |
| Concurrency category | 9 |
| Shell category | 4 |
| Blank category | 10 |
| Easy | 876 |
| Medium | 1,840 |
| Hard | 833 |
| Description present | 2,830 |
| Editorial solution present | 837 |
| Java solution code present | 991 |
| Both editorial and Java code absent | 2,001 |
| Unique topic tags | 71 |

Tags are useful discovery metadata, not a curriculum taxonomy. A tag such as “Segment Tree”, “Trie” or “Probability” does not establish that a problem teaches a new sub-pattern.

## Additions selected

**24 new problem placements were added: 22 required and 2 optional references.** Two new topic homes were created. Existing problem IDs and progress references were not edited or recreated.

| LeetCode | New learning outcome | Destination | Decision |
|---|---|---|---|
| 380 — Insert Delete GetRandom O(1) | Dense array + value-index map; swap-delete invariant | 49 Randomized Algorithms | Required |
| 381 — Insert Delete GetRandom O(1), duplicates | Index-set maintenance for a multiset under swap-delete | 49 | Required |
| 382 — Linked List Random Node | Reservoir sampling for an unknown-length stream | 49 | Required |
| 398 — Random Pick Index | Reservoir sampling after filtering occurrences | 49 | Required |
| 384 — Shuffle an Array | Fisher–Yates and uniform-permutation proof | 49 | Required |
| 519 — Random Flip Matrix | Sparse Fisher–Yates over an implicit huge domain | 49 | Required |
| 470 — Implement Rand10 Using Rand7 | Rejection sampling and modulo-bias avoidance | 49 | Required |
| 478 — Generate Random Point in a Circle | Inverse-transform sampling; radius proportional to square root of U | 49 | Required |
| 528 — Random Pick with Weight | Prefix-sum weighted discrete sampling | 49 | Required |
| 497 — Random Point in Non-overlapping Rectangles | Weighted sampling by lattice-point count, then local coordinate sampling | 49 | Required |
| 912 — Sort an Array | Comparison-sort guarantees, stability and space trade-offs | 50 Sorting & Selection | Required |
| 148 — Sort List | Linked-list merge sort; top-down vs bottom-up space | 50 | Required |
| 164 — Maximum Gap | Pigeonhole bucket bound for linear-time maximum adjacent gap | 50 | Required |
| 2343 — Query Kth Smallest Trimmed Number | Stable LSD radix passes with original-index tie-breaking | 50 | Required |
| 324 — Wiggle Sort II | Quickselect median + three-way partition + virtual indexing | 50 | Required |
| 220 — Contains Duplicate III | Sliding index window plus predecessor/successor or value buckets | 4 Sliding Window | Required |
| 277 — Find the Celebrity | Pairwise candidate elimination followed by mandatory verification | 1 Two Pointers | Required |
| 843 — Guess the Word | Minimax partitioning of candidates by oracle feedback | 37 Game Theory & Minimax | Required |
| 1467 — Probability of Two Boxes Having the Same Number of Distinct Balls | Weighted combinatorial allocation DP using binomial coefficients | 40 DAGs & Probability | Required |
| 3213 — Construct String with Minimum Cost | Weighted word-break DP accelerated by length-grouped rolling hashes or multi-pattern matching | 46 Advanced Strings | Required |
| 391 — Perfect Rectangle | Exact-cover invariant combining total area and corner parity | 48 Computational Geometry | Required |
| 3454 — Separate Squares II | Union-area sweep and segment-tree covered length; locate a horizontal area quantile | 48 | Required |
| 1227 — Airplane Seat Assignment Probability | Symmetry and first-displaced-seat argument | 40 | Optional reference |
| 1515 — Best Position for a Service Centre | Geometric median and iterative convex optimisation | 48 | Optional reference |

### Why the new topics were justified

**Topic 49 — Randomized Algorithms & Uniform Sampling** fills a genuine family gap. Before this audit, the curriculum contained weighted/blacklist sampling in a HashMap context and probability DP, but did not teach the uniformity proofs behind reservoir sampling, Fisher–Yates, rejection sampling, inverse transforms, sparse sampling without replacement, or O(1) randomised sets. LC 470 and LC 528 were already present in Topic 40 as excluded traps because they are not probability-DP problems. Those trap placements remain; Topic 49 is their algorithmic owner.

**Topic 50 — Sorting, Selection & Order Statistics** fills the missing systematic treatment of sorting as an algorithmic design choice. Topic 15 already teaches heap-based top-K, QuickSelect and bucket-based selection; it does not replace comparison-sort guarantees, linked-list merge sort, pigeonhole bucketing for maximum gap, stable radix passes or virtual-index three-way partitioning.

## Reviewed but not added as new required questions

These examples already map to a meaningful current owner, or add application volume without a distinct required learning outcome:

| Dump problem(s) | Existing coverage / decision |
|---|---|
| 218 Skyline Problem | Topic 6 sweep line and interval aggregation |
| 307 Range Sum Query — Mutable; 308 Range Sum Query 2D — Mutable | Topic 11 BIT and Topic 12 Segment Tree |
| 315 Count of Smaller Numbers After Self; 327 Count of Range Sum; 493 Reverse Pairs | Existing BIT / merge-count / segment-tree DP families |
| 332 Reconstruct Itinerary; 2097 Valid Arrangement of Pairs; 753 Cracking the Safe | Topic 29 Eulerian path/circuit and de Bruijn construction |
| 850 Rectangle Area II | Topic 12 geometric sweep + covered-length segment tree |
| 1192 Critical Connections | Topic 29 low-link bridges |
| 1851 Minimum Interval to Include Each Query; 759 Employee Free Time | Topic 6 interval sweep and offline query processing |
| 1923 Longest Common Subpath; 1698 Number of Distinct Substrings; 1062 Longest Repeating Substring | Topic 46 rolling hash, suffix structures and distinct-substring counting |
| 2407 Longest Increasing Subsequence II | Topic 42 data-structure-optimised DP |
| 710 Random Pick with Blacklist | Already required in Topic 2; no duplicate placement added |
| 470 Rand10 Using Rand7; 528 Random Pick with Weight | Existing Topic 40 trap references retained while Topic 49 becomes the positive algorithm owner |

Many other problems tagged with Trie, BIT, Segment Tree, Topological Sort, Shortest Path, Number Theory, Bitmask, Combinatorics, Game Theory or Geometry were treated as additional applications unless their constraints required a new proof or data-structure invariant.

## Exclusions and optional decisions

- Database, JavaScript, pandas and Shell entries are outside this DSA curriculum. Concurrency problems belong in a separate concurrency/interview track rather than being mixed into algorithm topics.
- Read4 variants (157/158) are stateful API/buffer-management exercises; they are not a missing general algorithm pattern in this track.
- The geometric-median problem (1515) is retained as an optional numerical-optimisation reference, not a required interview gate.
- Airplane Seat Assignment (1227) is retained as an optional symmetry puzzle. Its key insight is not a DP transition.
- The celebrity problem (277) is included because candidate elimination plus verification is a compact, reusable reasoning pattern.
- Guess the Word (843) is included because the feedback response partitions the candidate space; minimax worst-case bucket size is a meaningful strategy rather than ordinary brute-force guessing.

## Production verification

After the additions:

- **50 topics**, of which **48 are sidebar-visible**.
- **1,401 total problem rows**.
- **1,007 required placements**.
- **0 required placements missing curriculum path metadata**.
- **0 duplicate required path positions**.

The release migration is `migrations/20261111_leetcode_dump_gap_expansion.sql`. Navigation and the static marketing problem count were synchronised. The database migration was applied successfully; the website build/deployment is verified separately through GitHub Actions before declaring the front end released.

## Audit caveat

The 3,549-row inventory and exact-ID coverage comparison were exhaustive. The semantic deep review concentrated on the high-signal candidate gaps and advanced-tag families listed above, rather than claiming every absent LeetCode ID deserves an individual narrative. The 2,729 IDs absent by exact number remain candidate practice material, not evidence of 2,729 missing concepts. This avoids turning a complete dump into a volume-driven import.
