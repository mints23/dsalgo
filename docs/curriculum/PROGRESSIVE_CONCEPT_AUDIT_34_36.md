# Progressive Concept Audit — Phase 4B (Topics 34–36)

**Source:** Live production problem rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 34 — State Machine DP

**Inventory:** 29 placements; 26 Medium/Hard and 3 diagnostic traps/references.  
**Verdict:** **A strong central topic for designing states as modes, resources, and invariants. It starts with stock transitions but later broadens to parity, bitmask, and general finite-state DP. Clarify what actually qualifies as a state machine.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Best Time to Buy and Sell Stock | Two states: holding vs not holding; at most one transaction | Easy reference / prerequisite |
| 2 | Best Time to Buy and Sell Stock II | Unlimited transactions; holding can transition from prior rest profit | Core foundation |
| 3 | Stock with Transaction Fee | Same states; fee changes sell transition only | Core progression |
| 4 | Stock with Cooldown | Add cooldown/rest state; buying source is restricted | Core state expansion |
| 5 | Stock III | Bound transactions to two; explicit transaction-count state | Core progression |
| 6 | Stock IV | Generalize transaction count to k and detect unlimited-equivalent case | Core generalization |
| 7 | At Most K Transactions with Cooldown (custom) | Compose transaction-count and cooldown dimensions | Advanced custom capstone; full statement required |
| 8 | Maximum Number of Jumps to Reach Last Index | Value-range-constrained predecessor DP; not a stock state machine | Cross-link DP |
| 9 | Maximum Alternating Subsequence Sum | Two parity/alternation states with symmetric transitions | Core state-machine transfer |
| 10 | Maximum Length of Subarray With Positive Product | Sign states (positive/negative/zero) replace buy/sell modes | Core state abstraction |
| 11 | Maximum Subarray Sum with One Deletion | Irreversible deletion-budget state | Cross-link Kadane |
| 12 | Wiggle Subsequence | Last direction up/down controls allowed transition | Core conditional state |
| 13 | Number of Ways to Select Buildings | Three-stage subsequence counter for 010/101 patterns | Core sequence-state counting |
| 14 | Get Maximum Score | Two path states synchronize at shared values; choose best accumulated path | Integration with Two Pointers |
| 15 | Find Score of All Prefixes | Running maximum is a degenerate one-state machine | Reference / state simplification |
| 16 | Best Team With No Conflicts | Age-sorted predecessor DP with last-score state; LIS-like | Cross-link LIS |
| 17 | Score of Students Solving Math Expression | Bitmask of possible expression values under alternate parenthesization | Advanced state-set DP |
| 18 | Number of Ways to Stay in the Same Place | Step × position state with reachability bound and rolling array | Core constrained state |
| 19 | Visit Array Positions to Maximize Score | Parity of last visited value and switching penalty | Core resource/mode state |
| 20 | Paths in Matrix Whose Sum Is Divisible by K | Residue is a sufficient state dimension | Cross-link Grid DP |
| 21 | Number of Ways to Wear Different Hats | Bitmask of assigned people; process hats as sequential decisions | Advanced bitmask state |
| 22 | EDPC Sushi | Expected-value DP over counts of plates with 1/2/3 pieces | Advanced probability-state DP |
| 23 | CF 833B — The Bakery | Partition DP accelerated by segment tree range maximum | Cross-link Partition + Data-Structure-Optimized DP |
| 24 | Smallest Sufficient Team | Bitmask coverage state with parent reconstruction | Cross-link Combinatorial DP |
| 25 | Maximize Score After N Operations | Bitmask of used numbers and operation index derived from bit count | Cross-link Bitmask DP |
| 26 | Maximum Subarray | Kadane is simpler than a general state machine | Diagnostic trap |
| 27 | House Robber | Two-step recurrence is simpler than named modes | Diagnostic trap |
| 28 | Maximum Building Height | Greedy interval propagation / triangle inequality, not state DP | Diagnostic trap |
| 29 | Knight Dialer | Finite-state transition matrix; matrix exponentiation for huge length | Advanced state-machine extension |

### Recommended changes

- Make stock DP the canonical ladder: #1 → #2 → #3 → #4 → #5 → #6 → #7.
- Require each problem to define state meaning, legal transitions, initialization, terminal answer, and whether state dimensions represent time, resource budget, or mode.
- #8, #11, #14, #16, #20, #23–25 are useful integrations but have canonical homes elsewhere.
- #9/#12 are a strong contrast: forced alternation versus value-dependent direction.
- #10 is a good abstraction transfer from stock modes to sign states.
- #17 and #21–25 are state-set / bitmask DP and should be clearly separated from small finite-mode machines.
- #22 belongs to expected-value DP; #29 introduces matrix exponentiation over a finite state transition.
- #26–28 are method-selection traps.
- Final capstone should combine transaction count, cooldown, and fee, then ask learners to minimize state dimensions and prove transition order correctness.

---

## Topic 35 — Interval DP

**Inventory:** 28 placements; 26 Medium/Hard and 2 diagnostic traps.  
**Verdict:** **A strong classic-to-advanced progression. The key learning delta is how to define interval boundaries, choose a split or endpoint, and decide whether subproblems share endpoints or are disjoint.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Longest Palindromic Subsequence | Shrink-from-ends interval recurrence | Core foundation |
| 2 | Minimum Insertion Steps to Make String Palindrome | Same interval state, change objective to minimum edit cost | Core progression |
| 3 | Palindromic Substrings | Reuse palindrome truth table and count valid intervals | Core aggregation change |
| 4 | Minimum Cost to Merge N Piles into 1 (K=2, custom) | Split-point interval DP with prefix-sum merge cost | Core split template; statement required |
| 5 | Minimum Score Triangulation of Polygon | Third vertex split; child intervals share parent endpoints | Core split semantics |
| 6 | Guess Number Higher or Lower II | Minimax: choose guess minimizing worst remaining interval cost | Core adversarial recurrence |
| 7 | Scramble String | Two-string interval state with aligned or crossed split | Advanced 3D interval state |
| 8 | Predict the Winner | Score difference compresses both players' optimality into one value | Core game-DP integration |
| 9 | Stone Game | Use interval DP to prove a structural winner guarantee | Reinforcement / theorem derivation |
| 10 | Strange Printer | Merge equal-character turns across a split | Advanced non-obvious transition |
| 11 | Burst Balloons | Reverse action order: choose the last balloon to burst so boundaries are fixed | Core transformation |
| 12 | Minimum Cost to Merge Stones | K-way merge feasibility and interval-length congruence | Advanced split constraint |
| 13 | Minimum Cost to Cut a Stick | Sort cut coordinates and use interval endpoints as fixed boundaries | Core real-world reduction |
| 14 | Remove Boxes | Add third dimension for equal boxes attached to boundary | Advanced state expansion |
| 15 | Encode String with Shortest Length | Compete split encoding vs periodic compression; KMP detects repetition | Advanced string integration |
| 16 | Palindrome Removal | Match equal endpoints to combine an inner solution with a later removal | Advanced recurrence composition |
| 17 | Split Array Largest Sum | Contiguous partition DP with min-of-max objective | Move canonical to Partition DP |
| 18 | Allocate Mailboxes | Partition DP with median-based segment cost and prefix sums | Move canonical to Partition DP |
| 19 | Maximum Score from Performing Multiplication Operations | Two-boundary extension DP: take from left or right | Core alternative to split-point recurrence |
| 20 | Number of Music Playlists | Count sequences by length and number of distinct items; not true interval DP | Diagnostic / combinatorial DP |
| 21 | Expression Add Operators | Track evaluated value and last multiplicative term to preserve precedence | Move canonical to Backtracking / Expression DP |
| 22 | CF 149D — Coloring Brackets | Matching bracket structure creates nested intervals with boundary colors | Advanced custom; source/statement required |
| 23 | Valid Parenthesis String (DP variant) | Boolean interval feasibility with wildcard character | Core boolean interval variant |
| 24 | EDPC N — Slimes | Merge cost plus Knuth optimization under quadrangle inequality | Advanced optimization |
| 25 | Count Different Palindromic Subsequences | Four boundary-character cases with duplicate handling and modular arithmetic | Advanced core |
| 26 | Longest Palindromic Substring | Manacher is linear and simpler for longest substring objective | Diagnostic trap |
| 27 | Minimum Cost Tree From Leaf Values | Monotone-stack greedy beats cubic interval DP | Diagnostic trap |
| 28 | Palindrome Partitioning II | Palindrome precompute is interval DP, but min cuts is 1D DP | Diagnostic trap / partition DP |

### Recommended changes

- #1–6 form a strong sequence: shrink endpoints → cost variant → count variant → split point → shared-boundary split → minimax.
- #11 is a crucial conceptual lesson: selecting the last operation can make an otherwise order-dependent process decomposable.
- #14 should follow #11 because it adds a boundary-attached count dimension.
- #15 is a strong integration of interval DP and KMP; explicitly explain the periodicity test.
- #17/#18 belong canonically to Partition DP; #21 to Backtracking; #20 to Combinatorial DP.
- #24 must prove the quadrangle inequality and monotone-opt bounds; Knuth optimization is not a generic interval-DP speedup.
- #26/#27/#28 are good diagnostics: choose Manacher, monotone-stack greedy, or 1D partition DP when those are superior.
- Custom #4 and #22 require exact statement/source and proof.
- Final capstone should combine a split-point recurrence, nontrivial boundary condition, and optimization proof, while asking learners to distinguish interval DP from partition DP.

---

## Topic 36 — Partition DP

**Inventory:** 26 placements; all Medium/Hard.  
**Verdict:** **Strong coherent topic. It builds from feasibility/count/min-cost partitions to segment cost functions, multidimensional constraints, optimized transitions, and reconstruction.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Word Break | Boolean feasibility over last segment boundary | Core foundation |
| 2 | Decode Ways | Count valid partitions instead of boolean feasibility | Core objective mutation |
| 3 | Extra Characters in a String | Minimize unmatched cost while choosing dictionary segments | Core min-cost mutation |
| 4 | Palindrome Partitioning II | Min cuts with precomputed palindrome segment validity | Core constrained partition |
| 5 | Partition String into Substrings with Values at Most K | Segment validity depends on numeric value, leading zero, and overflow | Core constraint extension |
| 6 | Palindrome Partitioning III | Exactly k groups with a precomputed edit cost per segment | Core exact-group extension |
| 7 | Partition Array for Maximum Sum | Segment score depends on segment maximum and length | Core segment-cost function |
| 8 | Minimum Cost to Split Array | Segment cost depends on duplicate-frequency penalties | Core non-additive segment cost |
| 9 | Plates Between Candles (as DP) | Prefix-sum segment queries inside a partition recurrence | Diagnostic/reference; likely simpler prefix query |
| 10 | Minimum Difficulty of a Job Schedule | Exactly d contiguous groups with segment maximum objective | Core 2D partition state |
| 11 | Largest Sum of Averages | Exactly k groups with segment average objective | Core objective mutation |
| 12 | Split Array Largest Sum | Minimize largest segment sum; binary search + greedy alternative | Core algorithm-choice comparison |
| 13 | Number of Ways to Cut a Pizza | 2D suffix state and row/column partition choices | Cross-link Grid DP |
| 14 | Filling Bookcase Shelves | Bounded-width segments with running max height | Core bounded backward scan |
| 15 | Minimum Cost to Cut a Stick (Partition framing) | Sorted cuts partition a segment; compare with interval-DP formulation | Cross-link Interval DP |
| 16 | String Compression II | Partition into same-character runs with deletion budget state | Advanced 3D partition |
| 17 | Minimum Cost to Merge Stones (Partition view) | K-way grouping with feasibility congruence | Cross-link Interval DP |
| 18 | Paint House II | Color-state transition with top-two minimum optimization | Cross-link State Machine DP |
| 19 | Paint House III | Position × neighborhood count × color state | Cross-link State Machine DP |
| 20 | Word Break II | Boolean DP prunes a DFS that enumerates all valid partitions | Core feasibility + enumeration integration |
| 21 | Minimum Changes to Make K Semi-palindromes | Precompute divisor-based segment transformation cost then exact-k partition | Advanced segment-cost design |
| 22 | Number of Beautiful Partitions | Count exact partitions under start/end character predicates and minimum length | Advanced counting constraints |
| 23 | Maximize Number of Partitions After Operations | Bitmask character-set state plus one-change budget | Advanced state expansion |
| 24 | CF 1968F — Problem F (D&C DP label) | Claimed monotone-opt divide-and-conquer partition optimization | Review source and recurrence; verify title/algorithm match |
| 25 | EDPC L — Deque (Partition framing) | Linear transition cost transformed to line queries for CHT | Cross-link Data-Structure-Optimized DP |
| 26 | Number of Ways to Separate Numbers | Nondecreasing numeric segments; LCP/suffix comparison accelerates transitions | Advanced string-partition integration |

### Recommended changes

- #1 → #2 → #3 is an excellent objective progression: possible / count / minimum cost.
- #4–6 introduce segment validity and exact group count; #7–8 introduce nontrivial segment cost.
- #10–12 are a strong minimax/feasibility progression; compare direct DP against binary search on answer.
- #13, #15, #17–19, #25 are cross-topic integrations, not new partition fundamentals.
- #20 is important because enumeration of all partitions differs from computing only feasibility; teach memoization/pruning and output-size cost.
- #21–23 are strong advanced state additions; define every dimension and bound state-space size.
- #24 requires verification; do not call an item D&C DP unless the monotone-opt condition is proved.
- #25 is better owned by CHT / optimized DP; #26 belongs at the intersection of string comparison and partition DP.
- Final capstone should give a novel sequence with a segment-dependent cost and ask learners to derive the DP, prove segment validity, and identify whether the transition can be optimized.

---

## Status

Topics 01–36 have now received progressive concept-delta reviews. Topics 37–43 remain. No production curriculum rows have been modified.
