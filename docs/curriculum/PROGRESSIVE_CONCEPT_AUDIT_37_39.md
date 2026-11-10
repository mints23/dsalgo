# Progressive Concept Audit — Phase 4C (Topics 37–39)

**Source:** Live production problem rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 37 — Game Theory & Minimax

**Inventory:** 28 placements; 23 Medium/Hard core/variant rows and 5 diagnostic traps.  
**Verdict:** **Good progression from win/lose DP to minimax score differences, Grundy theory, and cyclic-game retrograde analysis. Some competitive-programming entries need source/algorithm verification.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Nim Game | Terminal-state W/L pattern collapses to modulo arithmetic | Core foundation |
| 2 | Divisor Game | State-dependent legal moves; prove parity pattern by induction | Core progression |
| 3 | Take-Away Game with Set S (custom) | General fixed move set and W/L recurrence; period analysis | Core generalization; statement required |
| 4 | Stone Game | Score-difference interval DP; even-length structural guarantee | Core minimax foundation |
| 5 | Predict the Winner | Remove even-length guarantee; DP determines score difference | Core progression |
| 6 | Stone Game IV | State-dependent square moves with W/L objective | Core move-set variant |
| 7 | Stone Game III | One-dimensional score difference with 1/2/3 front choices | Core state reduction |
| 8 | Stone Game V | Split move and asymmetric recursive interval | Advanced game recurrence |
| 9 | Stone Game VI | Two-player game collapses to combined-value greedy sort | Diagnostic / Greedy |
| 10 | Stone Game II | Move budget M becomes a second state dimension | Core state expansion |
| 11 | Guess Number Higher or Lower II | Minimize worst-case cost: min choice over max adversarial response | Core minimax template; Interval DP cross-link |
| 12 | Stone Game VIII | Prefix-sum game with right-to-left one-dimensional recurrence | Advanced reduction |
| 13 | Can I Win | Bitmask of remaining numbers; memoized W/L state | Core bitmask game |
| 14 | Cat and Mouse | Cyclic directed game with WIN/LOSE/DRAW and retrograde reverse-BFS | Advanced core |
| 15 | Cat and Mouse II | Add jump distance and terminal constraints to cyclic game graph | Advanced state extension |
| 16 | Compute Grundy Values (custom) | Mex of reachable Grundy states | Core Sprague-Grundy bridge; statement required |
| 17 | Nim Game (multi-pile) | XOR of independent pile Grundy values | Core compositional theorem |
| 18 | Chalkboard XOR Game | Structural XOR + parity proof; not general minimax DP | Advanced mathematical game |
| 19 | Flip Game II | Memoized game on implicit string-state graph | Core memoized W/L transfer |
| 20 | CF 768C — Jon Snow and his Favourite Number | Repeated sorting + alternating XOR updates; frequency/simulation problem, not a game | Misclassified source; move to simulation/bitwise, or retain only as a diagnostic trap |
| 21 | CF 850C — Arpa and a Game | Factorization into independent subgames and Grundy XOR | Advanced Sprague-Grundy application |
| 22 | CF 768E — Game of Stones | Staircase Nim reduction to selected pile components | Advanced Nim variant; source/claim verification |
| 23 | AGC017B — Moderate Differences | Feasibility of a sequence of adjacent signed differences in [C,D] | Misclassified math/greedy feasibility problem; remove from Game Theory core |
| 24 | Gold — Mortal Kombat Tower (custom) | Two-dimensional health/turn minimax DP on a DAG | Custom advanced; exact source/statement required |
| 25 | Stone Game (n even) | Even-length first-player guarantee avoids O(n²) interval DP | Diagnostic trap |
| 26 | Stone Game VI | Greedy combined-value sort beats minimax DP | Diagnostic trap |
| 27 | Solving Questions with Brainpower | Single-player take/skip optimization is not adversarial game theory | Diagnostic trap / DP |
| 28 | Sum Game | Algebraic parity/imbalance condition replaces game-state DP | Diagnostic trap |


### Recommended changes

- #1 → #2 → #3 teaches the W/L recurrence and move-set generalization.
- #4 → #5 → #7 → #10 teaches score difference and state expansion; #11 adds true minimax worst-case cost.
- #13 → #16 → #17 → #19 is the path from bitmask game states to Grundy/mex and XOR composition.
- #14 → #15 is a strong cyclic-game progression; require terminal states, predecessor counts, and draw handling.
- #9, #25–28 should be method-selection diagnostics.
- #20, #22–24, and #29 need exact statement/source validation. Do not rely on title or current sub_variant text alone.
- Distinguish impartial games (same legal moves for both players) from partisan games; Sprague-Grundy XOR does not automatically apply to partisan games.
- Add misère Nim or a clearly scoped optional module if the curriculum claims comprehensive Nim mastery.
- Final capstone should combine independent subgames, a bitmask state, and a draw-capable cyclic game, requiring the learner to decide whether minimax DP, Grundy XOR, or retrograde analysis applies.

---

## Topic 38 — Dynamic Programming · Tree DP

**Inventory:** 35 placements; all Medium/Hard.  
**Verdict:** **The sub-variant metadata shows a strong tree-DP progression, but all 35 rows are missing structured key_insight values. This is a major documentation gap, not evidence that the explanations are absent: the sub_variant fields already contain detailed reasoning. This topic overlaps heavily with the Trees topic and should have a clear DP-specific ownership.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Diameter of Binary Tree | Postorder return one arm; global answer combines two arms | Core foundation |
| 2 | Path Sum III | Prefix-sum map along root path with backtracking on return | Core path-state extension |
| 3 | House Robber III | Tree maximum independent set with take/skip states | Core tree DP |
| 4 | Distribute Coins in Binary Tree | Signed subtree excess represents flow across parent edge | Core flow interpretation |
| 5 | Longest ZigZag Path | Direction-dependent pair of returned states | Core directional state |
| 6 | Longest Path with Different Adjacent Values | N-ary tree; retain top two valid child arms | Core generalization |
| 7 | Max Difference Between Node and Ancestor | Carry path minimum and maximum top-down | Core top-down state |
| 8 | Binary Tree Cameras | Three states: uncovered, camera, covered | Core constraint-state expansion |
| 9 | Sum of Distances in Tree | Two-pass rerooting with subtree-size contribution formula | Core rerooting |
| 10 | Count Number of Possible Root Nodes | Reroot score updates only when guessed edge direction flips | Rerooting extension |
| 11 | Difference Between Max and Min Price Sum | Rerooting with best and second-best child arms | Advanced rerooting |
| 12 | Maximum Product of Splitted Binary Tree | Subtree sums then second-pass complement product | Reinforcement / aggregation |
| 13 | Number of Nodes in Subtree with Same Label | Frequency vector carried/merged through DFS | Core subtree aggregate |
| 14 | Count Nodes with Highest Score | Subtree-size product across child components and parent-side complement | Core structural aggregate |
| 15 | Tree of Coprimes | Ancestor stacks by value plus number-theoretic compatibility | Advanced integration |
| 16 | Binary Tree Maximum Path Sum | Non-negative returned arm plus two-arm global path | Reinforcement of #1 with zero-floor nuance |
| 17 | Count Subtrees with Max Distance Between Cities | Bitmask subset enumeration, connectivity, and diameter | Move to Bitmask DP / Tree Algorithms |
| 18 | CF 161D — Distance in Tree | Depth-indexed subtree DP counts pairs at exact distance K | Core tree-knapsack foundation |
| 19 | USACO Gold — Cow at Large | Euler-tour subtree intervals and BIT queries | Advanced integration; source required |
| 20 | Count Valid Paths in a Tree | Centroid decomposition with per-centroid path aggregation | Advanced centroid + tree DP |
| 21 | Number of Ways to Reorder Array to Get Same BST | Implicit BST plus combinatorial interleavings of left/right subsequences | Combinatorial tree DP |
| 22 | Number of Good Paths | DSU by value threshold; Kruskal-order component structure | Cross-link DSU / Advanced Graphs |
| 23 | All Possible Full Binary Trees | DP state is a collection of structures, not scalar value | Structural tree DP |
| 24 | Minimum Time to Collect All Apples in a Tree | Selectively accumulate child subtree costs only when needed | Core pruning/aggregation |
| 25 | Count Ways to Build Rooms in an Ant Colony | Subtree-size multinomial interleavings with modular inverses | Advanced combinatorial tree DP |
| 26 | CF 600E — Lomsat Gelral | DSU-on-tree / small-to-large frequency aggregation | Advanced DSU-on-tree |
| 27 | USACO Platinum — Sprinklers 2 | Reroot top-two arms generalized with prefix/suffix over children | Advanced rerooting optimization |
| 28 | Height of Binary Tree After Subtree Removal Queries | Depth-indexed DFS order plus prefix/suffix maxima | Advanced offline query |
| 29 | USACO Platinum — Delegation | Feasibility DP pairing path lengths under equal-length decomposition | Advanced tree knapsack; source required |
| 30 | CF 741D — Arpa's Letter-Marked Tree | Parity-mask path state plus small-to-large merge | Advanced tree DP + bitmask |
| 31 | ABC 293G — Triple Index | Virtual tree from Euler order and LCA compression | Advanced virtual-tree pattern |
| 32 | Smallest Missing Genetic Value in Each Subtree | Incremental MEX state; subtree exploration only where value 1 occurs | Advanced MEX / small-to-large |
| 33 | Unique BSTs | Catalan count over number of keys; no input tree traversal | Diagnostic trap / Combinatorial DP |
| 34 | LCA of Binary Tree | Tree search returning target signals, not optimization DP | Diagnostic trap / Trees |
| 35 | Construct Binary Tree from Preorder/Inorder | Reconstruction from traversals, not DP | Diagnostic trap / Trees |

### Recommended changes

- Keep the DP-specific topic as a ladder of state design, return-value design, rerooting, subtree aggregates, tree knapsack, and advanced merge structures.
- #1 → #3 → #4 → #5 → #8 is a strong progression from one returned scalar to multi-state constrained tree DP.
- #9 → #10 → #11 is a strong rerooting sequence; #27 adds prefix/suffix optimization over many children.
- #18 should be the bridge to tree knapsack and distance-indexed DP.
- #20, #26, #30, and #32 teach different small-to-large/centroid/MEX mechanisms; don't collapse them into one generic "DSU on tree" label.
- #17, #21–23, #28, and #31 are specialized integrations, not one tree-DP pattern.
- #33–35 are diagnostics.
- Fill the 35 missing structured insights only after reviewing the existing sub_variant and topic HTML. Do not blindly copy one field into another; write a concise, independently useful explanation of the new concept delta.
- Final capstone should combine rerooting, a subtree state, and an advanced merge/query structure, while requiring proof of the returned-state invariant and amortized complexity.

---

## Topic 39 — Dynamic Programming · Digit DP

**Inventory:** 26 placements; all Medium/Hard.  
**Verdict:** **A coherent and advanced progression from tight bounds to property dimensions, dual bounds, automaton composition, and huge-range optimization. Several competitive-programming labels need verification.**

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Count the Number of Powerful Integers | Position + tight; fixed suffix joins a free prefix | Core foundation |
| 2 | CSES Counting Numbers | Add previous-digit state to enforce adjacent-digit constraint | Core property dimension |
| 3 | Number of Digit One | Aggregate digit occurrences, not only number count; positional contribution | Core tuple-return extension |
| 4 | Count Numbers with Unique Digits | Bitmask tracks used digits | Core bitmask property |
| 5 | Numbers With Repeated Digits | Complement counting and leading-zero handling | Core counting reduction |
| 6 | Count Special Integers | Explicit leading-zero state; canonical position/tight/leading/property model | Core state formalization |
| 7 | CF 1073E — Segment Sum | Return both count and positional sum contribution | Advanced aggregate |
| 8 | Non-negative Integers Without Consecutive Ones | Binary digit DP with adjacent-bit restriction | Base-change transfer |
| 9 | Numbers At Most N Given Digit Set | Restricted per-position alphabet and tight comparison | Core alphabet mutation |
| 10 | CF 55D — Beautiful Numbers | Compress dynamic LCM state using divisors of lcm(1..9) | Advanced state compression |
| 11 | Digit Count in Range | Count occurrences of a chosen digit with leading-zero handling | Aggregate extension |
| 12 | Number of Beautiful Integers in Range | Two simultaneous properties: parity balance and modulo K | Advanced multi-property state |
| 13 | Find All Good Strings | Lexicographic bounds plus KMP automaton state avoiding forbidden pattern | Advanced automaton integration |
| 14 | Count Stepping Numbers in Range | Two tight bounds, previous digit, and leading-zero state | Advanced dual-bound state |
| 15 | ABC 228F — Lamps | Binary digit DP with popcount budget and modular constraint | Advanced bitwise property composition |
| 16 | Count of Integers | Maintain lower-tight and upper-tight flags simultaneously | Dual-bound extension |
| 17 | Count Symmetric Integers | Property links mirrored positions and half-string balance | Advanced positional coupling |
| 18 | Next Greater Numerically Balanced Number | Generate valid digit-count structures and find smallest candidate ≥ n | Diagnostic: constructive search, not range-count digit DP |
| 19 | CF 1286F — LCC | Build two numbers simultaneously with interacting tight states and XOR property | Verify source and exact state transition |
| 20 | CF 1202D — Print String | Metadata claims automaton state plus two tight flags | Review urgently: title/problem framing may be constructive rather than digit DP |
| 21 | Palindrome Digit DP (custom) | Mirror second half from first half; tight constraint applies to generated prefix | Advanced custom; full statement/source required |
| 22 | CF 1070E — Alternating Digit Sum | Position parity changes sign of digit contribution modulo K | Advanced arithmetic property |
| 23 | Matrix Exponentiation Digit DP (custom) | Linear state transition raised to huge length with matrix exponentiation | Advanced large-bound extension; source required |
| 24 | Next Permutation | Constructive greedy successor, not digit counting | Diagnostic trap |
| 25 | Count Good Numbers | Independent position choices collapse to modular exponentiation | Diagnostic trap |
| 26 | Factorial Trailing Zeroes | Count powers of 5 by arithmetic formula, not digit DP | Diagnostic trap |

### Recommended changes

- #1 → #2 → #4 → #5 → #6 is a strong progression from tight bounds to property state and leading-zero correctness.
- #3/#7/#11 should distinguish counting numbers from summing a digit statistic; require a return tuple and positional contribution derivation.
- #10 is a good state-compression lesson; prove why only 48 divisors of 2520 can occur.
- #12 → #13 → #14 → #15 → #16 builds multiple properties, automata, and dual bounds.
- #18, #24–26 are selection diagnostics.
- #19 and #20 need source/algorithm verification before inclusion. A competitive-programming title is not sufficient evidence that a row is digit DP.
- #21 and #23 require full custom statements and precise bounds.
- Digit DP should teach the standard state tuple (position, tight, leading-zero, property state), memoization rules for tight vs non-tight states, and how to handle signed/range bounds.
- Final capstone should combine two bounds, a forbidden pattern automaton, and two numeric properties, then require a state-space feasibility analysis before coding.

---

## Status

Topics 01–39 have now received progressive concept-delta reviews. Topics 40–43 remain. No production curriculum rows have been modified.
