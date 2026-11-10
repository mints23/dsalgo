# Problem Identity and Duplicate Placement Audit

**Scope:** Live production `public.problems` inventory across topics 1–43.  
**Status:** Diagnostic audit only. No problem rows or topic HTML were deleted or rewritten as part of this audit.

## Summary

- 1,311 problem records remain in production.
- 823 distinct non-empty LeetCode IDs are present.
- 234 LeetCode IDs occur in more than one placement across the curriculum.
- 26 topic/LeetCode-ID pairs have repeated placements inside the same topic, accounting for 27 extra rows.
- Most same-topic repeats are deliberate trap records: a canonical problem is followed by a row explaining a wrong invariant, edge case, or implementation failure.
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

## Confirmed identity defect: Knapsack topic 32, row 26

The authored HTML row contains two separate LeetCode links in one problem cell:

- LeetCode 2291 — Maximum Profit from Trading Stocks
- LeetCode 2560 — House Robber IV

The structured database row currently stores:
- `lc_number = 2291`
- `lc_url = https://leetcode.com/problems/maximum-profit-from-trading-stocks/`
- title: `Maximum Reward (revisit) / 2560 – House Robber IV`
- sub-variant: `Meet-in-the-middle on subset sum`
- key insight: meet-in-the-middle for small n and huge capacity

The next row (topic 32, row 27) separately stores LeetCode 2560 with the correct House Robber IV title and a binary-search/greedy feasibility treatment.

This is not a safe candidate for automatic deduplication. The row 26 title, links, and teaching objective disagree. The meet-in-the-middle lesson should be paired with a verified problem that actually exercises that technique (a candidate is LeetCode 2035, but its statement and constraints must be checked before changing the source). Keep the current row intact until the replacement is validated, then update the authored HTML and structured row together.

## Other identity/data-quality findings

### Advanced Graphs topic 29
- 20 rows have no `lc_number`.
- 15 of those rows have LeetCode URLs, so the canonical IDs can be recovered from verified source metadata.
- 5 rows are custom trap explanations without external URLs.
- The existing problem titles and key insights are present; this is a structured identity gap, not evidence of missing teaching content.

### Curriculum role metadata
A safe, additive classification was applied using explicit layer labels:
- `Foundation` / `Found` → `core_pattern`
- `Variants` → `variant`
- `Combo` / `Combination` → `combination`
- `Trap` / `⚠️ Trap` → `trap`
- Easy → `optional_reference`
- Hard / Hard-Insight remains unclassified until its specific pedagogical role is reviewed; a difficulty label is not enough to infer optimization or mastery assessment.

Current role counts after this additive classification:
- `core_pattern`: 189
- `variant`: 314
- `combination`: 300
- `trap`: 136 (111 currently required by difficulty)
- `optional_reference`: 51
- role pending manual classification: 321

No records were deleted. Existing `is_required` values were not changed by this role normalization.

### Advanced DP metadata
Topics 38–43 have 145 rows with an empty structured `key_insight`, but their `sub_variant` fields contain detailed explanations and learning progressions. Do not blindly copy these fields into each other. Review the authored HTML and preserve the distinction between the new idea introduced and the concise key insight.

## Recommended remediation order

1. Correct topic 32 row 26 by validating a single canonical problem, then update its HTML row and structured record atomically.
2. Recover canonical LeetCode IDs for topic 29 from verified problem metadata.
3. Review the two non-trap revisit pairs (topic 30 LIS and topic 31 Minimum Falling Path Sum II) for distinct learning value.
4. Review all 234 cross-topic repeated IDs and assign a primary, cross-pattern, revisit, or trap rationale. Do not delete cross-topic placements merely because IDs repeat.
5. Manually classify the remaining Hard / Hard-Insight curriculum roles.
6. Keep the UI's identity matcher conservative: unmatched rows remain reviewable rather than being hidden or assigned a database ID by row position.

## Safety

This document records findings and remediation decisions. It does not modify problem statements, authored topic HTML, user progress, playback data, authentication, subscriptions, or payment flows.
