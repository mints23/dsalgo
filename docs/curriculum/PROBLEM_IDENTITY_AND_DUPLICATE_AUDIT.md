# Problem Identity and Duplicate Placement Audit

**Scope:** Live production `public.problems` inventory across topics 1–43.  
**Status:** Identity audit with subsequent trap-path curation. Trap-category rows are now removed from visible topic HTML and preserved in the database as `excluded_trap`; learner history is retained.

## Summary

- 1,311 problem records remain in production.
- 823 distinct non-empty LeetCode IDs are present.
- 229 numeric LeetCode IDs occur across more than one topic (559 placements; 330 placements beyond the first).
- 25 topic/LeetCode-ID pairs repeat inside the same topic, accounting for 26 extra rows.
- Many same-topic repeats historically included diagnostic trap records. Those trap-category rows have since been removed from learner-facing topic paths; their database records remain for audit and historical progress.
- Repeated IDs should therefore be evaluated by pedagogical role, not removed by a uniqueness constraint.

## Same-topic repeats: interpretation

| Topic | LeetCode ID | Existing placements | Initial interpretation |
|---:|---:|---|---|
| 1 | 454 | 4Sum II; 4Sum II (4 separate arrays) | Canonical + trap / constraint interpretation |
| 2 | 1 | Two Sum; Two Sum (sorted → use 2ptr) | Canonical + wrong-pattern trap |
| 2 | 128 | Longest Consecutive Sequence; Sorting solution | Canonical + alternative/complexity trap |
| 2 | 146 | LRU Cache; LinkedHashMap shortcut | Canonical + implementation shortcut trap |
| 2 | 290 | Word Pattern; One-direction map | Canonical + bijection trap |
| 2 | 560 | Subarray Sum Equals K; Missing map[0]=1 | Canonical + initialization trap |
| 3 | 33 | Search in Rotated Sorted Array; Wrong half check | Canonical + branch-condition trap |
| 3 | 34 | Find First and Last Position; Infinite loop in leftmost | Canonical + boundary trap |
| 3 | 704 | Binary Search; Integer overflow; Off-by-one in loop | Canonical + two implementation traps |
| 3 | 875 | Koko Eating Bananas; Floating point division | Canonical + integer arithmetic trap |
| 6 | 759 | Employee Free Time; Trap Variant | Canonical + interval trap |
| 10 | 952 | Largest Component by Common Factor; Don't sieve per element | Canonical + complexity trap |
| 15 | 215 | Kth Largest Element; QuickSelect variant | Same problem, distinct selection algorithms |
| 15 | 347 | Top K Frequent Elements; bucket sort variant | Same problem, distinct algorithmic approach |
| 22 | 2258 | Escape the Spreading Fire; Off-by-One | Canonical + timing boundary trap |
| 22 | 542 | 01 Matrix; Wrong Source Type | Canonical + multi-source BFS trap |
| 22 | 994 | Rotting Oranges; Wrong Seeding Order | Canonical + BFS initialization trap |
| 23 | 785 | Is Graph Bipartite?; Disconnected Case | Canonical + disconnected graph trap |
| 23 | 886 | Possible Bipartition; Missing Construction | Canonical + modeling trap |
| 24 | 210 | Course Schedule II; Edge Direction | Canonical + graph orientation trap |
| 24 | 269 | Alien Dictionary; Edge Cases | Canonical + invalid-prefix / ordering trap |
| 27 | 787 | Cheapest Flights Within K Stops; Multi-hop in One Pass | Canonical + bounded-relaxation trap |
| 30 | 300 | Longest Increasing Subsequence; LIS O(n log n) | Potential duplicate/revisit; verify whether second placement adds a distinct derivation |
| 31 | 1289 | Minimum Falling Path Sum II; Stage 5 revisit | Intentional revisit likely; verify the new insight is materially different |
| 32 | 2291 | Maximum Profit from Trading Stocks; composite “Maximum Reward / House Robber IV” row | **Data/content defect; see below** |
| 37 | 877 | Stone Game; Stone Game (n even) | Canonical + theorem / shortcut trap |

## Corrected identity defect: Knapsack topic 32, row 26

The authored HTML row previously contained two separate LeetCode links in one problem cell (2291 and 2560), while its learning objective was meet-in-the-middle. The row was corrected in production as one atomic topic-HTML + structured-record change.

It now points to **LeetCode 2035 — Partition Array Into Two Arrays to Minimize Sum Difference**:
- `lc_number = 2035`
- `lc_url = https://leetcode.com/problems/partition-array-into-two-arrays-to-minimize-sum-difference/`
- title and link now identify the same single problem
- sub-variant: meet-in-the-middle with cardinality buckets
- key insight: split the 2n elements, enumerate subset sums grouped by selected count, pair k with n-k, and search for the closest complement

The official constraints have `n ≤ 15` and `nums.length = 2n`, with values as large as ±10^7. This is an exact fit for meet-in-the-middle: sum-indexed knapsack is impractical over the huge/negative sum range, while each half has at most 2^15 subsets. The algorithm groups by cardinality to enforce equal-sized partitions, then sorts and binary-searches the closest complement. See the [official LeetCode statement](https://leetcode.com/problems/partition-array-into-two-arrays-to-minimize-sum-difference/description/).

The next row (topic 32, row 27) remains LeetCode 2560 — House Robber IV, with its separate binary-search/greedy feasibility treatment. The two rows now teach distinct problems and techniques.

## Other identity/data-quality findings

### Advanced Graphs topic 29
- The 15 rows with LeetCode URLs now have verified canonical IDs populated from their problem slugs and checked problem metadata.
- The remaining 5 rows are custom trap explanations without external URLs; these correctly remain without LeetCode IDs.
- The remigration script now carries the verified slug-to-ID mapping so a future structured remigration does not erase these IDs.
- The existing problem titles and key insights are present; this was a structured identity gap, not missing teaching content.

### Curriculum role metadata
A safe, additive classification was applied using explicit layer labels:
- `Foundation` / `Found` → `core_pattern`
- `Variants` → `variant`
- `Combo` / `Combination` → `combination`
- `Trap` / `⚠️ Trap` → historical `excluded_trap` for rows removed from learner paths
- Easy → `optional_reference`
- Hard / Hard-Insight remains unclassified until its specific pedagogical role is reviewed; a difficulty label is not enough to infer optimization or mastery assessment.

Current role counts after this additive classification:
- `core_pattern`: 189
- `variant`: 314
- `combination`: 300
- `trap`: 0 active learner-path rows
- `excluded_trap`: 165 (all non-required; preserved in database)
- `optional_reference`: 51
- `optimization`: 1 (the corrected Knapsack meet-in-the-middle row)
- role pending manual classification: 320

No problem records were deleted. Trap rows are now explicitly non-required and hidden from topic HTML. Existing progress and playback rows remain intact.

### Advanced DP metadata
Topics 38–43 have 145 rows with an empty structured `key_insight`, but their `sub_variant` fields contain detailed explanations and learning progressions. Do not blindly copy these fields into each other. Review the authored HTML and preserve the distinction between the new idea introduced and the concise key insight.

## Recommended remediation order

1. Correct topic 32 row 26 by validating a single canonical problem, then update its HTML row and structured record atomically.
2. Recover canonical LeetCode IDs for topic 29 from verified problem metadata.
3. Review the two non-trap revisit pairs (topic 30 LIS and topic 31 Minimum Falling Path Sum II) for distinct learning value.
4. Use `CROSS_TOPIC_CANONICAL_OWNERSHIP_AUDIT.md` to adjudicate the 229 cross-topic repeated IDs. Assign a primary owner and a distinct learning-contribution label to each secondary placement. Do not delete cross-topic placements merely because IDs repeat.
5. Manually classify the remaining Hard / Hard-Insight curriculum roles.
6. Keep the UI's identity matcher conservative: unmatched rows remain reviewable rather than being hidden or assigned a database ID by row position.

## Safety

This document records findings and remediation decisions. It does not modify problem statements, authored topic HTML, user progress, playback data, authentication, subscriptions, or payment flows.
