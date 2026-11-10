# Progressive Concept Audit — Phase 1C (Topics 06–07)

**Source:** Live production `public.problems` rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 06 — Intervals

**Inventory:** 43 placements; 41 Medium/Hard plus 2 rows with missing difficulty.  
**Verdict:** **Strong and wide-ranging. The sequence should make interval ownership, event sweeps, dynamic interval sets, and weighted scheduling explicit sub-paths.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Merge Intervals | Sort by start and maintain the active merged right boundary | Core foundation |
| 2 | Insert Interval | Insert into an already sorted disjoint set; classify left/overlap/right | Core progression |
| 3 | Interval List Intersections | Two sorted interval streams; advance the interval ending first | Core progression |
| 4 | Minimum Interval to Include Each Query | Offline query sorting plus min-heap of active interval lengths | Core integration |
| 5 | Non-overlapping Intervals | Activity selection: earliest finishing interval is safe | Core greedy proof |
| 6 | Minimum Number of Arrows to Burst Balloons | Interval stabbing; endpoint-touching semantics differ from removal count | Core boundary refinement |
| 7 | Meeting Rooms II | Peak concurrency using sorted start/end streams | Core sweep |
| 8 | Meeting Rooms | Boolean overlap detection after sorting | Reference / simpler sibling |
| 9 | Remove Covered Intervals | Sort tie-break (start asc, end desc) and maintain maximum end | Core containment logic |
| 10 | Number of Days Between Two Dates | Gregorian calendar arithmetic, not interval reasoning | Diagnostic trap; remove from required interval path |
| 11 | Employee Free Time | Merge across multiple employees, then take complement gaps | Core integration |
| 12 | Minimum Number of Taps to Water a Garden | Convert taps to intervals, then greedy range cover | Core reduction |
| 13 | Jump Game II | Reinterpret each index as a reachable interval / BFS layer | Cross-topic transfer to Greedy |
| 14 | Video Stitching | Minimum interval cover of [0,T] using furthest reach among available starts | Core coverage variant |
| 15 | My Calendar III | Dynamic maximum overlap via difference map or segment tree | Advanced dynamic events |
| 16 | My Calendar I | Ordered predecessor/successor conflict checks for insertion | Core dynamic interval set |
| 17 | My Calendar II | Track single and double-booked regions; reject triple overlap | Core extension of #16 |
| 18 | The Skyline Problem | Sweep line with active-height max-heap and event tie-breaking | Advanced sweep |
| 19 | Range Module | Dynamic add/remove/query over disjoint intervals | Advanced interval set |
| 20 | Data Stream as Disjoint Intervals | Insert point and merge predecessor/successor neighbors | Core dynamic merge |
| 21 | Count Integers in Intervals | Dynamic union plus covered-length accounting | Advanced extension of #20 |
| 22 | Rectangle Area II | Coordinate compression + sweep + segment tree over active x-coverage | Advanced 2D integration |
| 23 | Divide Intervals Into Minimum Number of Groups | Interval partitioning; minimum groups equals peak overlap | Reinforcement of #7; explain coloring perspective |
| 24 | Maximum Beauty of an Array After Applying Operation | Convert each value to a tolerance interval; max overlap via difference array | Core transformation |
| 25 | Describe the Painting | Sweep events and aggregate active labels over atomic segments | Advanced event aggregation |
| 26 | Count Positions on Street With Required Brightness | Difference-array range updates followed by prefix scan | Reinforcement / range update |
| 27 | Amount of New Area Painted Each Day | Incremental union with ordered jump/skip structure | Advanced dynamic coverage |
| 28 | Maximum Sum Obtained of Any Permutation | Difference-array request frequencies, then rearrangement inequality | Integration with Greedy / Prefix Sums |
| 29 | Course Schedule III | Deadline order plus max-heap regret: evict longest duration | Core weighted scheduling greedy |
| 30 | Maximum Profit in Job Scheduling | Weighted interval scheduling DP with binary-searched predecessor | Core greedy-to-DP boundary |
| 31 | Two Best Non-Overlapping Events | Special k=2 weighted scheduling using suffix maximum and binary search | Reinforcement / constrained variant |
| 32 | Maximum Earnings From Taxi | Recognize weighted rides as weighted intervals; DP transition | Reinforcement of #30 |
| 33 | Offline Stabbing Queries (custom) | Sort starts/ends/queries and maintain active count in a sweep | Core custom exercise; missing difficulty and source/statement review |
| 34 | Longest Substring of One Repeating Character | Segment tree maintains longest equal-character run under point updates | Move primary ownership to Segment Tree; interval-run application |
| 35 | CF 981E / Count Good Numbers (Digit DP disguise) | Recognize digit DP rather than interval sweep | Diagnostic trap; source/problem identity review |
| 36 | Summary Ranges | Compress sorted consecutive values into maximal runs | Reference / range construction |
| 37 | Partition Labels | Derive intervals from first/last character occurrence and merge | Cross-topic Greedy / Two Pointers transfer |
| 38 | Average Height of Buildings in Each Segment | Sweep weighted events and emit maximal constant-average segments | Advanced sweep aggregation |
| 39 | Merge Intervals on Circular Range (custom) | Split at wrap boundary, merge linear pieces, reconcile junction | Diagnostic / custom edge case; complete statement required |
| 40 | Maximum Number of Events That Can Be Attended | Day-by-day sweep with min-heap of available event ends | Diagnostic against incorrect activity-selection shortcut |
| 41 | Meeting Rooms III | Two heaps: free room IDs and occupied rooms ordered by end time | Advanced scheduling simulation |
| 42 | Remove Interval | Subtract one interval; handle left/right remainders and full removal | Diagnostic / operation semantics |
| 43 | Employee Free Time (Trap Variant) | Merge globally across employees before taking complement | Diagnostic reinforcing #11; avoid duplicate full exercise |

### Recommended concept paths

1. **Static interval operations:** #1 → #2 → #3 → #9.
2. **Greedy interval selection and coverage:** #5 → #6 → #12 → #14; #13 and #37 as cross-topic reductions.
3. **Concurrency and sweep lines:** #7 → #18 → #22 → #25 → #38.
4. **Dynamic interval sets:** #16 → #17 → #15 → #19 → #20 → #21 → #27.
5. **Weighted scheduling:** #29 → #30 → #31 → #32; explicitly contrast greedy regret with DP.
6. **Offline processing:** #4 → #33.
7. **Pattern selection:** #10, #35, #40, #42, #43.

### Changes recommended (not yet applied)

- Keep #10 and #35 only as diagnostic "not an interval problem" examples; do not require them as interval-solving exercises.
- #40 is a valuable trap because earliest-end activity selection does not solve one-event-per-day scheduling; the heap/day sweep is a genuinely different algorithm.
- #23 is a useful alternate formulation of #7, but should be a short transfer check rather than another full core lesson.
- #31 and #32 are close variants of #30. Keep one as canonical weighted interval DP, and use the others to test whether learners can recognize the same recurrence under a different story/constraint.
- #11 and #43 are the same problem family; keep one canonical solution and make the trap variant a targeted cross-employee counterexample.
- #34 belongs primarily to Segment Tree; #28 belongs primarily to Prefix Sums + Greedy.
- The custom questions #33 and #39 require complete original statements, bounds, expected outputs, and source metadata.
- A final mastery challenge should combine event sorting, endpoint semantics, a heap/ordered structure, and a weighted or dynamic update; learners must select the correct structure from operation requirements.

---

## Topic 07 — Prefix Sums

**Inventory:** 30 placements; 29 Medium/Hard and 1 Easy reference.  
**Verdict:** **Strong, conceptually coherent progression from static prefix state to transforms, difference arrays, higher-order prefixes, and dynamic structures. Clarify ownership with BIT/Segment Tree and HashMap.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Range Sum Query Immutable | Sentinel prefix array; range sum is difference of two prefix states | Core foundation |
| 2 | Subarray Sum Equals K | Prefix-difference equality plus frequency map; count prior states | Core progression; cross-link HashMap |
| 3 | Subarray Sums Divisible by K | Modular equivalence classes of prefix states | Core progression |
| 4 | Continuous Subarray Sum | Store first index of residue; enforce minimum length | Core constraint extension |
| 5 | Contiguous Array | Transform 0/1 to −1/+1; equal prefix state yields balanced range | Core transformation |
| 6 | Running Sum of 1D Array | The prefix array itself is the output; no query structure needed | Easy reference / method-selection diagnostic |
| 7 | Sum of All Odd Length Subarrays | Per-index contribution counting instead of enumerating ranges | Core alternate derivation |
| 8 | Minimum Value to Get Positive Step by Step Sum | Prefix minimum determines required initial offset | Core prefix-extremum use |
| 9 | Range Sum Query 2D Immutable | 2D prefix table and four-corner inclusion-exclusion | Core dimensional extension |
| 10 | Number of Submatrices That Sum to Target | Compress row/column pairs and apply 1D prefix + HashMap | Integration; cross-link Kadane/HashMap |
| 11 | Range Addition | Difference array: invert range updates into two boundary writes | Core inverse operation |
| 12 | Car Pooling | Prefix-summed difference array with capacity feasibility | Reinforcement / resource constraint |
| 13 | 2D Range Add, Point Query (custom) | Four-corner 2D difference update and reconstruction | Core custom extension; statement required |
| 14 | Product of Array Except Self | Prefix/suffix products without division | Distinct associative aggregate; do not conflate with sum prefix |
| 15 | Product of the Last K Numbers | Dynamic prefix products with zero reset | Core dynamic extension |
| 16 | Make Sum Divisible by P | Modular prefix state and shortest removable subarray | Integration with HashMap/Sliding Window |
| 17 | Longest Well-Performing Interval | Transform score to ±1 and find longest later-prefix-greater-than-earlier-prefix using monotone stack | Advanced integration |
| 18 | Sum of Total Strength of Wizards | Prefix of prefix plus monotonic-stack ownership boundaries | Advanced integration |
| 19 | Can Make Palindrome from Substring | Prefix XOR bitmask encodes character parity in a range | Core bitmask transformation |
| 20 | Number of Wonderful Substrings | Prefix parity masks + frequency map over masks differing by ≤1 bit | Advanced integration |
| 21 | Count of Range Sum | Inequality over prefix differences; merge-sort counting or BIT with compression | Advanced core; equality-map boundary |
| 22 | Split Array with Equal Sum | Multiple split points and prefix-set intersection | Advanced multi-boundary reasoning |
| 23 | Range Sum Query Mutable | Fenwick Tree supports point update and prefix query in logarithmic time | Move primary ownership to BIT; bridge |
| 24 | Range Sum Query 2D Mutable | 2D BIT for dynamic updates and rectangle queries | Move primary ownership to BIT |
| 25 | Longest Increasing Subsequence II | Value-domain prefix maximum via segment tree | Move primary ownership to LIS / Segment Tree |
| 26 | CF 295A Greg and Array | Difference array over operation indices, then difference array over target indices | Core second-order difference |
| 27 | Haybale Stacking (custom) | Large-axis range increments with O(n+q) difference array | Reinforcement; source/statement required |
| 28 | Sliding Window Maximum | Prefix maxima have no inverse; monotonic deque is the correct range structure | Diagnostic trap; cross-link Sliding Window |
| 29 | Shortest Subarray with Sum at Least K | Inequality plus negatives requires monotonic deque over prefix states | Diagnostic / advanced prefix-deque path |
| 30 | Maximum Subarray | Prefix minimum is valid but Kadane is the O(1)-space canonical formulation | Diagnostic method-selection check |

### Recommended concept paths

1. **Static prefix state:** #1 → #2 → #3 → #4 → #5.
2. **2D inclusion-exclusion:** #1 → #9 → #10.
3. **Range updates:** #11 → #12 → #26 → #13; #27 as a large-coordinate transfer.
4. **Prefix aggregates and transforms:** #14 → #15; #19 → #20.
5. **Prefix extrema and order statistics:** #8 → #17 → #18 → #21 → #22.
6. **Dynamic range-query boundary:** #23 → #24 → #25, then cross-link to BIT/Segment Tree/LIS.
7. **When prefix arrays are insufficient:** #28 → #29.

### Changes recommended (not yet applied)

- #2–#5 are a good progressive sequence: equality counting → residue equivalence → first-index/length condition → state transform.
- Distinguish **prefix sum**, **difference array**, **prefix XOR**, and **prefix product** as separate algebraic families with a shared prefix-state abstraction.
- #23–#25 should not duplicate the BIT/Segment Tree/LIS topics. Keep them as bridges and cross-topic assessments, with the canonical full treatment in the dedicated data-structure topic.
- #17 and #18 are strong advanced capstones, but their monotonic-stack ownership boundaries must be explained and proved.
- #21 is a valuable transition from equality lookup to inequality counting; require a clear explanation of why HashMap equality lookup cannot solve the range inequality.
- #28 and #30 should remain diagnostic traps only; their purpose is choosing a better technique, not learning prefix arrays again.
- Custom #13 and #27 require complete statements and constraints before being treated as canonical questions.
- Final capstone: combine 2D compression, prefix-state counting, and a data structure (merge-sort counting/BIT) under a constraint that makes the naive O(n²) or HashMap approach insufficient.

---

## Status

Topics 01–07 have now received progressive concept-delta reviews. Topics 08–43 remain for the next audit pass. No live curriculum records have been modified.
