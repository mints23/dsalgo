# Verified Algorithm Classification Corrections

<badge color="success">Applied to production</badge>

**Status:** Six source-verified corrections were applied to live Supabase problem rows and topic HTML on 2026-11-10. All six stable problem IDs were preserved. No question, progress, playback, or user record was deleted.

| Topic / order | Problem row ID | Previous incorrect classification | Verified identity and actual concept | Production correction applied | Primary source |
|---|---:|---|---|---|---|
| 26 / 5 | 10479 | Count Pairs of Nodes presented as Floyd-Warshall / APSP | LeetCode 1782 is degree-pair counting. Constraints include n≤20,000, m≤100,000 and up to 20 queries. Sort degrees, use two pointers per query, then correct pairs sharing direct edges. | Reclassified as a diagnostic trap in Floyd-Warshall; corrected structured insight and topic HTML. | [LeetCode 1782](https://leetcode.com/problems/count-pairs-of-nodes/); [solution walkthrough](https://leetcodejavascript.com/solutions/count-pairs-of-nodes) |
| 37 / 20 | 10790 | CF 768C — Voting; partisan game / queue strategy | Codeforces 768C is **Jon Snow and his Favourite Number**. Each operation sorts strengths and XOR-updates alternating elements. It is simulation / sorting / bitwise, not game theory. | Corrected title, source identity, concept explanation, and trap role. | [Codeforces 768C](https://codeforces.com/problemset/problem/768/C) |
| 37 / 23 | 10793 | AGC017B described as Grundy-period detection | AtCoder AGC017B asks whether N−1 adjacent signed differences can each have absolute value in [C,D] while summing to B−A. It is mathematical feasibility / greedy interval reasoning, not a game. | Reclassified as a diagnostic trap; corrected concept and bounded-feasibility explanation. | [AtCoder AGC017B](https://atcoder.jp/contests/agc017/tasks/agc017_b?lang=en); [official editorial](https://img.atcoder.jp/agc017/editorial.pdf) |
| 39 / 20 | 10853 | CF 1202D — Print String described as KMP automaton + two tight flags | Codeforces 1202D is **Print a 1337-string**: construct a string over {1,3,7} with exactly n subsequences equal to 1337. It is constructive combinatorics, not digit DP or KMP automaton DP. | Corrected title, constructive concept, and diagnostic role. | [Codeforces 1202D](https://codeforces.com/problemset/problem/1202/D) |
| 43 / 11 | 10929 | CF 11D — A Simple Task described as plug DP / non-crossing connectivity profile | Codeforces 11D counts simple cycles in an undirected graph with n≤19. It is bitmask subset DP over visited vertices and endpoints. | Reclassified as a diagnostic trap in Profile DP; corrected row insight and replaced the incorrect mastery example with CEOI 2006 Connect, the actual plug-DP candidate. | [Codeforces 11D](https://codeforces.com/problemset/problem/11/D) |
| 43 / 15 | 10933 | CF 327E — Axis Walking described as a frontier profile | Codeforces 327E counts permutations of positive step lengths whose prefix sums avoid up to two forbidden coordinates; n≤24 and k≤2 make subset/bitmask DP appropriate. | Added verified identifier, reclassified as a diagnostic trap, and corrected the concept explanation. | [Codeforces 327E](https://codeforces.com/problemset/problem/327/E) |

## Confirmed adjacent classifications

- **CF 768E — Game of Stones** is correctly a game-theory / Sprague-Grundy problem with a per-pile restriction that a removal size cannot be reused. It is distinct from CF 768C. [Official problem](https://codeforces.com/problemset/problem/768/E)
- **CF 850C — Arpa and a Game** is a genuine impartial game / Grundy application; retain in Game Theory.
- **CF 11D** and **CF 327E** are both bitmask DP, but solve different tasks: cycle counting vs valid-permutation counting under forbidden prefix sums.

## Safety and preservation

- All six original problem IDs remain unchanged.
- All six records remain required diagnostic/trap entries; their is_required flags were not changed.
- No rows were deleted or moved between topics in this correction batch.
- User progress and playback records remain attached to the same problem IDs.
- Authentication, subscriptions, payments, and other production flows were untouched.
