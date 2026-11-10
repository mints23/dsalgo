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
