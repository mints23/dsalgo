# Progressive Concept Audit — Question-by-Question Curriculum Review

**Purpose:** Validate the AlgoFrog principle that every required question contributes a distinct reasoning concept, reuses prior learning where appropriate, and prepares the learner for an integrative mastery problem.

**Audit method:** A problem is not considered unique merely because it has a different LeetCode ID. For each placement, inspect its primary concept, concept delta, prerequisite/reuse, constraint mutation, and whether the same learning objective already exists elsewhere. Keep useful contrastive traps, but do not count them as new algorithm concepts.

**Status:** In progress. The first three topics have been reviewed from the live Supabase problem rows and topic-content metadata. This is a curriculum/sequence audit, not yet a full independent correctness review of every solution.

## Decisions and labels

- **Core progression:** Introduces a new reusable concept or a meaningful extension.
- **Reinforcement:** Reuses an earlier concept under a new input, invariant, or constraint; useful, but not a new primary concept.
- **Integration:** Combines multiple previously taught concepts.
- **Diagnostic trap:** Teaches when a pattern does not apply or exposes a specific failure mode.
- **Reference:** Useful for fluency, but not part of the advanced required path.
- **Move / split:** Valuable content, but belongs in another concept path or topic.
- **Review:** Insufficient structured explanation or unclear incremental value.

A topic may contain several parallel concept paths. The final capstone should combine the topic's most important paths rather than forcing unrelated techniques into one linear sequence.

---

## Topic 01 — Two Pointers

**Inventory:** 58 placements; 40 Medium/Hard and 18 Easy reference entries.  
**Verdict:** **Partially aligned — retain most content, split into explicit concept paths and repair several placements.**

### Question-level concept map

| Order | Problem | Learning contribution | Audit treatment |
|---:|---|---|---|
| 1 | Two Sum II | Sorted monotone elimination; prove which pointer can be discarded | Core progression |
| 2 | 3Sum | Add a fixed anchor around the two-pointer scan; duplicate control | Core progression |
| 3 | Container With Most Water | Maximize an objective using a dominance/elimination proof | Core progression |
| 4 | Valid Palindrome | Character filtering and symmetric comparison | Reference |
| 5 | Linked List Cycle | Floyd's collision detection in a functional structure | Reference / separate fast-slow path |
| 6 | Linked List Cycle II | Derive cycle-entry location after collision | Core fast-slow path |
| 7 | Middle of the Linked List | Speed-ratio invariant for midpoint discovery | Reference / fast-slow path |
| 8 | Remove Nth Node From End | Fixed lead gap and sentinel handling | Core fast-slow path |
| 9 | Sort Colors | Three-way in-place partition with an unknown middle region | Core, separate partition path |
| 10 | Squares of a Sorted Array | Merge two monotone candidate streams; fill output backward | Reference |
| 11 | 4Sum | Add a second fixed anchor; duplicate and overflow management | Reinforcement of 3Sum |
| 12 | 3Sum Closest | Change exact enumeration into nearest-objective optimization | Reinforcement / objective mutation |
| 13 | Number of Subsequences Sum ≤ Target | Count a combinatorial family from one valid endpoint using powers of two | Core concept delta |
| 14 | Trapping Rain Water | Boundary maxima invariant; pointer movement from a proof about the smaller boundary | Core concept delta |
| 15 | Move Zeroes | Stable in-place read/write compaction | Reference / read-write path |
| 16 | Reverse String | Symmetric in-place swaps | Reference |
| 17 | Palindrome Linked List | Compose midpoint discovery, reversal, and comparison | Integration |
| 18 | Intersection of Two Linked Lists | Equalize path lengths by pointer switching | Core fast-slow / two-list path |
| 19 | Merge Sorted Array | In-place merge from the safe end to avoid overwriting unread values | Core read-write path |
| 20 | Is Subsequence | Streaming comparison of two sequences | Reference |
| 21 | Happy Number | Apply Floyd to an implicit functional graph | Transfer / reference |
| 22 | Find the Duplicate Number | Transfer cycle-entry mathematics to an array-as-function under O(1)-space constraints | Core integration |
| 23 | Minimum Window Substring | Variable window plus frequency state and formed-count invariant | Integration; cross-link to Sliding Window |
| 24 | Subarray Product Less Than K | Count valid positive-product windows ending at each right endpoint | Integration; cross-link to Sliding Window |
| 25 | Partition Labels | Greedy boundary expansion using last occurrences | Integration; not a canonical two-pointer problem |
| 26 | Boats to Save People | Exchange argument plus sorted opposite-end pairing | Integration with Greedy |
| 27 | Longest Mountain in Array | Detect peak and expand monotone runs | Reinforcement |
| 28 | Rotate Array | Compose three reversals for in-place cyclic transformation | Separate array-transformation path |
| 29 | Next Permutation | Lexicographic successor: rightmost ascent, successor swap, minimal suffix | Distinct algorithmic concept; retain |
| 30 | 3Sum With Multiplicity | Duplicate-count combinatorics and modular arithmetic | Integration / reinforcement |
| 31 | Min Operations to Reduce X to Zero | Complement transformation to longest subarray with sum total−x | Move emphasis to Prefix Sums / Sliding Window; cross-link |
| 32 | Count Pairs Whose Sum Is Less Than Target | Basic sorted pair counting | Reference |
| 33 | 4Sum II | Pair-sum frequency map; no two-pointer scan is needed | Move primary teaching to HashMap; keep only as a contrast if distinct |
| 34 | Candy | Two directional greedy constraints; not a two-pointer algorithm | Move primary teaching to Greedy |
| 35 | Min Moves to Seat Everyone | Sorting establishes optimal one-to-one matching | Reference / Sorting |
| 36 | Two Sum Less Than K | Sorted pair maximization | Reinforcement |
| 37 | 3Sum Smaller | Count all pairs behind a valid boundary in O(1) per fixed anchor | Core counting refinement |
| 38 | Sum of Square Numbers | Number-theoretic two-sum over bounded integer candidates | Transfer / distinct domain |
| 39 | Count the Number of Fair Pairs | Difference of two monotone count-less functions | Core counting refinement |
| 40 | Reorder List | Compose midpoint, reversal, and alternating merge | Integration / capstone candidate |
| 41 | Circular Array Loop | Functional-graph cycle detection with direction and cycle-length constraints | Core fast-slow extension |
| 42 | Remove Duplicates from Sorted Array | Read/write pointer compaction | Reference |
| 43 | Remove Duplicates from Sorted Array II | Generalize compaction to an allowed multiplicity bound | Core read/write extension |
| 44 | String Compression | In-place run-length encoding with separate read and write cursors | Core read/write extension |
| 45 | Long Pressed Name | Consume/skip logic across two strings | Reference |
| 46 | Bag of Tokens | Greedy resource exchange: cheapest buy, most expensive sell | Integration with Greedy |
| 47 | Maximum Distance Between a Pair of Values | Two monotone arrays; advance the failing pointer | Core two-sequence path |
| 48 | Push Dominoes | Resolve forces between sentinels/anchors, including opposing fronts | Integration / simulation |
| 49 | The Latest Time to Catch a Bus | Greedy capacity simulation and collision-aware latest-time selection | Integration with sorting/simulation |
| 50 | Longest Palindromic Subsequence | Subsequence state requires DP, not an endpoint scan | Diagnostic trap / cross-link to DP |
| 51 | Subarray Sum Equals K | Negative values destroy shrink monotonicity; prefix sum + map | Diagnostic trap / cross-link to HashMap |
| 52 | Max Size Subarray Sum = k | First-seen prefix index for longest exact-sum range | Diagnostic trap / cross-link to HashMap |
| 53 | Two Sum (unsorted) | Unsorted input and original-index requirement favor a map | Diagnostic trap / cross-link to HashMap |
| 54 | K-diff Pairs in Array | Special handling for k=0 and unique-pair semantics | Diagnostic / boundary case |
| 55 | Longest Palindromic Substring | Expand around center; distinct center-expansion invariant | Core adjacent pattern; label separately from opposite-end pointers |
| 56 | Valid Palindrome II | One-mismatch branching; test both deletion candidates | Diagnostic / bounded backtracking |
| 57 | 4Sum II (4 separate arrays) | Four-array pair-sum hashing, not four-pointer scanning | Duplicate/contrast with order 33 and HashMap topic; consolidate |
| 58 | Pairs of Strings Concat = Target | Prefix/suffix split and frequency lookup for variable-length strings | Diagnostic / HashMap transfer |

### Recommended concept paths

1. **Sorted opposite-end elimination and counting:** 1 → 2 → 3 → 11 → 12 → 13 → 37 → 39, with 36 and 38 as transfer/reinforcement.
2. **Boundary-dominance and water accumulation:** 3 → 14.
3. **Fast/slow and functional graphs:** 5 → 6 → 7 → 8 → 21 → 22 → 41.
4. **Read/write and in-place mutation:** 15 → 19 → 42 → 43 → 44.
5. **Two-list / sequence synchronization:** 18 → 20 → 47; use 17 and 40 as integration challenges.
6. **Greedy + pointers:** 25 → 26 → 46 → 49.
7. **Pattern selection and traps:** 50–58, with explicit links to DP, HashMap, Prefix Sums, Greedy, and string center expansion.

### Specific changes recommended (not yet applied)

- Reorganize the UI's required path into these sub-paths; do not keep one 58-row linear progression.
- Keep Easy rows as optional reference. Keep diagnostic traps available, but distinguish them from new core concepts.
- Move primary ownership of order 33/57 (4Sum II) to HashMap; keep at most one short contrastive diagnostic in Two Pointers.
- Move order 34 (Candy) to Greedy as its canonical home; cross-link it here only if it tests pointer-based two-pass reasoning explicitly.
- Reclassify order 31 under Prefix Sums / Sliding Window as a complement-subarray transformation.
- Treat order 23/24 as explicit cross-topic integration with Sliding Window, not as evidence that all window problems belong to Two Pointers.
- Add a final unseen capstone requiring the learner to choose between opposite-end pointers, fast/slow, and read/write pointers, and justify why the other families do not apply. Reorder List is a useful known integration exercise but should not be the only unseen assessment.
- Clarify order 55 as **expand-around-center**, a separate string technique rather than ordinary opposite-end two pointers.
- For every trap, teach the decision boundary and counterexample; avoid making a trap merely a duplicate full problem.

### Topic-level conclusion

The topic is rich and contains genuinely distinct techniques, but the current row order interleaves parallel patterns and cross-topic examples. The right fix is **a branching concept graph**, not deleting valuable questions or forcing all pointer variants into one sequence.

---

## Topic 02 — HashMap

**Inventory:** 48 placements; 36 Medium/Hard and 12 Easy reference entries.  
**Verdict:** **Broad and valuable, but the required path needs concept lanes and stronger ownership boundaries.**

### Main concept lanes observed

- Complement lookup and frequency counting.
- Canonicalization/grouping and bidirectional maps.
- Prefix-state maps: exact sums, first-seen indices, modular residues.
- Sliding-window frequency state.
- Map + linked list for O(1) cache operations.
- Composite keys, reverse mappings, implicit-array maps.
- Frequency stack / max-frequency aggregation.
- Map + heap, parsing, graph, and DP combinations.

### High-value progression candidates

1. **Complement lookup → pair-sum aggregation:** Two Sum (reference) → 4Sum II. The new concept is hashing pair sums to reduce four nested loops to two quadratic passes.
2. **Frequency counting → canonical key:** Valid Anagram (reference) → Group Anagrams → Bulls and Cows / frequency aggregation.
3. **Prefix state:** Subarray Sum Equals K → Contiguous Array → Subarray Sums Divisible by K. Distinct deltas: target difference, transformed balance + earliest index, and modular residue equivalence.
4. **Bijection:** Word Pattern → Isomorphic Strings; both directions are necessary. Keep one as core and the other as a short transfer test rather than two full repeats.
5. **Window state:** Find All Anagrams → Longest Substring Without Repeating; fixed-window frequency matching versus variable-window last-seen index.
6. **Map-backed data structures:** LRU Cache → LFU Cache → All O(1) Data Structure. This is a strong cumulative path: key-to-node, recency order, frequency buckets, then constant-time bucket transitions.
7. **Composite/structured state:** Underground System → Max Points on a Line; teach tuple keys, normalization, and collision-free representations.
8. **Integration:** Design Twitter combines maps, heaps, and k-way merge; Number of Atoms combines parsing/stack state with nested frequency maps; Alien Dictionary combines map adjacency with topological sorting.

### Cross-topic duplicates that are pedagogically justified when labeled

- Two Sum: canonical HashMap solution versus Two Pointers diagnostic for unsorted input.
- Subarray Sum Equals K: HashMap canonical versus Two Pointers / Kadane / Sliding Window trap demonstrating why negatives break monotonic shrinking.
- 4Sum II: HashMap pair-sum canonical versus a pointer-pattern selection trap.
- Longest Consecutive Sequence: HashSet O(n) start-of-chain method versus sorting as a complexity trap.
- LRU Cache: canonical map + DLL implementation versus a language-library shortcut / interview-design diagnostic.
- Pairs Concat Equal to Target: frequency/complement lookup versus variable-length prefix/suffix splitting.

### Specific changes recommended (not yet applied)

- Split the topic into explicit lanes rather than treating every map use as the same pattern.
- Keep the 12 Easy problems as optional reference.
- Ensure the required path teaches **what to hash** (complement, frequency, prefix state, canonical form, composite key, identity mapping) before the data-structure combinations.
- Add explicit Java-specific guidance only where language behavior matters (negative modulo, equals/hashCode); do not make language trivia count as a new algorithmic concept.
- Clarify topic ownership for Design Twitter (heap/k-way merge), Alien Dictionary (graph/topological sort), Concatenated Words (Trie/DP), and Count Number of Texts (DP).
- The map + DLL sequence (LRU → LFU → All O(1)) is a strong candidate for this topic's integration capstone; an unseen design prompt should test whether the learner can derive the required indexes and update invariants.

---

## Topic 03 — Binary Search

**Inventory:** 44 placements; 37 Medium/Hard and 7 Easy reference entries.  
**Verdict:** **Strong breadth and advanced coverage; restructure around monotonicity and search-space proof.**

### Main concept lanes

- Classic search and boundary search (first true / last true).
- Rotated arrays, with and without duplicates.
- Binary search on answer: minimize or maximize a feasible value.
- Feasibility oracle design and greedy validation.
- Matrix search and staircase counting.
- Partition search across two sorted arrays.
- Floating-point precision.
- Exponential bound discovery for unknown-size domains.
- Binary search inside patience sorting / LIS.
- Pigeonhole/value-domain search.

### High-value progression candidates

1. **Search invariant:** Binary Search (reference) → Find First and Last Position → First Bad Version (reference). Make loop invariant and boundary semantics explicit.
2. **Rotated structure:** Search in Rotated Sorted Array → Find Minimum in Rotated Sorted Array → duplicate variants. The new challenge is identifying the sorted half, then reasoning about ambiguity when duplicates erase ordering information.
3. **Answer-space search:** Koko Eating Bananas → Minimum Speed to Arrive on Time → Ship Packages → Split Array Largest Sum → Smallest Divisor. Each should state the monotone predicate and prove why feasibility is monotonic.
4. **Greedy oracle:** Aggressive Cows → Book Allocation → Magnetic Force. These are related applications; avoid counting each as a wholly new binary-search concept unless the feasibility proof or constraints add a meaningful insight.
5. **Two-array partition:** Median of Two Sorted Arrays. Teach partition balance and cross-boundary ordering, not just "binary search on an array."
6. **Search + counting:** Kth Smallest in Sorted Matrix → Kth Smallest in Multiplication Table → Kth Smallest Pair Distance. Distinct count oracles (staircase, row arithmetic, sliding window) are the concept delta.
7. **Unbounded search:** Search in Array of Unknown Size adds exponential bound discovery before ordinary binary search.
8. **LIS interaction:** Longest Valid Obstacle Course → Russian Doll Envelopes → LIS. These are primarily LIS/patience-sorting lessons; this topic should teach the binary-search operation on tails and cross-link to the dedicated LIS topic.
9. **Pigeonhole:** Find the Duplicate Number via value-domain counting is a meaningful alternative to the Floyd cycle method in Two Pointers. Keep both with an explicit contrast in assumptions and space complexity.

### Specific changes recommended (not yet applied)

- Require every answer-space problem to document: search domain, monotone predicate, proof of monotonicity, feasible/infeasible boundary, and complexity of the oracle.
- Group minimize and maximize searches separately, then add a mixed diagnostic asking the learner to infer direction.
- Distinguish "binary search on sorted data" from "binary search on answer" in UI and metadata.
- Keep duplicate-rotated-array cases as a deliberate worst-case degradation lesson (can fall to O(n)).
- Cross-link LIS rows to the dedicated LIS topic; do not count the same full LIS learning objective twice.
- Cross-link Find Duplicate Number to Two Pointers as an algorithm-choice comparison (Floyd O(n)/O(1) versus value-domain binary search O(n log n)).
- Use a final unseen mastery challenge requiring the learner to design a monotone oracle for a new optimization problem and defend its correctness.

---

## Full audit status

All 43 topics have now received a first-pass question-by-question progressive concept review across the companion documents in this folder. This is not yet a line-by-line solution correctness review. Every flagged custom/competitive-programming problem, questionable algorithm label, and source-dependent complexity claim must be verified before production curriculum changes.

## Production safety

This audit document is advisory. It does not alter live problems, progress, playback, authentication, subscriptions, payments, or user records. Curriculum-role, ordering, and UI changes should be made only after the complete review establishes a safe, evidence-backed mapping.
