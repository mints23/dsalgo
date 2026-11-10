# Progressive Concept Audit — Phase 4A (Topics 30–33)

**Source:** Live production problem rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 30 — 1D Linear DP

**Inventory:** 52 placements; 49 Medium/Hard and 3 Easy/diagnostic references.  
**Verdict:** **The content has strong DP breadth, but it is no longer a coherent 1D-linear topic. It contains knapsack, string DP, state machines, LIS, interval DP, profile DP, tree DP, deque optimization, divide-and-conquer optimization, and convex hull trick. Use it as the DP fundamentals spine and move canonical ownership to specialized topics.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Min Cost Climbing Stairs | Fixed-window recurrence with two predecessors | Core foundation |
| 2 | Maximum Subarray | Kadane reset/extend recurrence | Core contiguous DP |
| 3 | Arithmetic Slices | Count valid subarrays ending at i; sum per-position contributions | Core counting DP |
| 4 | House Robber | Take/skip state with one-position exclusion | Core foundation |
| 5 | House Robber II | Circular constraint decomposed into two linear ranges | Reinforcement |
| 6 | Delete and Earn | Aggregate equal values, then reduce to House Robber | Core input transformation |
| 7 | Coin Change | Unbounded minimum-count recurrence; forward capacity iteration | Move canonical to Knapsack |
| 8 | Coin Change II | Unbounded combination counting; coin-outer loop avoids permutations | Move canonical to Knapsack |
| 9 | Partition Equal Subset Sum | 0/1 boolean reachability; reverse iteration | Move canonical to Knapsack |
| 10 | Word Break | Boolean string partition DP over split points | Move canonical to Strings & Subsequences |
| 11 | Perfect Squares | Unbounded knapsack over generated square values | Move canonical to Knapsack |
| 12 | Decode Ways | Conditional 1- and 2-character parse transitions | Core string parsing DP |
| 13 | Decode Ways II | Wildcard multiplicity and modular case analysis | Advanced string parsing |
| 14 | Unique Binary Search Trees | Catalan product recurrence over independent left/right subtrees | Move canonical to Combinatorial DP / Trees |
| 15 | Maximum Product Subarray | Track max and min because sign flips reverse order | Cross-link Kadane |
| 16 | Maximum Strength of a Group | Dual extrema over non-contiguous subsequences, including start-fresh | Distinct subsequence state |
| 17 | Maximum Subarray Sum with One Deletion | Two-state Kadane with one-way deletion transition | Cross-link Kadane |
| 18 | Paint House | Three color states; exclude same previous color | Move canonical to State Machine DP |
| 19 | Domino and Tromino Tiling | Partial boundary/profile states for protruding tiles | Move canonical to Profile DP |
| 20 | Stock with Cooldown | Held/sold/rest state machine with mandatory cooldown | Move canonical to State Machine DP |
| 21 | Student Attendance Record II | Cartesian product of absence count and late streak states | Move canonical to State Machine DP |
| 22 | Longest Increasing Subsequence O(n²) | Ending-at-i predecessor DP | Move canonical to LIS |
| 23 | Length of Longest Fibonacci Subsequence | Pair-index state and predecessor lookup | Advanced sequence DP |
| 24 | Longest Arithmetic Subsequence | Explicit difference dimension per endpoint | Advanced sequence DP |
| 25 | Longest Common Subsequence | Two-string prefix-pair grid; rolling-array optimization | Move canonical to Strings & Subsequences |
| 26 | Palindromic Substrings | Interval palindrome truth table; length-order traversal | Move canonical to Strings & Subsequences |
| 27 | Longest Palindromic Substring | Reuse palindrome table, change aggregation to longest span | Reinforcement / cross-link |
| 28 | Stock III | Transaction-count × holding state machine | Move canonical to State Machine DP |
| 29 | Wiggle Subsequence | Up/down alternating subsequence states | Greedy/State Machine comparison |
| 30 | Longest String Chain | Sort by length; predecessor deletion creates DAG DP | Move canonical to Strings & Subsequences |
| 31 | Largest Divisible Subset | LIS-style DP under divisibility partial order plus reconstruction | Move canonical to LIS |
| 32 | Maximum Profit in Job Scheduling | Weighted interval DP with binary-searched predecessor | Move canonical to Partition/Interval DP |
| 33 | Palindrome Partitioning II | Precompute palindrome intervals then minimum-cut DP | Move canonical to Strings & Subsequences |
| 34 | Concatenated Words | Word Break per dictionary word | Move canonical to Trie / Strings |
| 35 | Minimum Number of Taps | Interval coverage reduced to Jump Game II | Move canonical to Greedy/Intervals |
| 36 | LIS O(n log n) | Tails invariant and binary-search optimization | Move canonical to LIS |
| 37 | Paint House II | Track two smallest previous states to reduce O(nk²) to O(nk) | Move canonical to State Machine DP |
| 38 | Constrained Subsequence Sum | DP predecessor maximum maintained by monotone deque | Move canonical to Data-Structure-Optimized DP |
| 39 | Maximum Height by Stacking Cuboids | 3D dominance chain after dimension normalization | Move canonical to LIS / sequence DP |
| 40 | Longest Increasing Subsequence II | Value-range maximum query via segment tree | Move canonical to Data-Structure-Optimized DP |
| 41 | CF 311E Strictly Increasing Sequence | Divide-and-conquer DP optimization under monotone opt | Move canonical to Data-Structure-Optimized DP; verify source/title |
| 42 | Minimum Cost Segment Cover (CHT) | Convex Hull Trick transforms a quadratic recurrence into line queries | Move canonical to Data-Structure-Optimized DP; statement/source required |
| 43 | Combination Sum IV | Ordered unbounded counting; loop order changes permutations vs combinations | Move canonical to Knapsack |
| 44 | Minimum Cost for Tickets | Day-indexed DP with 1/7/30-day lookback transitions | Core 1D decision DP |
| 45 | Minimum Difficulty of a Job Schedule | Partition into exactly d contiguous groups with segment maximum cost | Move canonical to Partition DP |
| 46 | Restore the Array | Count valid numeric parses with no-leading-zero and upper-bound constraints | Core parsing DP |
| 47 | Paint House III | Position × color × neighborhood-count state | Move canonical to State Machine DP |
| 48 | Maximum Value of K Coins From Piles | Grouped prefix choices from each pile | Move canonical to Knapsack |
| 49 | Pizza With 3n Slices | Circular non-adjacent selection with exactly n picks | Move canonical to Knapsack / State Machine DP |
| 50 | Climbing Stairs | Fibonacci-like trivial recurrence | Diagnostic/reference; not a core question after #1 |
| 51 | Best Time to Buy and Sell Stock | Running minimum is simpler than DP | Diagnostic trap |
| 52 | Longest Valid Parentheses | Stack is the cleaner canonical approach; DP is alternate | Diagnostic trap / Stack |

### Recommended changes

- Rename this topic **DP Fundamentals & State Design** or keep 1D Linear DP strictly limited to genuinely one-dimensional recurrences.
- The strongest foundational path is #1 → #4 → #6 → #2 → #3, followed by transition types: min-cost, max-value, count, boolean, and state expansion.
- Move all specialized families to their dedicated topics. Keep cross-topic placements as concise transfer challenges, not repeated full problem records.
- #5 is a constraint mutation, not a new recurrence. #6 is a meaningful input transformation.
- #12/#13 and #23/#24 are good examples of additional state/transition complexity; #14 is a different combinatorial product recurrence.
- #41's metadata mentions "Knuth-Yao" while the row title/description says D&C optimization; verify the exact recurrence and optimization condition. These are not interchangeable labels.
- #42 needs a complete statement and source; CHT requires line-slope/query-order conditions to justify a monotone deque hull.
- #50–52 should be diagnostics only.
- Final capstone should require deriving state, transition, base case, iteration order, and a valid space optimization for a previously unseen recurrence.

---

## Topic 31 — 2D Grid DP

**Inventory:** 31 placements; 29 Medium/Hard and 2 Easy/diagnostic references.  
**Verdict:** **Strong grid DP progression with geometric, multi-agent, and constrained-state extensions. Several rows are not grid DP and should be moved or kept as diagnostics.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Unique Paths | Count paths from top/left predecessors | Core foundation |
| 2 | Minimum Path Sum | Replace path count with min-plus cost accumulation | Core objective mutation |
| 3 | Unique Paths II | Obstacles zero out states; first-row/column propagation changes | Core constraint mutation |
| 4 | Triangle | Jagged grid and bottom-up in-place reduction | Core shape mutation |
| 5 | Minimum Falling Path Sum | Free start column; aggregate minimum over final row | Core boundary change |
| 6 | Dungeon Game | Reverse DP for minimum required health; clamp to at least one | Core reverse-state insight |
| 7 | Maximal Square | Three-way min encodes square geometry | Core geometric DP |
| 8 | Minimum Falling Path Sum II | Exclude same column; min1/min2 optimization | Core optimization |
| 9 | Maximum Non-Negative Product in a Matrix | Track min and max product per cell due sign flips | Core dual-state extension |
| 10 | Out of Boundary Paths | Add move count as a third DP dimension | Core state expansion |
| 11 | Number of Ways of Cutting a Pizza | 3D piece-count DP plus 2D prefix sums for O(1) cut validation | Advanced integration |
| 12 | Paths in Matrix Whose Sum Is Divisible by K | Add running-sum residue as state dimension | Core modular constraint |
| 13 | Number of Paths with Max Score | Track (best score, number of ways) and add counts on ties | Core paired-value state |
| 14 | Minimum Path Cost in a Grid | Transition cost depends on current cell value and next column | Core nonuniform transition |
| 15 | Cherry Pickup II | Two agents share row; 3D state and collision deduplication | Advanced multi-agent DP |
| 16 | Cherry Pickup | Synchronize forward and return walks; reduce 4D to 3D using equal step count | Advanced state reduction |
| 17 | Count Fertile Pyramids in a Land | Geometric pyramid height DP in two directions | Advanced shape DP |
| 18 | Execution of All Suffix Instructions | Simulation over suffixes; no useful grid DP state | Diagnostic trap |
| 19 | Longest Increasing Path in a Matrix | Data-dependent DAG; DFS memoization or topo DP | Cross-link DAG DP |
| 20 | Max Sum Rectangle No Larger Than K | Compress row pairs to 1D constrained max-subarray with ordered set | Advanced 2D-to-1D reduction |
| 21 | Maximal Rectangle | Row histogram + monotone stack | Cross-link Monotonic Stack |
| 22 | Minimum Falling Path Sum II (revisit) | min1/min2 row optimization | Duplicate reinforcement of #8; merge or make an explicit optimization drill |
| 23 | Tallest Billboard | Difference between two accumulated heights is the state | Move canonical to Knapsack |
| 24 | CF 559C Gerald's Hexagon | Coordinate-compressed irregular geometry and grid/path counting | Advanced custom; verify statement/source |
| 25 | USACO Painting the Barn | 2D difference array for rectangle updates followed by DP | Advanced integration; statement/source required |
| 26 | Minimum Cost to Convert String I | Character APSP preprocessing followed by position DP | Move canonical to Strings / Graph APSP |
| 27 | Maximum Cherries with Exactly K Robots | Generalize two-agent state to K agents; state explosion and symmetry | Advanced custom; correctness/source required |
| 28 | Count Square Submatrices with All Ones | Largest square side at each cell contributes all smaller squares | Core counting interpretation |
| 29 | 01 Matrix | Multi-source BFS is the canonical nearest-source distance transform | Diagnostic trap / BFS |
| 30 | Max Area of Island | Irregular connected component requires flood fill | Diagnostic trap / DFS |
| 31 | Shortest Path in Binary Matrix | 8-direction movement has no simple row/column topological DP order; BFS is canonical | Diagnostic trap / BFS |

### Recommended changes

- #1 → #2 → #3 → #4 → #5 → #6 is a strong path through path counting, optimization, obstacles, shape, and reverse-state reasoning.
- #7 → #8 → #9 introduces geometric constraints, optimized predecessor selection, and dual extrema.
- #10–16 form an advanced state expansion path: steps, residues, paired outputs, transition costs, two agents, and synchronized agents.
- #22 duplicates #8 with the same LeetCode ID; retain one canonical problem and make the second a min1/min2 implementation checkpoint only.
- #23 belongs to Knapsack; #19 to DAG DP; #20 to Prefix/Ordered Structures; #21 to Monotonic Stack; #26 to graph + string DP.
- #29–31 are good diagnostics for choosing BFS/DFS over grid DP.
- #24, #25, and #27 require complete statement/source and complexity validation.
- Final capstone should combine multiple agents, a nontrivial constraint dimension, and a state reduction that avoids a naïve 4D/5D table.

---

## Topic 32 — The Knapsack Family

**Inventory:** 32 placements; 30 Medium/Hard and 2 Medium trap/review rows.  
**Verdict:** **One of the strongest progressive topics. It covers 0/1, unbounded, ordered/unordered counting, bounded/grouped, multidimensional, bitset, meet-in-the-middle, and pattern-selection traps. Some entries are not knapsack and should be diagnostic.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Partition Equal Subset Sum | 0/1 boolean subset sum; reverse iteration | Core 0/1 foundation |
| 2 | Coin Change | Unbounded min-count; forward iteration | Core unbounded foundation |
| 3 | Coin Change II | Count unordered combinations; coin outer loop | Core count semantics |
| 4 | Perfect Squares | Generate implicit coin set then reuse unbounded min DP | Reinforcement |
| 5 | Combination Sum IV | Count ordered permutations; capacity outer loop | Core loop-order contrast |
| 6 | Count Number of Texts | Small bounded run-length recurrence | Adjacent string DP; not classical knapsack |
| 7 | Target Sum | Transform sign assignments to subset count | Core algebraic reduction |
| 8 | Last Stone Weight II | Maximize achievable sum ≤ half for minimum residual difference | Core objective mutation |
| 9 | Ways to Express Integer as Sum of Powers | Implicit 0/1 item generation with power values | Core item-generation extension |
| 10 | Ones and Zeroes | Two capacity dimensions; reverse both axes | Core multidimensional extension |
| 11 | Profitable Schemes | Three-dimensional DP with capped profit state | Advanced state cap |
| 12 | Number of Ways to Earn Points | Bounded/grouped choices with per-type count limit | Core bounded knapsack |
| 13 | Number of Dice Rolls with Target Sum | Exactly one choice from each group | Core grouped-choice semantics |
| 14 | Number of Great Partitions | Complement counting to reuse subset-sum DP | Advanced counting reduction |
| 15 | Tallest Billboard | Difference state for two subset sums | Advanced state transformation |
| 16 | Maximum Profit from Trading Stocks (LC 2291) | Budget-constrained 0/1 selection with stock values | Core 0/1 application; ensure no title/logic ambiguity |
| 17 | Length of Longest Subsequence That Sums to Target | Maximize number of selected items at exact sum | Core objective mutation |
| 18 | Minimum Cost to Cut a Stick | Interval DP, not linear knapsack | Diagnostic trap |
| 19 | Form Largest Integer With Digits That Add Up to Target | Unbounded DP with lexicographic output objective | Advanced unbounded objective |
| 20 | Maximize Total Tastiness of Purchased Fruits | Budget plus coupon/discount state | Advanced extra-capacity dimension |
| 21 | Count of Sub-Multisets with Bounded Sum | Frequency-compressed bounded knapsack with sliding-window optimization | Advanced optimization |
| 22 | Find Sum of Power of All Subsequences | Weighted subset counting; fold length-dependent multiplicity into recurrence | Advanced combinatorial weighting |
| 23 | K Divisible Elements Subarrays | Distinct-subarray counting requires hashing/trie, not knapsack | Diagnostic trap |
| 24 | Minimize Difference Between Target and Chosen Elements | Grouped row-choice knapsack with bitset reachability | Advanced grouped bitset |
| 25 | Count Pairs of Points With Distance k | XOR enumeration + HashMap, not 2D knapsack | Diagnostic trap |
| 26 | Partition Array Into Two Arrays to Minimize Sum Difference | Meet-in-the-middle with cardinality buckets and sorted complement search | Advanced alternative when sum range is huge |
| 27 | House Robber IV | Binary search on capability with greedy feasibility; not knapsack | Diagnostic trap |
| 28 | EDPC F — LCS (bounded knapsack perspective) | Claimed character-frequency knapsack reformulation of LCS | Review exact statement/reduction; likely misplaced |
| 29 | Closest Achievable Subset Sum (custom) | Bitset subset-sum and nearest reachable value scan | Advanced custom; full statement/source required |
| 30 | Painting the Walls | Paid/free painter resource interpretation as 0/1 knapsack | Advanced disguised knapsack |
| 31 | Combination Sum | Enumeration of all valid combinations requires backtracking, not only DP counts | Diagnostic trap |
| 32 | Two Best Non-Overlapping Events | Sort + binary-search/DP over compatible intervals, not 2D knapsack | Diagnostic trap |

### Recommended changes

- This topic has a strong progression and should be retained as one of AlgoFrog's flagship concept ladders.
- Make the main sequence explicit: 0/1 boolean (#1) → unbounded min (#2) → unordered count (#3) → ordered count (#5) → bounded/grouped (#12/#13) → multi-capacity (#10) → extra state (#11/#15) → bitset (#24/#29) → meet-in-the-middle (#26).
- #4 is reinforcement of #2, not a new concept. #7 and #8 should explain the algebraic reduction and objective change.
- #6 is a bounded local string recurrence; keep as a cross-link rather than knapsack core.
- #18, #23, #25, #27, #31, and #32 are useful pattern-selection traps.
- #28 requires validation; LCS is not generally a bounded-knapsack reformulation just because character frequencies are bounded.
- The corrected LC 2035 entry at #26 is a genuine meet-in-the-middle lesson and should remain separate from LC 2560 at #27.
- Final capstone should make learners choose among 0/1, unbounded, bounded, grouped, bitset, meet-in-the-middle, or non-knapsack alternatives from constraints and output semantics.

---

## Topic 33 — Strings & Subsequences

**Inventory:** 32 placements; 30 Medium/Hard and 2 diagnostic traps.  
**Verdict:** **A strong progression through two-string DP, contiguity, weighted edit operations, subsequence counting, reconstruction, wildcard/regex matching, and interval palindromes. It overlaps with KMP, Trie, Interval DP, and 1D DP and needs clear ownership.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Longest Common Subsequence | Two-string prefix-pair DP baseline | Core foundation |
| 2 | Edit Distance | Insert/delete/replace transitions | Core progression |
| 3 | Maximum Length of Repeated Subarray | Contiguity forces reset on mismatch; answer over all cells | Core contrast with LCS |
| 4 | Longest Palindromic Subsequence | Reduce to LCS with reversed string | Core transformation |
| 5 | Minimum ASCII Delete Sum | Weighted delete transitions instead of unit costs | Core weighted edit |
| 6 | Delete Operation for Two Strings | Derive minimum deletions from LCS length | Reinforcement / answer transformation |
| 7 | Is Subsequence | Two-pointer scan is simpler than 2D DP | Easy method-selection reference |
| 8 | Distinct Subsequences | Count matching and skipping branches; avoid duplicate count loss | Core counting extension |
| 9 | Shortest Common Supersequence | Reconstruct output by walking the LCS table | Core reconstruction |
| 10 | Interleaving String | Boolean two-source DP into one target | Core source-choice state |
| 11 | Regular Expression Matching | Pattern '*' consumes zero or repeated previous token | Core pattern semantics |
| 12 | Wildcard Matching | Standalone '*' matches any sequence; different transition from regex | Core semantic contrast |
| 13 | Max Dot Product of Two Subsequences | Non-empty pair requirement; negative infinity base and start-fresh transition | Advanced objective constraint |
| 14 | Longest Repeating Substring | LCS(s,s) with i≠j guard | Core reduction; verify scalability under constraints |
| 15 | Minimum Insertion Steps to Make a String Palindrome | Reduce to n − LPS | Reinforcement |
| 16 | Palindromic Substrings | Interval DP by increasing substring length | Move canonical to Interval DP |
| 17 | Longest Palindromic Substring | Reuse palindrome table, change aggregation to maximum span | Reinforcement; cross-link Advanced Strings |
| 18 | Palindrome Partitioning II | Palindrome precomputation plus minimum-cut DP | Advanced interval/partition integration |
| 19 | Count Different Palindromic Subsequences | Interval DP with four duplicate-boundary cases | Advanced core |
| 20 | Maximize Palindrome Length from Subsequences | Combine two source strings with LCS and palindrome constraint | Advanced integration |
| 21 | Number of Ways to Form Target String Given Dictionary | Column-frequency preprocessing plus subsequence count DP | Advanced input transformation |
| 22 | Selling Pieces of Wood | 2D interval splitting in both dimensions | Move canonical to Interval DP |
| 23 | Distinct Subsequences II | Per-character suffix-state DP with subtraction to deduplicate | Advanced counting |
| 24 | Stream of Characters | Aho-Corasick automaton, not string DP | Diagnostic trap / Trie |
| 25 | Extra Characters in a String | Trie-guided word-break partition DP | Integration with Trie |
| 26 | Valid Palindrome III | LPS / minimum deletions under budget k | Advanced constraint variant |
| 27 | Scramble String | 3D interval DP over two starts and length | Advanced interval DP |
| 28 | EDPC F — LCS O(n log n) | Reduce LCS to LIS over mapped positions with reverse tie order | Advanced algorithmic reduction; verify assumptions |
| 29 | Longest Common Subsequence of K Strings (custom) | Generalize to k-dimensional state and expose exponential dimension growth | Custom theory exercise; statement/source required |
| 30 | Freedom Trail | Position × key-index DP with circular transition costs | Advanced state-space DP |
| 31 | Longest Duplicate Substring | Binary search + rolling hash/suffix structures, not LCS DP | Diagnostic trap |
| 32 | Shortest Palindrome | KMP failure function finds longest palindromic prefix | Diagnostic trap / KMP |

### Recommended changes

- #1 → #2 → #3 → #4 → #5 → #8 → #9 is a strong string-DP progression: common subsequence, edit costs, contiguous matching, palindrome transform, weighted cost, counting, reconstruction.
- Distinguish LCS, longest common substring, subsequence counting, and edit-distance DP as separate transition families.
- #11 and #12 are a valuable semantic comparison: regex star is attached to the preceding token; wildcard star is independent.
- #16–19 and #22/#27 belong primarily to Interval DP; use cross-links rather than duplicate full solutions.
- #24 and #32 are automata/KMP; #25 is Trie + DP; #31 is rolling hash/suffix-array selection.
- #28 is an advanced reduction; document the exact conditions that make LCS-to-LIS valid and how duplicate positions are ordered.
- #29 needs full statement/source and complexity analysis; k-dimensional DP becomes infeasible quickly.
- #14 needs a complexity review: LCS of a string with itself is not automatically the best longest-duplicate-substring algorithm at large n.
- Final capstone should ask learners to select between LCS, substring DP, edit distance, interval palindrome DP, KMP, trie, and rolling hash based on contiguity, pattern-known/unknown, and reconstruction/counting requirements.

---

## Status

Topics 01–33 have now received progressive concept-delta reviews. Topics 34–43 remain. No production curriculum rows have been modified.
