# Mastery Audit — Batch 1: Topics 1–10

**Audit date:** 2026-11-10  
**Evidence:** Production topics, topic_content, required problem placements and problem_playback.  
**Important:** Concept mapping below is based on stored problem identities and metadata. It is not a claim that explanations or Java code have been verified.

## Batch verdict

| Topic | Required | Concept coverage | Main finding | Solution / Java readiness |
|---|---:|---|---|---|
| Two Pointers | 27 | Partial | Broad variants, but path taxonomy conflates read/write, partition and cycle detection | Not verified |
| HashMap | 27 | Partial | Rich map patterns; some placements primarily teach graph/DP/binary search | Not verified |
| Binary Search | 30 | Partial | Broad search spaces; predicate proofs need to be explicit | Not verified |
| Sliding Window | 46 | Partial | Very broad, likely redundant formulations; needs pruning by learning objective | Not verified |
| Kadane | 17 | Partial | Includes adjacent prefix/2D/interval techniques under one label | Not verified |
| Intervals | 31 | Partial | Static, sweep, dynamic and weighted interval families need separation | Not verified |
| Prefix Sums | 24 | Partial | Broad coverage; BIT and advanced range-counting need clear primary ownership | Not verified |
| Backtracking | 33 | Partial | Strong breadth, but search, BFS, DP and exact-cover hybrids need classification | Not verified |
| Greedy | 33 | Partial | Strong examples; correctness proof families need explicit instruction | Not verified |
| Sieve | 15 | Partial | SPF/sieve applications present; advertised linear sieve and Möbius coverage unclear | Not verified |

No topic in this batch is certified Strong. This is an evidence-based decision: the required problem lists and one-line insights are not enough to certify teaching quality.

## Topic 1 — Two Pointers (27 required)

**Concept inventory:** sorted opposite-end pair search; k-sum enumeration; duplicate suppression; pair counting; opposite-end optimisation; Floyd cycle detection and cycle entry; fast/slow middle and kth-from-end; implicit functional graphs; in-place read/write compaction; Dutch National Flag; two sorted arrays; boundary filling; reversal; string scans; greedy sorted extremes; multi-stream scans.

**Required mapping:** LC 167 teaches sorted pair search; 15/18/16/259/923 teach k-sum enumeration or counting; 11 teaches opposite-end optimisation; 1498/2563/633 teach pair-count/boundary variants; 142/19/287/457 teach cycle and fast/slow variants; 143 teaches middle/reverse/merge; 75 teaches three-way partition; 80/443 teach read/write transformations; 42 teaches two-boundary water accumulation; 189/31 teach reversal/suffix transformations; 881/948 teach greedy sorted extremes; 1855 teaches two-array scanning; 838 teaches fill-between-anchors; 2332 teaches two sorted streams with capacity; 845 teaches mountain boundary scanning.

**Issues:** The path called fast/slow cycle detection incorrectly contains LC 80 and 443, which are read/write transformations. LC 75 needs a full three-region loop invariant. The basic Floyd meeting and cycle-length derivation must be taught explicitly; cycle-entry problems alone do not guarantee this. LC 15/18/259/923 overlap and must each demonstrate a distinct objective. LC 845 is a mountain scan, not a canonical two-pointer core problem.

**Solution evidence:** Three playback records exist in this topic (LC 167, 15, 11); inspected snippets are Python-style, not verified Java implementations.

**Recommendation:** Separate sorted scans, fast/slow, read/write, three-way partition and boundary transformations. Do not add questions until this reclassification and solution audit is complete. **Verdict: Partial concept coverage; Java not verified.**

## Topic 2 — HashMap (27 required)

**Concept inventory:** complement lookup; frequency maps; canonical grouping; prefix-state sum/remainder/balance maps; first-seen index; HashSet chain starts; composite keys; Java equality/hash contracts; bidirectional maps; map plus DLL/buckets; reverse sparse-domain mapping; graph identity cloning; parsing aggregation; per-key ordered history; map + heap.

**Required mapping:** LC 49 canonical grouping; 560/525/974 prefix-state maps; 347/299/554/447 frequency; 128 set membership; 454/1711/2023 complements; 146/460/432/895 stateful map structures; 1396 composite keys; 710 reverse mapping; 535 bidirectional map; 726 parser aggregation; 149 slope keys; 355 map + heap; 472 dictionary + DP/DFS; 981 map + binary search; 138/133 identity maps; 269 adjacency map + topological sort.

**Issues:** LC 269 primarily teaches topological ordering; LC 472 word-break DP/DFS; LC 981 per-key binary search; LC 133 graph traversal. Retain only when map-specific invariants are deliberately taught. The material mentions equals/hashCode but does not demonstrate collision handling, resizing, load factor, hash flooding/worst-case behaviour, or alternatives such as direct-address arrays and TreeMap. Stateful structures need per-operation invariants, eviction/tie rules and Java implementation checks. Prefix-state questions overlap Topic 7 and should have one primary owner.

**Recommendation:** Add an explicit Java HashMap internals lesson, not more basic lookup questions. Reclassify cross-topic combinations where the map is incidental. **Verdict: Partial concept coverage; Java not verified.**

## Topic 3 — Binary Search (30 required)

**Concept inventory:** exact search; lower/upper bounds; rotated arrays with/without duplicates; first-true/last-true predicates; minimum/maximum feasible answer; feasibility proof; kth partition of two arrays; matrix and multiplication-table counting; peak/mountain search; exponential search; floating-point search; pigeonhole/counting search; greedy/DP feasibility.

**Required mapping:** LC 34/1268 lower bounds; 33/153/81/154 rotated arrays; 162/1095 peak/mountain; 74/240 matrix search; 875/1870/1011/410/1283/1802/1760/1231/2141/1482 answer-space search; 4 kth partition; 719/378/668 count-based answer search; 774 floating point; 1552 greedy feasibility; 702 exponential search; 287 pigeonhole count.

**Issues:** A general first-true/last-true template with invariant and termination proof is missing from the visible concept map. Every answer-search problem should prove monotonicity. LC 287 must teach the count-based pigeonhole proof and contrast it with Floyd's alternative in Topic 1. Floating-point search needs precision and stopping criteria. Java implementations need overflow-safe midpoint and long arithmetic for sums/products/ceil division. Several minimise-answer problems may be redundant unless their feasibility functions teach distinct structures.

**Recommendation:** Strengthen predicate design and proof; prune repetitive feasibility exercises only after reviewing explanations. **Verdict: Partial concept coverage; Java not verified.**

## Topic 4 — Sliding Window (46 required)

**Concept inventory:** fixed windows; variable windows; at-most-K and exact-K; frequency/multiplicity constraints; replacement budgets; count-valid-extensions; monotonic deque; sliding median with two heaps and lazy deletion; bitwise AND window; sum-times-length score; circular and complement windows; sorted frequency window; multi-offset word concatenation; difference-array expiration; sorted prefix/suffix boundary scans.

**Required mapping:** LC 209/3/424/76/395/340/904/992/2958 variable windows; 567/438/30/2953 fixed string windows; 1004/1493/1248/930 exact-K or at-most-K; 1438/239/2398/1499 monotonic deque; 480 two heaps; 1695/2461/2401 distinctness/bitmask; 2302 score monotonicity; 1358/2962/2799/2444 boundary counting; 1838 sorted frequency window; 1052/1456/1343/2090/2134/1151 fixed width; 1234/1423/2516 complement windows; 995 difference-array expiration; 1574/2009/2972 sorted boundary techniques.

**Issues:** 46 is a high count and should trigger a redundancy audit. LC 1574/2009/2972 are not canonical windows and need explicit distinct objectives. Explain when window validity is monotone and why negative numbers break common sum-window logic. Prove deque amortised complexity. Explain why stale max frequency in LC 424 is safe. LC 480 needs duplicate-safe lazy deletion and heap-size accounting. LC 995 needs an explicit active-flip expiration invariant.

**Recommendation:** No additions. Build a smallest-complete representative set by invariant, and demote repeated formulations to optional practice. **Verdict: Partial breadth; Java not verified.**

## Topic 5 — Kadane (17 required)

**Concept inventory:** maximum/minimum subarray recurrence; max/min product states; circular complement; absolute sum; one deletion; concatenation; difference-array transformation; length-constrained subarray via prefix minima; 2D compression with ordered prefixes; multiple non-overlapping segments; character-pair variance.

**Required mapping:** LC 53 standard; 152 product max/min; 918 circular; 1749 absolute; 1186 deletion; 1191 concatenation; 2321 difference between arrays; 2393/2414 scan/count variants; 2272 character variance; 363 ordered prefix set; 1074 2D prefix/hash map; 689 multiple segments; 1031 fixed windows; 1537 two-path synchronisation; custom length-at-least-K and minimum-subarray exercises.

**Issues:** LC 1031 is fixed-window optimisation; 1537 is path synchronisation; 1074 is 2D prefix + HashMap; 363 uses ordered prefix sums. These are reductions/adjacent techniques, not all Kadane. LC 2272 needs the two-character projection proof. Circular maximum needs the all-negative guard. LC 689 uses left/right best arrays and should be taught distinctly.

**Recommendation:** Divide into true Kadane, Kadane-derived transformations and adjacent combinations. Keep only distinct required learning objectives. **Verdict: Partial concept coverage; Java not verified.**

## Topic 6 — Intervals (31 required)

**Concept inventory:** merge/insert/intersect; endpoint semantics; interval scheduling; stabbing/covering; partitioning/peak concurrency; weighted scheduling; sweep line; difference arrays; skyline; dynamic interval sets; minimum containing interval queries; complement/free time; union length.

**Required mapping:** LC 56/57/986/228 merge and intersection; 435/452/1326/1024/45 scheduling/covering; 253/2406 concurrency/partitioning; 252/729/731/732 calendar overlap; 1288 containment; 759 complement; 1851 minimum containing interval; 218 skyline; 715/352/2276 dynamic interval structures; 2779/1943/2237/2158/1589/2015 sweep/difference; 1235/2054/2008 weighted scheduling.

**Issues:** LC 45 belongs primarily to Greedy interval cover. Endpoint inclusivity and equal-coordinate event ordering need explicit teaching. Dynamic interval problems use different structures and should not be presented as one generic solution. Weighted scheduling needs predecessor search plus DP, distinct from unweighted scheduling. Range-difference problems overlap Topic 7 and require clear primary ownership.

**Recommendation:** Split static scheduling, sweep, dynamic structures and weighted scheduling paths. Cross-reference rather than duplicate. **Verdict: Partial concept coverage; Java not verified.**

## Topic 7 — Prefix Sums (24 required)

**Concept inventory:** 1D prefix conventions; range differences; prefix-state hashing; prefix minima; 2D inclusion-exclusion; difference arrays; products; append-only product streams; prefix XOR/parity; prefix-of-prefix; range counting with merge sort/BIT; multi-split intersections.

**Required mapping:** LC 303/560/974/523/525 basic and transformed prefixes; 1588/1413 contribution and minimum; 304/1074 2D; 370/1094/2237/CF 295A/Haybale Stacking difference arrays; 238/1352 products; 1590/1124 constrained prefix; 2281 prefix-of-prefix; 1177/1915 XOR masks; 327 range counting; 548 split intersection; 307 mutable range sum/Fenwick.

**Issues:** LC 307 is primarily Fenwick Tree and should be cross-referenced with Topic 11. LC 327 is an advanced range-counting structure. LC 1074 is a 2D compression combination. Half-open boundaries, overflow and difference-array sentinels need explicit Java implementation. Prefix XOR should link to bit manipulation and string parity.

**Recommendation:** Keep Prefix Sums foundational; move advanced data-structure ownership to BIT/range-counting topics where appropriate. **Verdict: Partial concept coverage; Java not verified.**

## Topic 8 — Backtracking (33 required)

**Concept inventory:** include/exclude; combinations/permutations; duplicate suppression; bounded/unbounded reuse; partitioning; grid paths; constraint satisfaction; propagation/forward checking; expression parsing; bijection matching; Trie-guided search; exact cover/DLX; branch-and-bound; memoised residual state; symmetry breaking; BFS hybrids.

**Required mapping:** LC 78/77/46/90/40/39/47/216/784/254 enumeration; 131/93/1593 partitioning; 79/980/351 grid/graph paths; 51/52/37/526 constraint satisfaction; 282 expression state; 140/291 reconstruction and bijection; 425 Trie-guided search; CF 1097F exact-cover-like recognition (verify statement); 996/1255 subset pruning; 1240 branch-and-bound; 488/301 BFS hybrids; 691 memoised residual state.

**Issues:** LC 301 requires BFS by removal depth to guarantee minimum removals. LC 488 needs canonical state compression and search strategy comparison. LC 996/1255 overlap bitmask DP. The exact-cover metadata claim is not evidence of Algorithm X/Dancing Links unless cover/uncover and column-selection heuristics are implemented. Complexity, pruning effectiveness and recursion safety need explicit instruction.

**Recommendation:** Organise by search paradigm and verify exact-cover content. Do not add generic permutation/subset questions. **Verdict: Partial concept coverage; Java not verified.**

## Topic 9 — Greedy (33 required)

**Concept inventory:** exchange arguments; stays-ahead; interval coverage; circular feasibility; scheduling; regret/deferred decisions; heap/event simulation; binary-search feasibility; deque feasibility; ratio search + DP hybrid; matroid greedy; two-pass constraints; prefix-average bounds; bounded transformations; comparator proofs; DSU/heap combinations.

**Required mapping:** LC 1029/179/406/2279/2449/2551 sorting/exchange; 55/763/1520 reachability/interval closure; 134/860/1975 stateful/circular; 621/1353/630/1834 scheduling; 1642/871 regret; 1675 bounded transform; 2071 binary search + deque; Talent Show ratio search + knapsack; custom weighted matroid/graphic forest; 1578/1921/846/1899/2439/1383/2571 specialised greedy; 678/2116 balance constraints; 948 token decisions; 135 two-direction constraints.

**Issues:** The topic needs explicit proof families and counterexamples, not only local choice descriptions. Talent Show is a hybrid, not pure greedy. The custom matroid exercise needs a complete statement, independence condition and exchange proof. LC 1383 is partly Top-K/heap; explain which concept is primary. LC 45 should be cross-referenced for interval-cover greedy.

**Recommendation:** Upgrade proofs and counterexamples; label hybrid patterns clearly. **Verdict: Partial concept breadth; Java not verified.**

## Topic 10 — Sieve of Eratosthenes (15 required)

**Concept inventory:** classic sieve; p-squared start; prime queries; SPF factorisation; linear sieve; segmented sieve; totient; multiplicative functions; squarefree kernels; factor connectivity with DSU; sieve + stack/BIT/DP; Möbius inversion.

**Required mapping:** LC 204/2761/1175/2523 classic sieve; 2601/3233 prime transformations; 3326/2584/2862 SPF; 1998/952 factor connectivity; 2818 distinct-prime score + stack + BIT; 2338 SPF + stars-and-bars; custom totient and segmented sieve.

**Issues:** Linear sieve, Möbius function/inversion and divisor functions appear in topic metadata but do not have clearly identified required implementations. Miller–Rabin, Pollard Rho, extended Euclid, modular inverses and CRT are broader number theory and need a separate concept inventory. The custom totient insight contains a suspect claim that a prefix sum of φ directly answers arbitrary coprimality counts over [L,R] adjusted for M; correct this before teaching. Segmented sieve must handle L=0/1, p², ceiling multiples and 64-bit overflow.

**Recommendation:** Keep sieve/SPF focused here; evaluate a separate Number Theory family after mapping overlaps. Correct the totient exercise. **Verdict: Partial concept coverage; Java not verified.**

## Cross-topic actions

1. Establish one primary owner for every algorithmic learning objective; use cross-references instead of duplicate required placements.
2. Separate concept ownership from the problem's surface pattern. A problem may combine techniques but should not be counted as full mastery evidence for all of them.
3. Add explicit proof lessons to Two Pointers, Binary Search and Greedy.
4. Prune Sliding Window and k-sum repetitions only after reviewing the full explanation and constraints.
5. Review all custom exercises for mathematical correctness and complete statements.
6. Locate Java implementations outside problem_playback before concluding they are absent.
7. Do not add questions in Batch 1 yet. First close classification and artifact-quality gaps.

## Solution artifact baseline

The production problem_playback table contains 11 solution records associated with required placements out of 919. The inspected records contain Python-style code/pseudocode, not verified Java implementations. This is only a finding about the playback table; repository Java source files must still be located and audited.

**Batch 1 final:** Concept breadth is substantial, but all ten topics remain Partial or Not verified. None can yet be certified mastery-ready. No new question is justified by this batch before the solution/code audit and redundancy review.
