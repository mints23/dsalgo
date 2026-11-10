# Progressive Concept Audit — Phase 2A (Topics 10–12)

**Source:** Live production `public.problems` rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 10 — Sieve of Eratosthenes

**Inventory:** 18 placements; 17 Medium/Hard and 1 row with missing difficulty.  
**Verdict:** **A focused sieve topic with a good progression from primality precomputation to SPF-based factorization and algorithmic combinations. The broader number-theory curriculum is still incomplete.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Count Primes | Classic sieve; start crossing multiples at p² | Core foundation |
| 2 | Prime Pairs With Target Sum | Reuse precomputed primes as a sorted two-sum domain | Reinforcement / transfer |
| 3 | Prime Arrangements | Count primes then apply factorial combinatorics | Integration with modular combinatorics |
| 4 | Closest Prime Numbers in Range | Sieve a bounded interval and scan adjacent primes | Core range query |
| 5 | Prime Subtraction Operation | Sieve plus greedy choice / binary search for valid prime | Integration |
| 6 | Count Numbers Which Are Not Special | Translate divisor-count definition into prime-square counting | Core mathematical reduction |
| 7 | Min Division Ops — Non-Decreasing | Smallest-prime-factor table plus right-to-left greedy repair | Core SPF progression |
| 8 | Split Array — Coprime Products | SPF factorization plus prefix tracking of prime factors crossing a split | Integration |
| 9 | Max Element-Sum of Complete Subset | Squarefree-kernel grouping via prime factorization | Core number-theory concept |
| 10 | GCD Sort of an Array | Connect values sharing prime factors using DSU; sortability becomes component reachability | Advanced integration |
| 11 | Apply Operations to Maximize Score | SPF prime-factor score + monotonic stack ownership + BIT counting | Advanced multi-technique integration |
| 12 | Count the Number of Ideal Arrays | Factor multiplicative chains into prime exponents and apply stars-and-bars DP | Advanced combinatorics integration |
| 13 | Largest Component by Common Factor | Sieve-like factor enumeration plus DSU connectivity | Reinforcement of #10 with value-range traversal |
| 14 | Euler's Totient Sieve — Range Sum Queries (custom) | Compute φ with a prime sieve and prefix-aggregate the results | Core number-theory extension; custom statement needs clarification |
| 15 | Segmented Sieve — Primes in [L,R] (custom) | Sieve to √R, then mark only a bounded interval to support huge coordinates | Advanced sieve extension; bounds/source required |
| 16 | Kth Factor of N | Trial division for one small query is better than constructing a sieve | Diagnostic trap |
| 17 | Ugly Number II | Sparse multiplicative sequence via three-pointer DP, not prime enumeration | Diagnostic trap / cross-link DP |
| 18 | Don't sieve per element | Move factor enumeration from each number to one value-range sieve pass | Diagnostic trap; same LC 952 appears as canonical DSU+factorization in #13 |

### Recommended concept paths

1. **Sieve basics and applications:** #1 → #2 → #4 → #6.
2. **SPF and factorization:** #1 → #7 → #8 → #9 → #10 → #13.
3. **Sieve + other algorithms:** #10 → #11 → #12.
4. **Range scale:** #1 → #15.
5. **Method selection:** #16 → #17 → #18.

### Changes recommended (not yet applied)

- Keep the topic as the canonical home for sieve construction, SPF, segmented sieve, and factorization.
- #18 should be a targeted performance diagnostic for #13, not a second full problem; same LC identity, different complexity lens.
- #10 and #13 are related but not identical: one connects array values by shared prime factors; the other builds factor connectivity using a sieve-style pass. Make that difference explicit.
- #11 is an excellent capstone but its monotonic-stack ownership and BIT counting derivation must be proved.
- #14 and #15 require complete custom statements, constraints, and sources. The current totient row's wording about range queries should be validated against its actual problem contract.
- The topic does not replace a full Number Theory topic. Add a separate curriculum path only after covering gcd/extended Euclid, modular inverse, fast exponentiation, CRT, divisor functions, primality beyond a bounded sieve, and combinatorics without duplicating DP.

---

## Topic 11 — Fenwick Tree / Binary Indexed Tree

**Inventory:** 18 placements; 17 Medium/Hard and 1 Easy reference.  
**Verdict:** **Strong progression from point-update/prefix-query to coordinate-compressed order statistics and offline counting. A few rows need algorithm/ownership verification.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Range Sum Query — Mutable | BIT lowbit navigation; point delta update and prefix difference query | Core foundation |
| 2 | Count Number of Teams | Count smaller/greater values on each side of a middle position | Core progression |
| 3 | Count of Smaller Numbers After Self | Reverse processing plus coordinate compression for dynamic rank | Core progression |
| 4 | Reverse Pairs | Compress both values and doubled values; inequality is not ordinary inversion counting | Core constraint mutation |
| 5 | Create Sorted Array Through Instructions | Query counts on both sides of insertion rank and take minimum | Reinforcement |
| 6 | Number of Pairs Satisfying Inequality | Algebraic rearrangement turns pair inequality into a rank query | Core reduction |
| 7 | Count of Range Sum | Prefix sums + coordinate compression + BIT to count a value interval | Integration; cross-link Prefix Sums |
| 8 | Count Good Triplets in an Array | Position mapping across two permutations and count valid earlier/later elements | Advanced integration |
| 9 | The Skyline Problem | Sweep-line plus active-height maximum under insertions and deletions | Review: max-BIT deletion semantics; likely Segment Tree/ordered multiset canonical |
| 10 | Maximum Sum Queries | Offline sorting on one dimension and BIT prefix maximum on another | Advanced offline query pattern |
| 11 | Range Sum Query 2D — Mutable | Nested BITs for point updates and 2D prefix/rectangle queries | Core dimensional extension |
| 12 | Make Array Empty | BIT tracks removed positions to calculate circular shifts / rank of live elements | Advanced order-statistic application |
| 13 | Distribute Elements Into Two Arrays II | Coordinate-compressed suffix counts decide which destination has more greater elements | Advanced rank-query application |
| 14 | Range Update + Range Sum Query (Two-BIT Template, custom) | Difference-array derivation represented by two BITs for range add + range sum | Core BIT extension; custom statement and indexing convention required |
| 15 | K-th Smallest in Dynamic Multiset (custom) | Binary lifting on BIT internal partial sums for O(log N) order-statistic selection | Advanced core; source/constraints required |
| 16 | Count Distinct LIS Sequences — BIT-Augmented O(N log² N) (custom) | BIT/segment-tree state over value ranks for LIS length and counts | Review algorithm carefully; the described conditional-count aggregation may need a segment tree or richer monoid, not two independent ordinary BITs |
| 17 | Subarray Sum Equals K | Static equality counts need HashMap, not a dynamic rank structure | Diagnostic trap |
| 18 | Range Sum Query — Immutable | Static queries are O(1) with prefix array; BIT is unnecessary | Easy reference / diagnostic trap |

### Recommended concept paths

1. **Dynamic prefix sums:** #1 → #2 → #3 → #4 → #5 → #6.
2. **Offline range counting:** #7 → #8 → #10.
3. **Higher dimensions:** #1 → #11.
4. **Order statistics:** #3 → #12 → #13 → #15.
5. **Range updates:** #14.
6. **Method selection:** #17 → #18.

### Changes recommended (not yet applied)

- Teach the BIT invariant from the internal tree structure and lowbit decomposition, not only as a code template.
- Explicitly separate point-update/prefix-query, range-update/range-query, order-statistic search, and offline sweep use cases.
- #9 requires correctness review: a standard Fenwick tree does not support arbitrary deletion of a maximum while preserving max queries. If a max-BIT variant is intended, explain its monotonic-update restrictions; otherwise move to Segment Tree.
- #16 requires algorithm validation before inclusion. The current description claims conditional aggregation of counts at the maximum LIS length using separate BITs; this is not automatically supported by ordinary additive BIT semantics.
- #7 overlaps with Prefix Sums; #11 overlaps with Prefix Sums 2D BIT; #9 overlaps with Segment Tree and Intervals. Keep one canonical full solution per question and use the other topic as a focused transfer assessment.
- #14 and #15 need full problem statements, exact indexing (0-based/1-based), input domain, and source.
- Final capstone: process a stream of updates and rank/range queries with a large value domain; learner must decide between a BIT, two BITs, coordinate compression, order-statistic binary lifting, and Segment Tree.

---

## Topic 12 — Segment Tree

**Inventory:** 20 placements; all Medium/Hard.  
**Verdict:** **Excellent advanced breadth. The progression should teach node summaries and merge functions before lazy propagation, then persistence, implicit trees, and Beats.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Range Sum Query — Mutable | Segment tree build, point update, range aggregate | Core foundation |
| 2 | My Calendar II | Lazy range add and global maximum; reject triple booking | Core lazy propagation |
| 3 | My Calendar III | Same range-add/max structure but always accept and return max; large coordinate domain | Core extension; implicit tree if coordinate range is huge |
| 4 | Range Module | Lazy range assignment and covered-range aggregation | Core lazy assignment |
| 5 | Fancy Sequence | Compose non-commuting affine updates (multiply then add) | Core lazy-composition concept |
| 6 | Falling Squares | Coordinate compression plus range maximum and range assignment | Core geometric range update; correct endpoint compression needs review |
| 7 | Longest Substring of One Repeating Character | Custom node summary: max run, prefix run, suffix run, length | Core custom monoid / merge function |
| 8 | Max Sum Subsequence — Non-Adjacent | Four-state take/skip boundary DP stored in each node | Advanced DP-node integration |
| 9 | Rectangle Area II | Sweep line plus compressed coverage-length segment tree | Advanced geometric integration |
| 10 | Booking Concert Tickets in Groups | Search under simultaneous prefix-sum and suffix-maximum constraints | Advanced guided descent / multi-aggregate query |
| 11 | Online Majority Element in Subarray | Merge-sort tree with Boyer–Moore candidate and frequency verification | Advanced tree-of-sorted-lists integration |
| 12 | Minimum Time to Complete All Tasks | Greedy latest-slot assignment with lazy range assignment / free-slot search | Advanced Greedy + Segment Tree |
| 13 | Find Building Where Alice and Bob Can Meet | Offline query handling plus first-index-greater-than-threshold descent | Advanced guided search |
| 14 | Count Integers in Intervals | Implicit dynamic segment tree over a huge coordinate domain | Core implicit-tree pattern; cross-link Intervals |
| 15 | Subarrays Distinct Element Sum of Squares II | Contribution counting translated into range-add/range-sum updates | Advanced lazy integration |
| 16 | Persistent Segment Tree — K-th Smallest in Static Range (custom) | Path-copy versions; subtract prefix-root counts and descend for k-th value | Advanced persistence; statement/source required |
| 17 | Segment Tree Beats — Range Chmin + Range Sum (custom) | Store max1/max2/countMax/sum; apply lazy chmin only when second max proves it safe | Apex advanced structure; full proof and amortized analysis required |
| 18 | Sliding Window Maximum | Static window maximum is O(N) with monotonic deque; segment tree is unnecessary overhead | Diagnostic trap |
| 19 | My Calendar I | Ordered interval predecessor/successor is enough for simple conflict detection | Diagnostic trap / cross-link Intervals |
| 20 | Corporate Flight Bookings | Static range updates are best handled by a difference array | Diagnostic trap / cross-link Prefix Sums |

### Recommended concept paths

1. **Basic aggregate and node merge:** #1 → #7 → #8.
2. **Lazy propagation:** #2 → #3 → #4 → #5 → #6.
3. **Sweep / geometry:** #9.
4. **Guided descent and multiple aggregates:** #10 → #13.
5. **Tree variants:** #11 → #14 → #16 → #17.
6. **Range-update integration:** #12 → #15.
7. **Method-selection traps:** #18 → #19 → #20.

### Changes recommended (not yet applied)

- The topic has good advanced coverage, but the first few problems should explicitly teach the segment-tree monoid: what a node stores, how two children combine, and why the summary is sufficient.
- #7 and #8 are especially valuable because they force learners to design nontrivial node merge functions. Use them to establish a reusable custom-node design method.
- #5 must explicitly derive lazy-tag composition order; affine transforms are non-commutative.
- #6's current key insight says "floating-point interval endpoints"; validate whether that is actually true for the LeetCode input. If endpoints are integers, use exact coordinate compression and avoid introducing a false constraint.
- #9 appears in Intervals and Fenwick topics; keep Segment Tree as the canonical solution for dynamic covered-length aggregation, and cross-link other topics.
- #14 also appears in Intervals as a dynamic interval-union problem; teach the difference between a TreeMap of disjoint intervals and an implicit segment tree, including workload-dependent trade-offs.
- #16 and #17 need complete statements, constraints, source references, implementation notes, and rigorous correctness/complexity proofs.
- #18–20 are valuable diagnostics; they should not inflate the core segment-tree concept count.
- Final capstone should require designing a custom node summary and lazy operation for an unfamiliar update/query pair, then defending merge correctness, lazy composition, and complexity.

---

## Status

Topics 01–12 have now received progressive concept-delta reviews. Topics 13–43 remain. No production curriculum rows have been modified.
