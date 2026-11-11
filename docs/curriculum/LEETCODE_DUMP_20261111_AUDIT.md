# LeetCode dump deep audit — 2026-11-11

## Executive decision

The uploaded dump contains **3,549 LeetCode records**. After six curriculum-gap expansion passes, AlgoFrog now represents **891 unique LeetCode IDs** from this dump. **2,658 IDs remain absent by exact number**.

The audit created **73 new problem placements**: **50 required** and **23 optional**. Two placements (LC 470 and LC 528) intentionally reuse IDs that were already represented as trap references in the probability topic, so the first five passes added 61 new unique IDs; Pass 6 added 10 more. The total moved from 820 to 891 unique IDs represented from the dump. Existing problem IDs and learner progress references were preserved.

This was not an instruction to import every absent question. A problem is added as required only when it teaches a distinct invariant, data structure, proof, constraint-sensitive reduction, or reusable algorithmic composition. A different story using the same core technique is generally treated as another application, not a new concept.

## Inventory of the remaining 2,658

### Scope

| Category | Remaining rows |
|---|---:|
| Algorithms | 2,253 |
| Database | 302 |
| JavaScript | 67 |
| pandas | 15 |
| Concurrency | 9 |
| Shell | 4 |
| Uncategorised | 8 |
| **Total** | **2,658** |

The 405 non-Algorithms records are not automatically DSA gaps. They belong in database, language, concurrency or other separate interview tracks.

### Difficulty

| Difficulty | Rows |
|---|---:|
| Easy | 808 |
| Medium | 1,370 |
| Hard | 480 |

### Row-level disposition

Every ID remaining after Pass 6 has a row-level triage classification in the original audit CSV/workbook; those files are a pre-Pass-6 snapshot and therefore still include the ten newly accepted IDs.

| Disposition | Rows | Interpretation |
|---|---:|---|
| Existing curriculum family | 734 | Maps to an existing pattern family; absent ID does not establish a missing concept |
| Cross-topic application / combination | 1,425 | Combines known techniques or provides another application; inspect for transfer value before adding |
| Advanced tag — second-look candidate | 10 | Rare tag or advanced label warrants technique-level scrutiny; not an automatic addition |
| Distinctive phrase match — second look | 0 | Both high-priority sequencing candidates were resolved in Pass 6 |
| Insufficient source evidence | 84 | The dump does not provide enough source material for a reliable semantic judgement |
| Out of DSA scope / separate track | 405 | Database, JavaScript, pandas, Shell, Concurrency or uncategorised material |
| **Total** | **2,658** | |

The two P1 candidates were accepted as explicit progression steps in Pass 6: LC 3253 now introduces trie-guided weighted segmentation before the harder fast-matching LC 3213; LC 3341 now establishes the simple earliest-arrival relaxation before phase-dependent LC 3342. They are useful sequencing additions rather than wholly new algorithm families.

## Source evidence limitations

The dump is not a complete editorial archive. Of the remaining 2,658 rows:

| Evidence type | Rows |
|---|---:|
| Statement + editorial or Java code | 790 |
| Statement only | 1,217 |
| Editorial or Java code only | 188 |
| Metadata only | 463 |

Missing fields:

| Missing field | Rows |
|---|---:|
| Problem description | 651 |
| Editorial solution | 2,074 |
| Java solution code | 2,112 |
| Hints | 829 |

**Interpretation:** all 2,668 IDs were row-level triaged using title, topic tags, available problem statement, hints, editorial/code excerpts, likely curriculum owner and source URL. The high-signal technique candidates were individually inspected in greater depth, with constraints and solution mechanics checked where source material was present. The 2,668 rows have **not** each received an individually authored editorial proof or full code review. The 84 rows marked insufficient evidence (and the 465 metadata-only rows) should not be treated as confidently redundant.

## Six expansion passes completed

### Pass 1 — add missing broad families and strong examples

Created two new topics:

- **Topic 49 — Randomized Algorithms & Uniform Sampling**: randomized set/multiset, reservoir sampling, Fisher–Yates, sparse sampling without replacement, rejection sampling, uniform continuous sampling, weighted sampling.
- **Topic 50 — Sorting, Selection & Order Statistics**: comparison-sort guarantees, linked-list merge sort, pigeonhole buckets, stable radix sort, Quickselect and virtual-index partitioning.

Required additions in existing topics included:

- Topic 1: LC 277 — Find the Celebrity (candidate elimination + verification).
- Topic 4: LC 220 — Contains Duplicate III (index window + ordered predecessor/successor or buckets).
- Topic 37: LC 843 — Guess the Word (minimax feedback partition).
- Topic 40: LC 1467 — Probability of Two Boxes (weighted combinatorial allocation).
- Topic 46: LC 3213 — Construct String with Minimum Cost (weighted word-break DP + fast dictionary matching).
- Topic 48: LC 391 — Perfect Rectangle; LC 3454 — Separate Squares II.

Optional references: LC 1227 (symmetry probability), LC 1515 (geometric median).

### Pass 2 — distinct invariants hidden behind broad tags

Required additions:

- Topic 10: LC 2447 — subarray GCD frontier.
- Topic 12: LC 3479 — segment-tree first-fit descent.
- Topic 20: LC 2612 — parity-aware BFS with successor DSU.
- Topic 24: LC 3530 — subset DP over topological prefixes/order ideals.
- Topic 28: LC 2092 — same-timestamp batch DSU and selective reset.
- Topic 29: LC 1724 — MST + LCA bottleneck path queries.
- Topic 37: LC 2029 — modulo-3 residue game.
- Topic 41: LC 1735 (stars and bars over prime exponents), LC 3518 (multiset lexicographic unranking).
- Topic 44: LC 3209 (bitwise-AND frontier), LC 3117 (AND frontier + partition DP).
- Topic 46: LC 2430 (rolling-hash predicate inside prefix DP).
- Topic 48: LC 1453 (fixed-radius circle-centre enumeration), LC 3102 (Manhattan-to-L-infinity transform).

Optional references added for GCD pair inversion, MKAverage, weighted DSU consistency, reverse-time component aggregates, component bitwise AND, permutation rank, information capacity, minimum enclosing circle and constrained L1 closest pair.

### Pass 3 — cross-topic combinations

- Required: Topic 48 LC 3382 — maximum empty rectangle with point constraints, using orthogonal range queries.
- Optional: Topic 18 LC 3045 (paired-character prefix/suffix trie), Topic 46 LC 2851 (rotation matching + two-class transition recurrence), Topic 7 LC 2949 (number-theoretic prefix-balance classes), Topic 41 LC 2954 (infection-gap interleavings).

### Pass 4 — harder reductions and optimisation patterns

Required additions:

- Topic 10: LC 1819 — divisor-sieve characterisation of attainable subsequence GCDs.
- Topic 25: LC 3342 — phase-aware time-dependent Dijkstra.
- Topic 42: LC 1687 — constrained partition DP with a monotone deque; LC 2945 — monotonic-stack optimisation for non-decreasing segment-sum partitioning.
- Topic 48: LC 3235 — circular-obstacle barrier connectivity with DSU; LC 963 — rotated rectangle detection through equal-length diagonals and a common midpoint.

Optional references: LC 2470 (monotone LCM extension), LC 3336 (two-dimensional GCD DP), LC 2713 (same-value batched row/column DP).

### Pass 5 — specialised transfer exercises

- Topic 20: LC 3244 — successor-pointer path compression for monotone forward shortcuts (optional).
- Topic 48: LC 335 — self-crossing orthogonal spiral with a bounded set of local configurations (optional).



### Pass 6 — resolve the remaining high-value sequencing and technique gaps

Required additions:

- Topic 8: LC 489 — Robot Room Cleaner (unknown-grid exploration with relative coordinates, visited-state tracking and physically reversible DFS).
- Topic 10: LC 372 — Super Pow (modular exponentiation when the exponent is supplied as decimal digits).
- Topic 18: LC 3253 — Construct String with Minimum Cost (Easy) (trie-guided minimum-cost segmentation, preceding the harder LC 3213 fast-matching version).
- Topic 25: LC 3341 — Find Minimum Time to Reach Last Room I (earliest-arrival Dijkstra with per-cell opening times); LC 3342 is ordered directly after it as the phase-aware continuation.
- Topic 44: LC 191 — Number of 1 Bits (Hamming weight via Brian Kernighan's lowest-set-bit clearing).
- Topic 48: LC 427 — Construct Quad Tree; LC 558 — Logical OR of Two Binary Grids Represented as Quad-Trees (construct, combine and coalesce compressed spatial regions).

Optional references:

- Topic 10: LC 2543 — Check if Point Is Reachable (GCD invariant under subtraction and doubling).
- Topic 11: LC 3073 — Maximum Increasing Triplet Value (ordered-set predecessor plus suffix maximum).
- Topic 45: LC 1982 — Find Array Given Subset Sums (inverse subset-sum reconstruction by multiset pairing).

This pass adds seven required placements and three optional references. No new topic was needed; all additions were placed within existing learning paths or optional-reference sections.

## Why other rare-tag problems were not automatically added

Examples already map to existing AlgoFrog techniques, or would mainly add another application:

| Dump problem(s) | Existing AlgoFrog coverage |
|---|---|
| LC 218 — Skyline Problem | Interval sweep line / event ordering |
| LC 307 / 308 — mutable range sums | Fenwick tree / segment tree |
| LC 315 / 327 / 493 — order and range counting | BIT, merge-counting and segment-tree families |
| LC 332 / 2097 / 753 — itinerary, valid arrangement, safe cracking | Eulerian paths/circuits and de Bruijn construction |
| LC 850 — Rectangle Area II | Geometric sweep + covered-length segment tree |
| LC 1192 — Critical Connections | Low-link bridges |
| LC 1851 / 759 — minimum interval query, employee free time | Offline interval sweep and heap |
| LC 1923 / 1698 / 1062 — common path / distinct substrings | Rolling hash, suffix arrays, LCP and suffix automata |
| LC 2407 — LIS II | Data-structure-optimised LIS DP |
| LC 710 — Random Pick with Blacklist | Already required in HashMap / randomised mapping context |

This is why an ID absent from AlgoFrog is not synonymous with an algorithm absent from the curriculum.

## Production state after the six passes

| Integrity metric | Verified value |
|---|---:|
| Topics | 50 |
| Sidebar-visible topics | 48 |
| Total problem rows | 1,450 |
| Required placements | 1,035 |
| Required rows missing curriculum-path metadata | 0 |
| Duplicate required path positions | 0 |
| Unique LeetCode IDs represented from the dump | 891 |
| Dump IDs remaining by exact match | 2,658 |

All additions were additive. Existing problem IDs and learner progress references were preserved. The SQL migrations are committed under:

- `migrations/20261111_leetcode_dump_gap_expansion.sql`
- `migrations/20261111_leetcode_dump_gap_expansion_pass2.sql`
- `migrations/20261111_leetcode_dump_gap_expansion_pass3.sql`
- `migrations/20261111_leetcode_dump_gap_expansion_pass4.sql`
- `migrations/20261111_leetcode_dump_gap_expansion_pass5.sql`
- `migrations/20261111_leetcode_dump_gap_expansion_pass6.sql`
- `migrations/20261111_leetcode_dump_gap_expansion_pass6_order_fix.sql`

The static marketing count was synchronised to 1,450 problem rows. The deployment workflow is the release evidence for the front end.

## Recommended next review order

1. Retrieve full statements/editorials for the 84 insufficient-evidence records and the 465 metadata-only records.
2. Inspect the 17 rare-tag second-look candidates for genuinely distinct data-structure or proof requirements, not just rare tags.
3. Review the ten remaining advanced-tag candidates individually against statements and solution methods; do not promote a problem because its tag is rare.
4. Keep cross-topic applications as optional transfer practice unless a specific learning-path gap is demonstrated.
5. Continue Java 17 implementation and adversarial-test coverage separately; a curriculum placement is not a verified Java reference solution.

## Audit files

The accompanying workbook is a pre-Pass-6 audit snapshot and therefore still contains the original 2,668-row remaining list; it should not be used as the post-Pass-6 live count. The database state and the production row count above are authoritative.

The accompanying workbook contains:

- **Summary** — coverage, dispositions, source evidence and audit caveats.
- **Remaining Audit** — all 2,668 absent IDs with owner candidates, evidence flags/excerpts, rationale, similar questions and source URL.
- **Added Decisions** — the 63 placement decisions, including required/optional rationale.
- **Tag Analysis** — common tags, rare signals and suggested topic owners.

A CSV companion contains the row-level remaining audit for programmatic review.
