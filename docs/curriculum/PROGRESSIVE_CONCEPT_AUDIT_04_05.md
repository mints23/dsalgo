# Progressive Concept Audit — Phase 1B (Topics 04–05)

**Source:** Live production rows in `public.problems` and topic-content metadata.  
**Scope:** Question-level concept contribution and sequence quality.  
**Status:** Reviewed; recommendations only. No production changes in this document.

## Topic 04 — Sliding Window

**Inventory:** 55 placements; 52 Medium/Hard and 3 Easy reference entries.  
**Verdict:** **Strong and comprehensive, but several rows repeat a problem already used elsewhere. Organize by invariant and counting strategy.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Minimum Size Subarray Sum | Variable window; shrink as soon as a monotone sum condition becomes valid; minimize length | Core foundation |
| 2 | Longest Substring Without Repeating | Window validity from last-seen positions; jump left pointer | Core foundation; cross-link HashMap |
| 3 | Maximum Average Subarray I | Fixed-size rolling sum | Reference |
| 4 | Permutation in String | Fixed window with frequency-vector equality | Core |
| 5 | Longest Repeating Character Replacement | Relaxed validity using window size minus max frequency | Core variant |
| 6 | Find All Anagrams in a String | Enumerate every fixed-window frequency match | Reinforcement of #4; distinct output requirement |
| 7 | Max Consecutive Ones III | At-most-k violations with a scalar zero count | Core variant |
| 8 | Longest Subarray of 1s After Deleting One | At-most-one-zero window with mandatory deletion / non-empty remainder | Reinforcement with changed contract |
| 9 | Fruit Into Baskets | At-most-two distinct values using a frequency map | Core variant |
| 10 | Longest Substring with At Most K Distinct | Generalize two distinct to parameter K | Core generalization |
| 11 | Subarrays with K Different Integers | Exactly-K = atMost(K) − atMost(K−1) | Core counting technique |
| 12 | Binary Subarrays With Sum | Exact-sum count via atMost difference on binary values | Reinforcement; make the binary/non-negative precondition explicit |
| 13 | Maximum Erasure Value | Same unique-window invariant, optimize sum rather than length | Objective mutation |
| 14 | Longest Subarray With Abs Diff ≤ Limit | Simultaneously maintain max and min with two monotonic deques | Core advanced invariant |
| 15 | Sliding Window Maximum | Monotonic deque with index expiry and dominance pruning | Core deque primitive |
| 16 | Minimum Window Substring | Multi-character requirements, formed/have counters, shrink-to-minimum | Integration; cross-link Two Pointers |
| 17 | Replace Substring for Balanced String | Invert the window: track the segment to replace, not the kept segment | Distinct reasoning inversion |
| 18 | Substrings Containing All Three Characters | Count all valid extensions after first valid window | Core counting contribution |
| 19 | Count Subarrays With Score < K | Nonlinear score (sum × length) while preserving monotonicity for positive values | Core constraint-specific window |
| 20 | Count Number of Nice Subarrays | Transform odd/even into binary and reuse exact-K counting | Integration with transform + atMost |
| 21 | Frequency of Most Frequent Element | Sort, then window cost to raise all values to the right endpoint | Core sorted-window optimization |
| 22 | Longest Nice Subarray | Bitwise OR tracks occupied bits; invalid if any bit overlaps | Distinct bitmask-state window |
| 23 | Sliding Window Median | Two heaps with lazy deletion and balance invariants | Advanced data-structure integration |
| 24 | Shortest Subarray with Sum ≥ K | Negative values break ordinary shrink; prefix sums + monotonic deque | Important pattern-boundary transition; cross-link Prefix Sums |
| 25 | Maximum Number of Robots Within Budget | Combine deque maximum, rolling sum, and a nonlinear budget predicate | Advanced integration |
| 26 | Subarray Product Less Than K | Positive-product window; prefix products are unsafe with zeros/overflow | Reinforcement/diagnostic; same LC 713 appears in Two Pointers — do not count as a second core question |
| 27 | Subarray Sum Equals K | Negative values destroy monotone shrink; prefix sum + HashMap | Diagnostic trap; canonical home HashMap/Prefix Sums |
| 28 | Maximum Subarray | Kadane's is the better invariant for unconstrained maximum sum | Diagnostic trap; canonical home Kadane |
| 29 | Longest Substring with At Least K Repeating | Enumerate target distinct-count (1..alphabet size), then use a window | Distinct outer-parameter technique |
| 30 | Count Subarrays Where Max Elem Appears ≥ K Times | Count valid starts once a window has K maximum elements | Core counting technique |
| 31 | Grumpy Bookstore Owner | Fixed window maximizing recoverable benefit over a baseline | Core fixed-window objective |
| 32 | Minimum Swaps to Group All 1s Together II | Circular fixed window; minimize zeros in a window of size total ones | Circular constraint |
| 33 | Maximum Sum of Distinct Subarrays Length K | Fixed-size sum plus distinct-frequency invariant | Integration |
| 34 | Maximum Number of Vowels in Substring | Fixed window with a simple aggregate counter | Reference/reinforcement |
| 35 | Substring with Concatenation of All Words | Multiple word-length offsets plus word-frequency matching | Advanced integration with HashMap |
| 36 | Longest Subarray with At Most K Frequency | Generalize distinct-count to per-value frequency cap | Distinct validity predicate |
| 37 | Count Complete Subarrays | Count all valid starts when window covers global distinct set | Core counting technique |
| 38 | Minimum Number of K Consecutive Bit Flips | Difference-array expiry / parity to avoid mutating or rescanning a window | Advanced integration |
| 39 | Max Value of Equation | Algebraic transformation plus monotonic deque over an x-distance window | Advanced optimization; cross-link deque/heap |
| 40 | Count Subarrays with Fixed Bounds | Last-bad, last-min, last-max indices yield number of valid starts | Distinct O(1)-state counting |
| 41 | Count Incremovable Subarrays II | Sorted prefix/suffix plus two-pointer counting of valid joins | Integration; cross-link Two Pointers |
| 42 | K Radius Subarray Averages | Fixed window of length 2k+1 and boundary validity | Reference/reinforcement |
| 43 | Number of Sub-arrays of Size K and Average ≥ Threshold | Fixed-window count using integer threshold transformation | Reference/reinforcement |
| 44 | Get Equal Substrings Within Budget | Window with accumulated per-position conversion cost | Core budget constraint |
| 45 | Maximize the Confusion of an Exam | Run the replacement-window predicate for each target character | Reinforcement of #5; likely optional if #5 fully mastered |
| 46 | Minimum Swaps to Group All 1s Together | Fixed window of size total ones; minimize zeros | Reinforcement of #32 without circularity |
| 47 | Maximum Points You Can Obtain from Cards | Complement window: minimize the middle segment left behind | Core complement transformation |
| 48 | Take K of Each Character From Left and Right | Complement window with a multi-character outside-count constraint | Extension of #47 |
| 49 | Shortest Subarray to Remove to Make Array Sorted | Longest nondecreasing prefix/suffix and two-pointer join | Integration with sorting/two pointers |
| 50 | Minimum Operations to Make Array Continuous | Deduplicate/sort then fixed value-range window of width n | Distinct value-domain window |
| 51 | Count Complete Substrings | Enumerate distinct count, fixed window size, and split at local adjacency violations | Advanced multi-level window |
| 52 | Best Time to Buy and Sell Stock | Running minimum, not a sliding window | Diagnostic trap; Easy reference only |
| 53 | Max Consecutive Ones II | Array window works, but streaming follow-up needs DP state | Strong constraint-change diagnostic |
| 54 | Maximum Size Subarray Sum Equals k | Negative values require earliest-prefix-index map | Diagnostic trap; cross-link HashMap |
| 55 | Continuous Subarray Sum | Modular prefix states, not a conventional window | Diagnostic trap; cross-link Prefix Sums |

### Recommended concept paths

1. **Window invariant:** #1 → #2 → #7 → #9 → #10.
2. **Fixed windows and frequency state:** #3 → #4 → #6 → #33 → #35.
3. **Exactly-K counting:** #9/#10 → #11 → #12 → #20; add #18 and #37 for valid-extension counting.
4. **Monotonic deque:** #14 → #15 → #24 → #25 → #39.
5. **Optimization by changing the objective:** #13 → #21 → #22 → #30 → #40.
6. **Complement and constrained windows:** #17 → #47 → #48; #44 and #50 as separate constraint types.
7. **Boundary / method-selection challenges:** #24, #27, #28, #52–55.

### Changes recommended (not yet applied)

- Move #26's repeated LC 713 placement to a single canonical problem with two learning lenses, not two required question entries.
- Treat #27/#54 and #55 as explicit pattern-selection diagnostics; canonical implementations belong to Prefix Sums/HashMap.
- #24 is an important bridge to prefix + monotonic deque, but its main lesson should also be owned by Prefix Sums.
- #45 and #46 are close reinforcement of #5 and #32. Keep as short transfer checks or optional practice, not full new core concepts.
- Preserve #53 because the streaming constraint genuinely changes the state model.
- Add a capstone where learners choose among ordinary sliding window, exact-K via atMost, frequency window, monotonic deque, prefix + deque, and complement window without being told which one applies.

---

## Topic 05 — Kadane's Algorithm

**Inventory:** 28 placements; all 28 are Medium/Hard.  
**Verdict:** **A good advanced sequence, but some entries are adjacent DP/aggregation patterns rather than Kadane's. Tighten topic ownership.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Maximum Subarray | Extend current segment or restart; all-negative initialization and O(1) state | Core foundation |
| 2 | Maximum Product Subarray | Track both maximum and minimum because sign flips reverse ordering | Core extension |
| 3 | Maximum Sum Circular Subarray | Complement of minimum subarray; handle all-negative case | Core extension |
| 4 | Maximum Absolute Sum of Any Subarray | Run max and min Kadane together; optimize absolute magnitude | Reinforcement / objective mutation |
| 5 | Maximum Subarray Sum with One Deletion | Add a second state: no deletion versus one deletion | Core state expansion |
| 6 | K-Concatenation Maximum Sum | Reduce large repeated array to one/two copies plus total-sum contribution | Core algebraic reduction |
| 7 | Maximum Score of Spliced Array | Convert swap interval to a difference array and run Kadane in both directions | Integration |
| 8 | Count Strictly Increasing Subarrays | Count monotone runs using triangular-number contribution; not Kadane recurrence | Move to run counting / arrays; keep cross-link only |
| 9 | Minimum Sum Subarray (custom) | Invert max comparisons to obtain minimum contiguous sum | Core symmetric variant; add complete statement/source |
| 10 | Max Subarray Sum with Length ≥ K (custom) | Prefix sums minus minimum eligible prefix; enforce minimum length | Core constrained-length variant; add complete statement/source |
| 11 | Max Sum of Rectangle No Larger Than K | Compress 2D boundaries, then prefix sums + ordered set for predecessor | Advanced integration |
| 12 | Number of Submatrices That Sum to Target | Compress row/column pairs, then count 1D target-sum ranges with HashMap | Advanced integration |
| 13 | Maximum Sum of 3 Non-Overlapping Subarrays | Precompute best left/right windows and combine middle; tie-breaking | Integration; not classic Kadane |
| 14 | Maximum Sum of Two Non-Overlapping Subarrays | Prefix best windows and split scan | Reinforcement of #13 with two windows |
| 15 | Get the Maximum Score | Two sorted paths synchronize at common values; maximize accumulated path score | Move to Two Pointers / Greedy; retain as transfer if intended |
| 16 | Longest Alphabetical Continuous Substring | Count a run under adjacent-character condition; not Kadane's state transition | Move to string/run scanning |
| 17 | Product of Array Except Self | Prefix × suffix products; explicitly not product Kadane | Diagnostic trap / cross-link Prefix Sums |
| 18 | Binary Tree Maximum Path Sum | Postorder tree DP with local global candidate vs one-branch return; Kadane analogy | Advanced integration with Tree DP |
| 19 | Jump Game VI | DP transition over previous k states optimized by monotonic deque | Move primary ownership to DP + deque; important bridge |
| 20 | Substring With Largest Variance | For every ordered character pair, run constrained Kadane with a required-negative guard | Advanced core extension |
| 21 | Constrained Subsequence Sum | DP over a bounded predecessor window with deque maximum | Move primary ownership to DP / monotonic deque |
| 22 | Max Jumps to Reach Last Index | Value-range constrained DP; transition is not a contiguous subarray recurrence | Move primary ownership to DP |
| 23 | Max Subarray Sum Divisible by K (custom) | Prefix residues and earliest/best prior state to maximize divisible range | Move primary ownership to Prefix Sums; retain as transfer |
| 24 | House Robber | Non-adjacent selection recurrence; contiguity is broken | Diagnostic trap; canonical home 1D DP |
| 25 | Longest Increasing Subsequence | Non-contiguous subsequence; patience sorting / LIS state, not Kadane | Diagnostic trap; canonical home LIS |
| 26 | Subarray Sum Equals K | Exact-sum counting with negatives needs prefix + HashMap | Diagnostic trap; canonical home HashMap/Prefix Sums |
| 27 | Merge Intervals | Interval union is sort + greedy, not a subarray recurrence | **Removed from Kadane's topic as out of scope**; canonical home is Topic 06 (Intervals). A separate trap instance remains in Topic 16 to contrast ordinary interval merging with monotonic-stack invariants |
| 28 | Shortest Subarray with Sum ≥ K | Negative values plus shortest-length objective requires prefix + monotonic deque | Diagnostic trap / cross-link Prefix Sums + Sliding Window |

### Recommended concept paths

1. **Contiguous optimum:** #1 → #2 → #3 → #4.
2. **State expansion / deletion:** #1 → #5.
3. **Repeated and transformed arrays:** #1 → #6 → #7.
4. **Constrained length and prefix minima:** #1 → #10.
5. **2D compression and ordered-prefix integration:** #11 → #12.
6. **Tree / character adaptations:** #18 → #20, with Tree DP owning the tree formulation.
7. **Pattern boundary:** #17, #24–28.

### Changes recommended (not yet applied)

- Keep #8 and #16 as short "looks like Kadane" contrasts or move them to run-counting/string topics; they do not add a new Kadane recurrence.
- #13 and #14 are a useful pair but closely related; make #14 a bridge and #13 the more advanced multi-window capstone.
- #15 belongs primarily in Two Pointers / Greedy (two sorted arrays and synchronization), not the Kadane core.
- #19, #21 and #22 are DP transitions optimized with deques or range restrictions; link to Data Structure Optimized DP and 1D DP rather than claiming all are Kadane.
- #23 and #28 belong primarily to Prefix Sums / monotonic deque; keep them as method-selection diagnostics here.
- #18 is an excellent cross-topic mastery question with Tree DP; explain exactly which part is analogous to Kadane and which part is tree-specific.
- Custom questions #9, #10 and #23 need fully specified statements and traceable source metadata.
- Capstone should be a novel constrained contiguous-optimization problem requiring a learner to decide whether plain Kadane, two-state Kadane, prefix minima, deque-optimized DP, or prefix-map logic applies.

---

## Status update

Topics 01–05 now have progressive concept-delta reviews. Topics 06–43 remain to be audited at the same question-level granularity. No production curriculum rows have been changed as a result of this audit.
