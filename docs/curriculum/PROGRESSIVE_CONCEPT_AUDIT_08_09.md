# Progressive Concept Audit — Phase 1D (Topics 08–09)

**Source:** Live production problem rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 08 — Backtracking

**Inventory:** 38 placements; 38 Medium/Hard.  
**Verdict:** **Good foundational progression and unusually strong advanced variety. The curriculum should distinguish combinatorial generation, constraint search, pruning, memoization, and search/DP crossover.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Subsets | Include/exclude binary decision at each index; visit every partial state | Core foundation |
| 2 | Combinations | Start-index ordering prevents permutation duplicates; choose k-of-n with bounds | Core progression |
| 3 | Permutations | Replace start-index with a visited set; every unused choice is available | Core progression |
| 4 | Subsets II | Sort and skip duplicates at the same recursion depth | Core duplicate control |
| 5 | Combination Sum II | Add target-sum feasibility to duplicate-aware single-use combinations | Core progression |
| 6 | Combination Sum | Allow reuse by recursing at the same index; termination via remaining target | Core reuse mutation |
| 7 | Permutations II | Duplicate skip depends on whether previous equal value is used at this depth | Core duplicate control |
| 8 | Letter Combinations of Phone Number | Choice set is mapped per position; same tree with a different alphabet | Reinforcement / reference |
| 9 | Palindrome Partitioning | Choices are variable-length prefixes accepted by a palindrome predicate | Core segmentation |
| 10 | Restore IP Addresses | Fixed depth plus numeric range and leading-zero constraints | Core bounded segmentation |
| 11 | Word Search | Grid-position + word-index state; mark/unmark visited cells | Core grid search |
| 12 | Unique Paths III | Add global coverage requirement; validate all traversable cells are visited | Core constraint extension |
| 13 | N-Queens | Row-wise placement with column and two diagonal constraint sets | Core constraint modeling |
| 14 | N-Queens II | Same search tree but count solutions instead of materializing boards | Reinforcement; not a new search concept |
| 15 | Sudoku Solver | Multiple overlapping row/column/box constraints and candidate validation | Core constraint-satisfaction extension |
| 16 | Expression Add Operators | Build expressions incrementally while tracking last term to preserve precedence | Advanced integration |
| 17 | Word Break II | Memoize by start index to eliminate repeated suffix search; output-sensitive complexity | Core search-to-DP transition |
| 18 | Flip Game II | Adversarial game tree; winning state if any move reaches opponent-losing state | Integration with Game Theory |
| 19 | Word Pattern II | Bijection constraints between pattern symbols and substrings | Advanced constraint search |
| 20 | Word Squares | Trie-guided prefix choices prune impossible row completions | Advanced integration |
| 21 | Android Unlock Patterns | Graph path enumeration with precomputed intermediate-node constraints | Advanced graph-constrained search |
| 22 | CF 1097F Alex and a TV Show | Metadata labels this as exact-cover recognition / Algorithm X structure | Review source and exact reduction; do not accept the exact-cover claim without proof |
| 23 | Number of Squareful Arrays | Bitmask state plus adjacency compatibility; memoize repeated used-set states | Advanced integration with bitmask DP |
| 24 | Tiling a Rectangle with the Fewest Squares | Branch-and-bound with best-so-far pruning; greedy largest-square choice is not always optimal | Advanced optimization |
| 25 | Zuma Game | Search over board + hand state; normalize runs and combine BFS/backtracking pruning | Advanced hybrid |
| 26 | Word Search II | Shared Trie prunes many words simultaneously during grid DFS | Advanced integration |
| 27 | Cow Placement (custom) | Forward checking / constraint propagation prunes future positions before recursion | Custom advanced exercise; statement/source required |
| 28 | Combination Sum III | Fixed choice domain plus k-count and sum bounds | Reinforcement / bounded-choice pruning |
| 29 | Letter Case Permutation | Binary branching per alphabetic character; deterministic digit positions | Reference / simple state-space shape |
| 30 | Factor Combinations | Nondecreasing factor choices prevent reordered duplicates; unbounded factorization search | Core number-theoretic search |
| 31 | Remove Invalid Parentheses | BFS determines minimum removal depth; enumerate valid states at first successful level | Advanced shortest-search integration |
| 32 | Beautiful Arrangement | Position-dependent divisibility choices with bitmask memoization | Advanced bitmask search |
| 33 | Split String Into Max Unique Substrings | Variable-length partition choices plus a set enforcing uniqueness | Core partition maximization |
| 34 | Maximum Score Words Formed by Letters | Include/exclude word choices under a shared resource-count constraint | Advanced subset/resource search |
| 35 | Stickers to Spell Word | Memoize remaining target multiset; force progress by choosing a sticker covering first remaining character | Advanced state reduction |
| 36 | Generate Parentheses | Prefix-feasibility constraints from open/close counts; only valid partial strings are generated | Reclassify: constrained DFS / backtracking, not a "no backtracking" trap |
| 37 | Partition to K Equal Sum Subsets | Bucket symmetry pruning or bitmask DP collapses repeated subset states | Diagnostic for search-to-DP optimization |
| 38 | Regular Expression Matching | Memoized recursion over (i,j) is DP; bottom-up formulation exposes the state transition | Diagnostic for DP restatement |

### Recommended concept paths

1. **Choice-tree foundations:** #1 → #2 → #3.
2. **Duplicate semantics:** #1 → #4 → #5 → #7.
3. **Reuse and bounded choice:** #5 → #6 → #28 → #30.
4. **Partitioning under constraints:** #9 → #10 → #33.
5. **Grid and constraint satisfaction:** #11 → #12 → #13 → #15 → #26.
6. **Stateful / advanced search:** #16 → #19 → #20 → #25.
7. **Search optimization:** #17 → #23 → #24 → #31 → #32 → #34 → #35 → #37 → #38.
8. **Graph/game/exact-cover transfers:** #18 → #21 → #22.

### Changes recommended (not yet applied)

- #14 is a counting-output variant of #13; retain as a short reinforcement, not a new core concept.
- #8 and #29 are useful warm-up/reference problems but add little advanced reasoning once the choice-tree model is understood.
- #36 is mislabeled conceptually: constrained DFS is still a backtracking/search method even if an immutable string removes explicit undo operations. Teach prefix feasibility and branching, not "not backtracking."
- #37 and #38 should demonstrate the transition from naive search to bitmask DP / bottom-up DP; don't count them as ordinary backtracking mastery questions.
- #17 is a strong search-to-DP bridge; make repeated-state detection and output-size caveats explicit.
- #22's exact-cover classification must be independently verified against the full statement. Do not build curriculum claims from its current label alone.
- #27 needs a complete custom statement, input bounds, expected outputs, and a traceable source.
- Final capstone should require learners to choose between plain backtracking, pruning, forward checking, memoization, bitmask DP, and BFS by analyzing state repetition and shortest-depth requirements.

---

## Topic 09 — Greedy

**Inventory:** 47 placements; 46 Medium/Hard and 1 Easy reference.  
**Verdict:** **Broad, high-value coverage. The central weakness is that greedy proofs are not yet the explicit organizing spine; heap scheduling, interval coverage, monotone stack, binary-search feasibility, and bitwise greedy are mixed together.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Two City Scheduling | Sort by cost difference; exchange argument proves assignment order | Core foundation |
| 2 | Non-overlapping Intervals | Earliest-finish activity selection; stays-ahead / exchange proof | Core foundation |
| 3 | Minimum Arrows to Burst Balloons | Same interval skeleton with touching-endpoint semantics | Reinforcement / boundary mutation |
| 4 | Jump Game | Maintain farthest reachable prefix; greedy reach invariant | Core foundation |
| 5 | Jump Game II | Track current BFS-like layer and next reach to count minimum jumps | Core progression |
| 6 | Partition Labels | Last occurrence extends the current component boundary | Core progression; cross-link Two Pointers/Intervals |
| 7 | Queue Reconstruction by Height | Sort by dominant attribute then insert at rank; invariant that taller people are unaffected | Core ordering proof |
| 8 | Gas Station | Global feasibility by total balance; reset start after negative prefix | Core circular greedy proof |
| 9 | Lemonade Change | Maintain resource inventory; spend larger denomination first to preserve flexibility | Core resource-state greedy |
| 10 | Boats to Save People | Pair extremes; exchange argument for heaviest + lightest | Reinforcement / cross-link Two Pointers |
| 11 | Meeting Rooms II | Min-heap of end times maintains earliest reusable resource | Integration; canonical overlap belongs to Intervals |
| 12 | Task Scheduler | Most frequent task establishes lower bound via idle-slot structure | Core frequency-bound derivation |
| 13 | Reorganize String | Max-heap interleaves currently most frequent symbols | Core heap scheduling |
| 14 | Max Events That Can Be Attended | Day sweep + min-heap; choose earliest-ending currently available event | Core scheduling variant |
| 15 | Course Schedule III | Regret greedy: when over deadline, evict longest selected duration | Core advanced greedy proof |
| 16 | Largest Number | Comparator a+b versus b+a; exchange proof determines total order | Core comparator reasoning |
| 17 | Candy | Two directional constraints; combine left/right requirements with max | Core two-pass constraint composition |
| 18 | Remove Duplicate Letters | Monotone stack with last-occurrence feasibility; preserve lexicographic optimum | Integration with Monotonic Stack |
| 19 | Remove K Digits | Monotone stack with exact deletion budget | Core budget-constrained stack greedy |
| 20 | Furthest Building You Can Reach | Regret heap treats ladders as retrospective upgrades of largest jumps | Core advanced regret greedy |
| 21 | Minimum Number of Refueling Stops | Delay refueling decision; max-heap of passed stations | Core delayed-decision greedy |
| 22 | Minimum Number of Taps | Convert coverage to intervals / Jump Game II reach | Integration with Intervals |
| 23 | CF 1041D Glider | Sort disjoint segments and use sliding window under a total-gap budget | Integration with Sliding Window |
| 24 | Single-Threaded CPU | Sort arrivals and use min-heap to schedule shortest available task | Core event simulation |
| 25 | Meeting Rooms III | Two heaps maintain free room IDs and occupied rooms by end time | Advanced scheduling; cross-link Intervals |
| 26 | Minimize Deviation in Array | Normalize odds, then repeatedly reduce current maximum using ordered structure | Advanced greedy with bounded state transitions |
| 27 | Maximum Number of Tasks You Can Assign | Binary search task count around a greedy feasibility check using deque/pills | Advanced integration; cross-link Binary Search |
| 28 | Talent Show (custom) | Binary search a ratio threshold; transformed-score feasibility resembles fractional knapsack | Custom advanced; source/statement required |
| 29 | Weighted Matroid Greedy (Max Spanning Forest) | Graphic matroid / cycle independence gives a formal greedy optimality framework | Advanced theory; custom proof and source required |
| 30 | Assign Cookies | Sort and match smallest feasible resource to least demanding child | Easy reference |
| 31 | Minimum Time to Make Rope Colorful | Within each equal-character run, keep the maximum-cost item | Core local exchange / group reduction |
| 32 | Eliminate Maximum Number of Monsters | Convert distance/speed to arrival deadlines; sort and compare with firing slots | Core deadline scheduling |
| 33 | Maximum Bags With Full Capacity of Rocks | Sort residual capacities and greedily spend resource on smallest deficits | Reinforcement of resource allocation |
| 34 | Maximum Matrix Sum | Parity of negative count determines whether all magnitudes can be positive; sacrifice minimum absolute value if odd | Core invariant / parity proof |
| 35 | Valid Parenthesis String | Track interval [minOpen,maxOpen] of feasible balances | Core range-of-states greedy |
| 36 | Check if Parenthesis String Can Be Valid | Two directional passes handle locked positions and unmatched sides | Reinforcement with asymmetric constraints |
| 37 | Hand of Straights | Ordered frequency map; always start groups at smallest remaining card | Core ordered multiset greedy |
| 38 | Merge Triplets to Form Target Triplet | Filter dominated candidates, then combine component-wise maxima | Core dominance/filtering |
| 39 | Maximum Number of Non-overlapping Substrings | Expand valid character intervals, then activity-select by end | Integration with Intervals |
| 40 | Minimize Maximum of Array | Prefix average lower bound; redistribute only leftward | Core prefix invariant / proof |
| 41 | Maximum Performance of a Team | Sort by minimum efficiency and maintain top-K speeds in min-heap | Advanced sort + heap integration |
| 42 | Put Marbles in Bags | Partition cost reduces to selecting K−1 adjacent split-pair sums | Core algebraic reduction |
| 43 | Minimum Number of Operations to Make Arrays Similar | Parity-preserving operations; sort parity classes and pair order statistics | Core invariant + matching |
| 44 | Minimum Operations to Reduce Integer to 0 | Binary carry/borrow decisions merge consecutive set bits | Advanced bitwise greedy; cross-link Bit Manipulation |
| 45 | Best Time to Buy and Sell Stock II | Sum of positive deltas is valid only under unlimited free transactions | Diagnostic trap / cross-link State Machine DP |
| 46 | Previous Permutation With One Swap | Exact right-to-left pivot/successor rule; not generic sorting or exchange greedy | Diagnostic trap / specialized permutation algorithm |
| 47 | Monotone Increasing Digits | Right-to-left borrow/cascade and trailing 9s; left-to-right local greedy fails | Diagnostic trap / digit reasoning |

### Recommended concept paths

1. **Exchange arguments and sorting:** #1 → #2 → #3 → #7 → #10.
2. **Reach and interval coverage:** #4 → #5 → #6 → #22 → #39.
3. **Scheduling with heaps:** #11 → #12 → #13 → #14 → #24 → #25.
4. **Regret and delayed decisions:** #15 → #20 → #21.
5. **Greedy with structured state:** #9 → #17 → #18 → #19 → #35 → #36 → #37.
6. **Feasibility / optimization:** #26 → #27 → #28.
7. **Mathematical and algebraic invariants:** #34 → #38 → #40 → #42 → #43 → #44.
8. **Method-selection diagnostics:** #45 → #46 → #47.

### Changes recommended (not yet applied)

- Make proof style explicit for every core greedy problem: exchange argument, stays-ahead, cut/property proof, lower bound + construction, or invariant preservation. "Sort and greedily choose" is not an explanation.
- #3, #10, #11, #14, #22, #25, and #39 overlap with Intervals / Two Pointers. Maintain one canonical owner per full solution and use short cross-topic transfer prompts elsewhere.
- #15 Course Schedule III is canonical Greedy; the Intervals topic should use it as a contrast against weighted interval scheduling DP, not as a second full solution.
- #14 Max Events and #25 Meeting Rooms III should remain distinct: one chooses an event per day by earliest end, the other assigns specific room IDs with two priority queues.
- #18 and #19 should cross-link to Monotonic Stack; their new contribution is the greedy feasibility condition for popping.
- #27 is an excellent capstone combining binary search, sorting, deque, and greedy feasibility; require proof that the feasibility predicate is monotonic.
- #29 should not be a single isolated "matroid" problem. Teach the independence/exchange axioms and show how Kruskal follows; add a second non-graphic example or keep it as an optional theory module.
- #28 and #29 need full custom statements, sources, constraints, and proof notes.
- #44 belongs in Bit Manipulation as the canonical owner; keep only a transfer challenge here.
- #45–47 are useful counterexamples, but should teach exact decision boundaries and not count as additional core greedy algorithms.
- Final capstone should require choosing between exchange greedy, interval scheduling, regret heap, delayed decision, binary-search feasibility, and DP when greedy fails.

---

## Status

Topics 01–09 have now received progressive concept-delta reviews. Topics 10–43 remain. No live curriculum rows have been modified.
