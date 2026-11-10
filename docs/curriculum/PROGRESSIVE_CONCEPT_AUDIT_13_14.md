# Progressive Concept Audit — Phase 2B (Topics 13–14)

**Source:** Live production problem rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 13 — KMP Pattern Matching

**Inventory:** 18 placements; all Medium/Hard.  
**Verdict:** **A strong KMP-centered topic with useful Z-function and automaton transfers. It is not yet a complete advanced string-algorithms curriculum.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Find First Occurrence in String | Prefix/failure function; matched-prefix state survives mismatch | Core foundation |
| 2 | Repeated Substring Pattern | Derive minimal period from final border length | Core progression |
| 3 | Rotate String | Search pattern in doubled text; reuse KMP matcher | Reinforcement / reduction |
| 4 | Longest Happy Prefix | Failure function directly returns longest proper border | Core application |
| 5 | Shortest Palindrome | Reverse concatenation + separator; longest palindromic prefix via failure function | Core reduction |
| 6 | Form Array by Concatenating Subarrays | KMP over arbitrary comparable sequences, not just characters | Core generalization |
| 7 | Repeated String Match | Search in repeated text with a proven finite repetition bound | Core constraint variant |
| 8 | Sum of Scores of Built Strings | Z-function gives longest prefix match at each suffix; sum scores | Core adjacent algorithm (Z) |
| 9 | Find Beautiful Indices I | Two KMP match-position lists plus two-pointer distance filtering | Integration |
| 10 | String Matching in an Array | Apply KMP/Z for multiple substring checks | Reinforcement; ensure complexity is justified |
| 11 | Find All Good Strings | KMP automaton state fused with digit DP tightness and forbidden-pattern avoidance | Advanced integration |
| 12 | Minimum Valid Strings to Form Target | Failure/prefix matching across source words plus DP for minimum segmentation | Advanced integration; verify exact transition proof |
| 13 | First Almost Equal Substring | Forward and reverse Z values identify positions with at most one mismatch | Advanced Z-function extension |
| 14 | Encode String with Shortest Length | KMP period detection inside interval DP over all substrings | Advanced integration |
| 15 | KMP Automaton — Build FSM, Stream Characters O(1) per Char (custom) | Precompute state × alphabet transitions to remove fallback loop during streaming | Advanced core; source/statement and alphabet constraints required |
| 16 | Longest Palindromic Substring | Manacher / center expansion is the correct structure, not KMP | Diagnostic trap; cross-link Advanced Strings |
| 17 | Minimum Window Substring | Frequency window with dynamic required counts; KMP is for fixed exact patterns | Diagnostic trap; canonical Sliding Window |
| 18 | Longest Duplicate Substring | Rolling hash / suffix array solves unknown repeated-substring search; KMP is for a known pattern | Diagnostic trap; canonical Advanced Strings |

### Recommended concept paths

1. **Failure-function fundamentals:** #1 → #2 → #4 → #5.
2. **KMP as a sequence matcher:** #3 → #6 → #7 → #9 → #10.
3. **Z-function:** #8 → #13.
4. **Automaton and DP integration:** #11 → #15.
5. **DP / optimization integration:** #12 → #14.
6. **Method selection:** #16 → #18, with #17 as a contrasting frequency-window case.

### Changes recommended (not yet applied)

- Teach the prefix function derivation and invariant in depth: what each failure value means, why fallback preserves valid matched information, and why total search time is linear.
- Distinguish prefix function / failure function, Z-function, and full KMP automaton as related but different representations.
- #3 and #7 are useful transfers but should not repeat a full KMP implementation after #1; ask the learner to derive only the changed bound/concatenation.
- #8 and #13 teach Z-function and should be labeled explicitly as an adjacent string-matching primitive rather than pretending they are KMP.
- #11 is a strong capstone because it combines KMP automaton transitions with digit DP; require state derivation and automaton correctness.
- #12 should be checked carefully: multiple-pattern prefix matching plus minimum segmentation is a distinct algorithm; ensure the stored explanation matches the current official problem formulation and constraints.
- #15 requires a fully specified alphabet and memory bound; O(M×Σ) preprocessing is only practical when Σ is bounded.
- #16 and #18 reveal the gap: add a dedicated Advanced String Algorithms path for Manacher, rolling hash/Rabin–Karp, suffix array + LCP, suffix automaton, and multi-pattern matching (Aho–Corasick currently lives under Trie).
- Final capstone: stream a large text, forbid one pattern, satisfy a lexicographic bound, and count valid strings; learner must derive automaton × DP state rather than merely implement a known KMP template.

---

## Topic 14 — LIS: Longest Increasing Subsequence O(N log N)

**Inventory:** 19 placements; 18 Medium/Hard and 1 missing-difficulty custom exercise.  
**Verdict:** **A strong and well-focused LIS topic. It teaches the tails invariant, counting/reconstruction, multidimensional reductions, and when the tails trick stops working. Make the distinction between LIS, LNDS, greedy chain selection, and constrained DP explicit.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Longest Increasing Subsequence | Tails array + lower_bound; minimal tail per subsequence length | Core foundation |
| 2 | Number of Longest Increasing Subsequences | Length alone is insufficient; maintain count per DP state | Core progression |
| 3 | Russian Doll Envelopes | Reduce 2D nesting to LIS with descending tie-break on equal width | Core dimensional reduction |
| 4 | Maximum Height by Stacking Cuboids | Normalize each cuboid's dimensions, then solve a 3D dominance-chain DP | Advanced extension |
| 5 | Longest String Chain | Sort by length and model predecessor deletion as a DAG/LIS-like DP | Transfer to DAG DP |
| 6 | Min Operations — Array K-Increasing | Split into K interleaved subsequences and compute LNDS per lane | Core decomposition |
| 7 | Maximum Length of Pair Chain | Greedy earliest-end selection is equivalent to a chain problem under these interval assumptions | Diagnostic / greedy contrast |
| 8 | Min Removals — Mountain Array | Combine LIS from left and decreasing subsequence from right around a valid peak | Core bidirectional integration |
| 9 | Longest Valid Obstacle Course at Each Position | Use upper_bound for LNDS and report the answer after every prefix | Core online-output extension |
| 10 | Non-Overlapping Intervals | Dilworth/chain perspective connects maximum compatible intervals to minimum removals | Cross-topic Greedy/Intervals; avoid full duplicate |
| 11 | Maximum Profit in Job Scheduling | Weighted intervals require DP + binary search; pure LIS/greedy is insufficient | Diagnostic / weighted extension |
| 12 | LIS II (gap constraint) | Gap restriction invalidates tails; use segment tree DP over value range | Core boundary / advanced DP |
| 13 | Delete Columns to Make Sorted III | LIS-like DP where comparator checks all rows between column vectors | Core custom comparator |
| 14 | Make Array Strictly Increasing | DP over replacement choices from a sorted external array | Advanced state/choice extension |
| 15 | Longest Ideal Subsequence | DP over bounded alphabet neighborhood; tails monotonicity is unavailable | Diagnostic / alternative DP |
| 16 | LIS Reconstruction — Print Actual Subsequence (custom) | Track predecessor indices and tails ownership to recover one actual chain | Core reconstruction extension; source/statement required |
| 17 | Longest Consecutive Sequence | Reordering is allowed; HashSet chain walk, not LIS over input order | Diagnostic trap |
| 18 | Longest Arithmetic Subsequence of Given Difference | Fixed predecessor x−d enables HashMap DP, not LIS tails | Diagnostic trap |
| 19 | Largest Divisible Subset | O(N²) divisibility DP with parent pointers; tails loses required reconstruction information | Diagnostic / adjacent DP formulation |

### Recommended concept paths

1. **Tails invariant and counting:** #1 → #2 → #16.
2. **Multidimensional chain reductions:** #1 → #3 → #4.
3. **Monotone subsequence variants:** #1 → #6 → #9.
4. **Bidirectional / constrained sequence DP:** #8 → #12 → #13 → #14 → #15.
5. **When LIS is not the answer:** #7 → #10 → #11 → #17 → #18 → #19.

### Changes recommended (not yet applied)

- #1 must teach why tails stores the smallest possible ending value for each length, and why tails itself is not necessarily an actual subsequence.
- #2 should follow #1 to expose the limitation of tails: it computes length efficiently but does not directly count all LIS.
- #3 is an excellent next step because descending tie-break on equal widths is a genuinely new ordering insight.
- #4 should explicitly prove dimension normalization and the 3D dominance relation.
- #6 and #9 require careful distinction between strictly increasing (lower_bound) and non-decreasing (upper_bound).
- #7 and #10 are primarily Greedy/Intervals. Keep as short algorithm-choice comparisons, not separate full LIS lessons.
- #11 is weighted interval scheduling and should be canonical in Intervals / DP; the key lesson here is why an unweighted LIS abstraction is insufficient.
- #12 is a high-value mastery problem because it demonstrates exactly when tails no longer captures enough state.
- #13–15 are constrained sequence DP, not direct applications of the classic tails algorithm; identify which constraints destroy the monotone-tail invariant.
- #16 requires complete statement/source and a tested reconstruction explanation. The parent index must refer to a valid predecessor state that remains reconstructible despite tails replacement.
- #19's explanation should be precise: O(N²) DP is needed for this divisibility ordering and parent reconstruction; it is not true that all O(N log N) tails variants inherently lose reconstruction.
- Cross-link Binary Search for lower_bound/upper_bound, Segment Tree for LIS II, Prefix Sums/BIT for range-max DP, and Greedy for pair-chain.
- Final capstone: ask learners to classify an unfamiliar sequence problem and decide whether classic tails, LNDS, multidimensional sorting + LIS, DP with a range-query structure, or HashMap DP is required.

---

## Status

Topics 01–14 have now received progressive concept-delta reviews. Topics 15–43 remain. No production curriculum rows have been modified.
