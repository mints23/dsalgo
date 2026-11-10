# Verified Algorithm Classification Corrections

**Status:** Source-verified findings from the first-pass curriculum audit.  
**Purpose:** Record problem-identity and algorithm-label mismatches that must be corrected before the corresponding rows are treated as core curriculum questions.

These are not generic recommendations: the official problem statements establish that the current curriculum descriptions do not match the referenced problem IDs.

| Topic / order | Stored curriculum label | Verified problem identity and actual concept | Required curriculum action | Primary source |
|---|---|---|---|---|
| 26 / 5 | Count Pairs of Nodes presented as Floyd-Warshall / APSP | LeetCode 1782 is degree-pair counting. Constraints include n≤20,000, m≤100,000 and up to 20 queries. The intended scalable method sorts degrees, uses two pointers per query, then corrects pairs sharing direct edges. | Reclassify under sorting + two pointers / graph degree counting. Keep only as a diagnostic in Floyd-Warshall. | [LeetCode 1782](https://leetcode.com/problems/count-pairs-of-nodes/); [solution walkthrough](https://leetcodejavascript.com/solutions/count-pairs-of-nodes) |
| 37 / 20 | CF 768C — Voting; partisan game / queue strategy | Codeforces 768C is **Jon Snow and his Favourite Number**. Each operation sorts strengths and XOR-updates alternating elements. It is simulation / sorting / bitwise, not a game-theory problem. | Correct title and source identity. Move out of Game Theory; if retained here, use as a method-selection diagnostic only. | [Codeforces 768C](https://codeforces.com/problemset/problem/768/C) |
| 37 / 23 | AGC017B — Moderate Differences described as Grundy-period detection | AtCoder AGC017B asks whether N−1 adjacent signed differences can each have absolute value in [C,D] while summing to B−A. It is a mathematical feasibility / greedy interval argument, not a game. | Move to math / greedy feasibility. Do not classify as Sprague-Grundy. | [AtCoder AGC017B](https://atcoder.jp/contests/agc017/tasks/agc017_b?lang=en); [official editorial](https://img.atcoder.jp/agc017/editorial.pdf) |
| 39 / 20 | CF 1202D — Print String described as KMP automaton + two tight flags | Codeforces 1202D is **Print a 1337-string**: construct a string over {1,3,7} with exactly n subsequences equal to 1337. It is constructive combinatorics, not digit DP or KMP automaton DP. | Correct title and concept. Move to constructive / combinatorial algorithms; keep as a diagnostic in Digit DP only if teaching range-counting vs construction. | [Codeforces 1202D](https://codeforces.com/problemset/problem/1202/D) |
| 43 / 11 | CF 11D — A Simple Task described as plug DP / non-crossing connectivity profile | Codeforces 11D counts simple cycles in an undirected graph with n≤19. It is a bitmask subset-DP graph problem. | Move to Bitmask DP / Graph DP. Do not classify as broken-profile or plug DP. | [Codeforces 11D](https://codeforces.com/problemset/problem/11/D) |
| 43 / 15 | CF 327E — Axis Walking described as a frontier profile | Codeforces 327E counts permutations of positive step lengths whose prefix sums avoid up to two forbidden coordinates. Constraints n≤24 and k≤2; it is subset/bitmask DP with combinatorial counting, not frontier profile DP. | Move to Bitmask / Combinatorial DP. Keep only as a diagnostic in Profile DP. | [Codeforces 327E](https://codeforces.com/problemset/problem/327/E) |

## Confirmed adjacent classifications

- **CF 768E — Game of Stones** is correctly a game-theory / Sprague-Grundy problem with a per-pile restriction that a removal size cannot be reused. It is distinct from CF 768C. [Problem/editorial discussion](https://codeforces.com/problemset/problem/768/E)
- **CF 850C — Arpa and a Game** is a genuine impartial game / Grundy application; retain in Game Theory.
- **CF 11D** and **CF 327E** are both bitmask DP, but solve different tasks: cycle counting vs counting valid permutations under forbidden prefix sums. They should not be treated as the same concept merely because both use masks.

## Production change policy

Do not delete these records or create uniqueness constraints. Preserve their problem IDs and user progress. When correcting production:
1. Fix the exact title/source and concept explanation in the structured row and topic HTML.
2. Assign a diagnostic/trap role if the row remains in its current topic as a contrast.
3. Add a canonical link to the correct topic rather than duplicating a full solution.
4. Keep progress records attached to the same problem ID.
