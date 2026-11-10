# Verified Algorithm Classification Corrections

<badge color="success">Applied to production</badge>

**Status:** Six source-verified classification mismatches were corrected on 2026-11-10. Four unrelated rows were excluded from their incorrect topic paths; two were retained as explicit diagnostic contrasts. All six stable problem IDs were preserved. No question, progress, playback, or user record was deleted.

| Topic / order | Problem row ID | Previous incorrect classification | Verified identity and actual concept | Production correction applied | Primary source |
|---|---:|---|---|---|---|
| 26 / 5 | 10479 | Count Pairs of Nodes presented as Floyd-Warshall / APSP | LeetCode 1782 is degree-pair counting. Sort degrees, use two pointers per query, then correct pairs sharing direct edges. | **Removed from Topic 26 as out of scope**; original row is retained as archived metadata and no longer appears in the topic HTML. | [LeetCode 1782](https://leetcode.com/problems/count-pairs-of-nodes/); [solution walkthrough](https://leetcodejavascript.com/solutions/count-pairs-of-nodes) |
| 37 / 20 | 10790 | CF 768C — Voting; partisan game / queue strategy | Codeforces 768C is **Jon Snow and his Favourite Number**. Each operation sorts strengths and XOR-updates alternating elements. | **Removed from Topic 37 as out of scope**; original row is retained as archived metadata. | [Codeforces 768C](https://codeforces.com/problemset/problem/768/C) |
| 37 / 23 | 10793 | AGC017B described as Grundy-period detection | AtCoder AGC017B asks whether N−1 adjacent signed differences can each have absolute value in [C,D] while summing to B−A. | **Removed from Topic 37 as out of scope**; original row is retained as archived metadata. | [AtCoder AGC017B](https://atcoder.jp/contests/agc017/tasks/agc017_b?lang=en); [official editorial](https://img.atcoder.jp/agc017/editorial.pdf) |
| 39 / 20 | 10853 | CF 1202D — Print String described as KMP automaton + two tight flags | Codeforces 1202D is **Print a 1337-string**: construct a string over {1,3,7} with exactly n subsequences equal to 1337. | **Removed from Topic 39 as out of scope**; original row is retained as archived metadata. | [Codeforces 1202D](https://codeforces.com/problemset/problem/1202/D) |
| 43 / 11 | 10929 | CF 11D — A Simple Task described as plug DP / non-crossing connectivity profile | Codeforces 11D counts simple cycles in an undirected graph with n≤19. It is bitmask subset DP over visited vertices and endpoints. | Historical diagnostic row; now excluded from the learner-facing path as `excluded_trap`. Corrected concept/source metadata retained. | [Codeforces 11D](https://codeforces.com/problemset/problem/11/D) |
| 43 / 15 | 10933 | CF 327E — Axis Walking described as a frontier profile | Codeforces 327E counts permutations of positive step lengths whose prefix sums avoid up to two forbidden coordinates; n≤24 and k≤2 make subset/bitmask DP appropriate. | Historical diagnostic row; now excluded from the learner-facing path as `excluded_trap`. Corrected source identity and concept explanation retained. | [Codeforces 327E](https://codeforces.com/problemset/problem/327/E) |

## Confirmed adjacent classifications

- **CF 768E — Game of Stones** is correctly a game-theory / Sprague-Grundy problem with a per-pile restriction that a removal size cannot be reused. It is distinct from CF 768C. [Official problem](https://codeforces.com/problemset/problem/768/E)
- **CF 850C — Arpa and a Game** is a genuine impartial game / Grundy application; retain in Game Theory.
- **CF 11D** and **CF 327E** are both bitmask DP, but solve different tasks: cycle counting vs valid-permutation counting under forbidden prefix sums.

## Safety and preservation

- All six original problem IDs remain unchanged.
- The AtCoder AGC017B and Codeforces 327E source URLs are now stored in lc_url and linked in topic HTML. The remigration parser now preserves canonical Codeforces IDs and extracts AtCoder contest IDs such as AGC017B.
- Four out-of-topic records are now `out_of_scope` and `is_required=false`; their rows remain in the database for historical references.
- CF 11D and CF 327E remain preserved in storage as `excluded_trap` records; their diagnostic explanations are not part of the learner-facing Profile DP problem path.
- No problem rows were deleted or reassigned to a different topic. The four out-of-scope rows were removed from their topic HTML and marked `out_of_scope` in structured metadata.
- A separate Kadane audit removed Merge Intervals from Topic 05; its canonical question remains in Topic 06 (Intervals).
- User progress and playback records remain attached to the same problem IDs.
- Authentication, subscriptions, payments, and other production flows were untouched.
