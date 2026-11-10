# AlgoFrog Release Log

The small version label in the top-right corner is generated automatically from the GitHub Actions production deployment run number. Every successful deployment receives a unique version.

## v1.0.20 — Progressive concept audit corrections

- Completed first-pass question-by-question concept audits for all 43 topics.
- Added an index and 14 topic audit documents with concept deltas, learning paths, canonical ownership, diagnostic classifications, and mastery-challenge recommendations.
- Corrected six source-verified algorithm misclassifications in live curriculum data while preserving the original problem IDs:
  - LeetCode 1782: degree sorting + two-pointer pair counting, not Floyd-Warshall.
  - Codeforces 768C: sorting + alternating XOR simulation, not Game Theory.
  - AtCoder AGC017B: signed-difference feasibility, not Grundy theory.
  - Codeforces 1202D: constructive 1337-string generation, not Digit DP.
  - Codeforces 11D: subset DP cycle counting, not Profile DP.
  - Codeforces 327E: subset DP over forbidden prefix sums, not Profile DP.
- Reclassified those six rows as required diagnostic traps in their current topics; no problem records were deleted or moved.
- Added canonical AtCoder and Codeforces source links and improved the remigration parser to preserve those identifiers.
- Preserved user progress and playback records. Authentication, subscriptions, and payment flows were not changed.

## v1.0.11 — Visible release version

- Added a compact release identifier in the top-right application bar.
- Production builds display a unique version; local development displays dev.

## v1.0.21 — Topic-relevant trap curation

- Audited all 142 trap/reference rows across the 43 topics.
- Retained 137 topic-relevant diagnostic questions, including method-selection contrasts such as bitmask DP versus frontier Profile DP.
- Removed five unrelated questions from their visible topic paths: Merge Intervals from Kadane, Count Pairs of Nodes from Floyd-Warshall, CF 768C and AGC017B from Game Theory, and CF 1202D from Digit DP.
- Added the explicit `out_of_scope` curriculum role. Excluded rows remain stored with their original problem IDs; progress and playback references are preserved.
- Updated migration and remigration scripts so future data imports preserve the out-of-scope classification.

## v1.0.22 — Cross-topic canonical ownership audit

- Audited live repeated LeetCode placements across all 43 topics: 229 numeric IDs appear in multiple topics (559 placements, 330 additional placements).
- Documented canonical ownership, alternate algorithms, cross-pattern bridges, prerequisite reinforcement, diagnostic traps, and redundant-placement criteria.
- Verified examples include Two Sum, Longest Palindromic Substring, Trapping Rain Water, mutable range sums, Network Delay Time, Word Break, and graph/DP cross-topic placements.
- Flagged five algorithm-label placements for review (LC 2492, 2421, 1584, 282, and 363) without deleting or demoting any row in this pass.
- Refreshed the live same-topic repeat count to 25 topic/problem pairs and 26 additional rows.
- No problem records, user progress, playback, authentication, subscriptions, or payment flows were changed.

## v1.0.23 — Remove trap-category questions from topic paths

- Removed all 165 visible trap-category rows from learner-facing topic question lists across 41 topics. This includes rows marked by the Trap layer and explicit ⚠️ TRAP / partial-trap labels.
- Preserved the 165 corresponding structured problem records with the new `excluded_trap` role and `is_required = false`; no problem rows were deleted.
- Reconciled seven additional explicitly marked rows that remained in authored HTML after the initial identity-based pass. Four HTML-only stale rows in Intervals had no corresponding structured problem record; the remaining three were matched and preserved as excluded records.
- Verified zero trap-category rows remain in the topic HTML question paths.
- Total problem rows remain 1,311; required rows are 1,099. User progress (692 rows) and playback (29 rows) are unchanged.
- Added the `excluded_trap` schema role and updated both migration scripts so excluded rows cannot be marked required if encountered in a future source import.
- No authentication, subscriptions, Razorpay/payment flows, or learner history were changed.
