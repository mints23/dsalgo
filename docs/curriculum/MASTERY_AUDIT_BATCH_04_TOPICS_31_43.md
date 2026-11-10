# Mastery Audit — Batch 4: Topics 31–43

**Audit date:** 2026-11-10  
**Evidence:** Production required problem placements and stored concept metadata.  
**Status:** Concept ownership/progression audit; complete solution explanations and Java code are not yet verified.

## Batch verdict

| Topic | Required | Concept coverage | Main finding | Readiness |
|---|---:|---|---|---|
| 31. 2D Grid DP | 26 | Partial | Broad grid states; includes non-DP graph/stack/prefix algorithms | Not verified |
| 32. Knapsack | 29 | Partial | Strong knapsack family; includes meet-in-the-middle and binary-search feasibility | Not verified |
| 33. Strings & Subsequences | 23 | Partial | Good string DP; contains interval DP, Trie/Aho-Corasick and non-DP LCS reductions | Not verified |
| 34. State Machine DP | 24 | Partial | Good finite-state patterns; contains unrelated bitmask and grid DP | Not verified |
| 35. Interval DP | 23 | Partial | Broad interval recurrence family; some non-interval/combinatorial placements and duplicates | Not verified |
| 36. Partition DP | 24 | Partial | Strong segmentation DP; includes greedy, prefix query and optimisation concepts | Not verified |
| 37. Game Theory & Minimax | 22 | Partial | Good take-away and score-difference coverage; impartial/partisan and cyclic games need clarity | Not verified |
| 38. Tree DP | 30 | Partial | Deep coverage of rerooting, states, small-to-large and combinatorics; overlaps Trees | Not verified |
| 39. Digit DP | 22 | Strong breadth | Excellent state progression; matrix acceleration and advanced constraints need verified code | Not verified |
| 40. DAGs & Probability | 11 | Partial | DAG DP and stochastic DP are distinct families combined under one title | Not verified |
| 41. Combinatorial & Modulo DP | 12 | Partial | Rich combinatorics; number-theory foundations and proof accuracy need review | Not verified |
| 42. Data-Structure-Optimised DP | 21 | Partial | Advanced optimisations are present; some examples belong elsewhere and preconditions are critical | Not verified |
| 43. Profile / Broken Profile DP | 17 | Partial | Strong frontier DP coverage, but ordinary subset/bitmask problems are misclassified | Not verified |

## Topic 31 — 2D Grid DP (26 required)

**Concept inventory:** grid path counting; obstacles; min/max path cost; reverse DP for health/resource constraints; path counts with modular/property state; multi-agent synchronized movement; geometric-shape DP; implicit DAG grid paths; 2D compression and prefix structures; grid-to-histogram reductions; irregular geometry; multi-robot generalisation.

**Required mapping:** LC 62/63/64/120/931 basic paths; 174 reverse health; 221/1277 square DP; 1289 non-same-column transition; 1594 dual min/max; 576 step dimension; 1444 cut counting; 2435 modulo state; 1301 score + ways; 2304 transition costs; 1463/741 multi-agent; 2088 pyramids; 329 implicit DAG; 363 2D compression + ordered prefix; 85 histogram; CF 559C irregular lattice; Painting the Barn 2D difference; 2977 all-pairs conversion; custom K-agent DP.

**Issues:** LC 329 is DAG DP via memoised DFS and could be owned by DAG DP. LC 363 is 2D prefix + ordered set; LC 85 is histogram/monotonic stack. LC 2977 is all-pairs shortest path, not grid DP. These should not count as core grid-DP mastery unless the grid representation is genuinely the learning objective. Multi-agent states need explicit symmetry reduction and dimension bounds. Reverse DP (Dungeon Game) needs a derivation of minimum required health, not forward path-sum intuition.

**Recommendation:** Keep grid DP as a topic; reclassify adjacent graph/stack/APSP exercises and emphasise state dimensionality, transitions and memory reduction. **Verdict: Partial concept coverage; Java not verified.**

## Topic 32 — Knapsack Family (29 required)

**Concept inventory:** 0/1 subset sum; min/max/count variants; unbounded ordered vs unordered counting; bounded/grouped knapsack; multidimensional capacities; profit-capped dimensions; difference-state knapsack; row/group choice; complement counting; bitset subset sum; meet-in-the-middle; binary-search feasibility with knapsack; reconstruction; monotone-queue bounded optimisation.

**Required mapping:** LC 416/494/1049/2787/2915/2291/2742 0/1; 322/518/279/377/1449 unbounded; 474/879 multi-dimensional; 2585/1155/2902 bounded/grouped; 956 difference; 2518 complement; 2431 coupon state; 3082 weighted subsequence count; 1981 row-choice; 2035 meet-in-middle; 2560 binary search + feasibility; custom bitset subset sum; LC 2261/2857 explicitly marked traps.

**Issues:** LC 2035 is meet-in-the-middle, not a conventional knapsack DP; it is a valuable comparison but should be a separate concept owner or combination. LC 2560 is binary search on answer with greedy feasibility, not generic knapsack. LC 2261/2857 are traps and should not count as positive knapsack coverage. Need teach loop direction (descending for 0/1, ascending for unbounded), ordered vs unordered combination counting, zero-value/zero-weight edge cases, bounded binary grouping and reconstruction. Distinguish item-index DP from capacity DP and prove memory compression.

**Recommendation:** Keep the knapsack family, but reclassify meet-in-the-middle and binary-search hybrids. Ensure the custom bitset exercise explains machine-word complexity and limits. **Verdict: Partial concept coverage; Java not verified.**

## Topic 33 — Strings & Subsequences (23 required)

**Concept inventory:** LCS; edit distance; longest common substring; LPS; weighted LCS; distinct subsequence counting; SCS reconstruction; interleaving; regex/wildcard automata; subsequence product scoring; repeated substring; palindrome conversion; dictionary-column DP; suffix-state DP; multi-string LCS; circular string navigation.

**Required mapping:** LC 1143/72/718/516/712/583 LCS/edit family; 115/940 distinct subsequences; 1092 SCS; 97 interleaving; 10/44 regex/wildcard; 1458 product subsequence; 1062 repeated substring; 1312/1771/1216 palindrome variants; 1639 column DP; 514 circular ring; custom K-string LCS; LC 2312 interval DP on wood (misclassified); LC 1032 Aho–Corasick (trap, not DP); custom LCS via LIS encoding.

**Issues:** LC 2312 is interval DP over dimensions, not strings/subsequences. LC 1032 is reverse Trie/Aho–Corasick, not DP. LC 1062 uses LCS-of-string-with-itself but suffix automaton / rolling hash are distinct alternatives. LCS via patience sorting requires careful assumptions (permutation/unique matching or reduction details); it is not a generic O(n log n) LCS for arbitrary repeated symbols. Need distinguish subsequence vs substring and reconstruction vs length/count.

**Recommendation:** Keep the string DP family and remove/move non-DP placements. Advanced string matching (suffix array/automaton, Manacher, Aho–Corasick) should be inventoried with KMP/Trie rather than duplicated here. **Verdict: Partial concept coverage; Java not verified.**

## Topic 34 — State Machine DP (24 required)

**Concept inventory:** finite-state transitions; stock trading with cooldown/fees/transaction caps; alternating subsequences; sign-state tracking; deletion states; wiggle transitions; sequence-pattern counts; parity states; position/time states; expected-value states; bitmask states; DP + segment tree.

**Required mapping:** LC 122/714/309/123/188/custom cooldown stock; 2770 jumps; 1911 alternating; 1567 positive product; 1186 deletion; 376 wiggle; 2222 building patterns; 1537 path merge; 2640 prefix state; 1626 sorted team DP; 2019 wrong-answer bitmask; 1269 position/time; 2786 parity; 2435 grid modulo; 1434 hats; Sushi expected value; CF 833B segment tree DP; 1125/1799 bitmask DP.

**Issues:** LC 1125 and 1799 are bitmask DP, not state-machine DP in the stock/finite-state sense; LC 2435 belongs primarily Grid DP. LC 1537 is path merge. LC 2640 is prefix accumulation. Expected-value Sushi is a multi-dimensional stochastic DP. The topic needs a formal state graph and transition table approach, plus proof of state sufficiency (Markov property): all future decisions must depend only on the stored state. Need clarify transaction count convention and whether buy/sell increments transaction count.

**Recommendation:** Rebuild around explicit finite-state automata and transitions. Reclassify general bitmask, grid and prefix tasks unless their finite-state model is the primary lesson. **Verdict: Partial concept coverage; Java not verified.**

## Topic 35 — Interval DP (23 required)

**Concept inventory:** shrink-from-ends palindrome DP; split-point recurrence; matrix-chain/merge costs; minimax split; interval alignment across strings; last-operation transformation; constrained merge feasibility; third-dimension interval states; interval reconstruction; 2D partition costs; bracket boundary states; modular palindrome subsequences.

**Required mapping:** LC 516/1312/647 palindrome intervals; custom merge piles; LC 1039 triangulation; 375/486/877 minimax; 87 scramble; 664 printer; 312 burst balloons; 1000 merge stones; 1547 stick cuts; 546 remove boxes; 471 string encoding; 1246 palindrome removal; 1478 mailbox partition; 1770 two-boundary; 920 playlist counting (not conventional interval DP); CF 149D bracket colouring; 678 wildcard validity; EDPC N slimes; 730 distinct palindromic subsequences.

**Issues:** LC 920 is combinatorial counting DP over length/distinct songs, not interval DP. LC 678 is a string interval validity DP, but overlaps parsing/greedy. LC 877 Stone Game is duplicated with Game Theory; keep a single primary owner with a cross-reference. LC 1478 is partition DP with median segment cost, not necessarily interval DP in the canonical split-interval sense. Need establish dependency order (increasing interval length), recurrence boundaries, split-point enumeration and reconstruction. Knuth optimisation for Slimes requires quadrangle inequality/monotone opt proof; do not teach it as a generic speedup.

**Recommendation:** Retain interval DP but demote combinatorial non-interval placements and remove duplicate ownership. Keep the K-merge and last-burst examples as advanced anchors. **Verdict: Partial concept coverage; Java not verified.**

## Topic 36 — Partition DP (24 required)

**Concept inventory:** feasibility/count/min/max partition; exactly-k segments; bounded segment length; segment cost; palindrome partition; sequence parsing; all-partition enumeration; partition + prefix sums; partition + bitmask; D&C DP; CHT; group/knapsack constraints.

**Required mapping:** LC 139/91/2707/132/2522/1278/1043/2547/1335/813/410/1105/1531/1000/1473/140/2911/2478/3003/1977; LC 2055 is a prefix query, not DP; custom CF 1968F is described as D&C DP but verify the exact problem/technique; EDPC L Deque/CHT framing requires validation.

**Issues:** LC 2055 Plates Between Candles is a prefix/sparse query problem, not partition DP. LC 410 overlaps Binary Search on Answer and has a DP alternative; choose primary owner based on teaching objective. LC 1000 is also interval DP. LC 140 enumerates partitions and overlaps Backtracking. Need formal recurrence dp[k][i], segment-cost definition, transition proof and conditions for D&C optimisation/CHT. The CHT exercise must derive linear functions and slope/query order requirements.

**Recommendation:** Keep true segmentation DP and separate partition enumeration, prefix queries and interval merge. Add no generic word-break exercise if existing examples already cover feasibility and enumeration. **Verdict: Partial concept coverage; Java not verified.**

## Topic 37 — Game Theory & Minimax (22 required)

**Concept inventory:** normal-play impartial games; P/N positions; take-away games; Sprague–Grundy mex; disjunctive sums/XOR; score-difference minimax; interval games; move-budget state; hidden information/guaranteed cost; cyclic graph games with draws; multi-pile Nim; impartial vs partisan games; probability/health state game variants.

**Required mapping:** LC 292/1025/custom take-away; 877/486/1406/1563/1140/1872 score-difference and interval games; LC 1510 square moves; 1690 strategic picking with sorting (not adversarial minimax in the usual sense); 375 guaranteed cost; 464 bitmask win/loss; 913/1728 cyclic graph games; custom Grundy; 1908 multi-pile Nim; 810 XOR game; 294 string-state game; CF 850C disjunctive Grundy; CF 768E staircase Nim; Mortal Kombat tower DAG game.

**Issues:** LC 1690 is a greedy optimal strategy under the problem's scoring rule, not standard minimax; its classification should be explained. Cyclic graph games (LC 913/1728) require retrograde analysis and explicit draw state, not the acyclic Grundy recurrence. Distinguish impartial from partisan games, normal vs misère play, and when XOR is valid. The Sprague–Grundy theorem requires independent impartial subgames under normal play. Need prove mex construction and P/N recurrence.

**Recommendation:** Keep the game-theory family; organise by impartial acyclic games, score-difference minimax, cyclic retrograde games and Nim/Grundy. **Verdict: Partial concept coverage; Java not verified.**

## Topic 38 — Tree DP (30 required)

**Concept inventory:** postorder arm DP; prefix-sum path counting with rollback; tree independent set; signed subtree excess; directional states; top-two child contributions; top-down extrema; multi-state local constraints; rerooting; edge-direction flip counts; subtree frequency aggregation; subtree score products; ancestor value stacks; depth-indexed tree knapsack; centroid decomposition; implicit BST combinatorics; structural tree DP; selective subtree pruning; multinomial interleavings; small-to-large frequency maps; virtual tree; subtree MEX.

**Required mapping:** LC 543/437/337/979/1372/2246/1026/968/834/2581/2538/1339/1519/2049/1766/124/894/1443/1916/2458/2003; CF 161D depth DP; USACO Cow at Large Euler/BIT; LC 2867 centroid; LC 1569 implicit BST combinatorics; CF 600E small-to-large; USACO Sprinklers 2 rerooting; USACO Delegation feasibility; CF 741D parity mask + small-to-large; ABC 293G virtual tree. (Remaining rows should be reviewed individually in the source report before final sign-off.)

**Issues:** The topic is advanced and deep, but overlaps heavily with Trees (Topic 17). The two topics need a precise boundary: Topic 17 should teach tree algorithms/structures (LCA, Euler, HLD, centroid, virtual tree); Topic 38 should own DP over tree topology. Some placements (Cow at Large, centroid, virtual tree) are primarily tree techniques, not tree DP. LC 437 is prefix-sum path counting with rollback; LC 1766 is ancestor stack + coprime lookup; these are combinations. The stored key_insight is empty for the required rows in Topics 38–43, but sub_variant contains long explanatory prose; the UI should not silently leave the dedicated key insight blank. Need verify each long sub_variant against actual code and complexity.

**Recommendation:** Keep Tree DP distinct from Trees by ownership. Move pure tree data-structure/decomposition problems to Topic 17 (preserving IDs), while retaining rerooting, subtree DP, tree knapsack, state DP and combinatorial tree recurrences. **Verdict: Partial-to-strong concept breadth; Java not verified.**

## Topic 39 — Digit DP (22 required)

**Concept inventory:** position/tight; fixed suffix; previous digit; leading-zero flag; bitmask used digits; complement counting; digit-property aggregation; tuple-return positional contribution; alternate bases; dynamic modulus compression; multiple simultaneous properties; KMP automaton constraints; two-bound range; palindrome symmetry; alternating position parity; two numbers constructed simultaneously; matrix exponentiation for huge length.

**Required mapping:** LC 2999 baseline fixed suffix; CSES Counting Numbers previous digit; LC 233 digit contribution; 357/1012/2376 used-digit mask; CF 1073E aggregate sum; LC 600 binary digit DP; 902 restricted digit set; CF 55D lcm compression; LC 1067 digit occurrence count; 2827 balance + modulus; 1397 KMP automaton; 2801 two tight bounds; ABC 228F binary digit constraints; 2719 lower+upper tight; 2843 symmetry; 2048 construction/search; CF 1286F simultaneous numbers; custom palindrome DP; CF 1070E alternating sum; custom matrix exponentiation.

**Issues:** The concept progression is excellent and explicitly records why each new state dimension is necessary. But the custom matrix exponentiation exercise needs a well-defined automaton/state transition and must not imply every digit DP can be accelerated by a small matrix. Palindrome digit DP must prove the mirrored half-range constraints. Two-variable digit DP needs rigorous length alignment and tight-state transitions. The topic's required key_insight field is empty for all rows even though sub_variant contains extensive explanation; the UI may therefore show blank insight. Convert verified pedagogical text into the correct structured field and ensure it is not merely duplicated.

**Recommendation:** Preserve the advanced depth; this is a strong concept candidate. Verify all custom problems and matrix/palindrome derivations in Java. **Verdict: Strong breadth; solution/Java not verified.**

## Topic 40 — DAGs & Probability (11 required)

**Concept inventory:** DAG path counting; implicit DAG transitions; topological DP; expectation recurrence; probability propagation; absorbing boundaries; sliding transition windows; bounded-fuel states; Markov-chain transition matrices; asymptotic thresholding.

**Required mapping:** LC 935 Knight Dialer DAG/count DP; 688 Knight Probability; custom expected dice; 837 New 21 Game; 1230 Toss Strange Coins; custom Gambler's Ruin; 1575 fuel-decreasing state DAG; 1377 frog probability; 808 Soup Servings; custom coupon collector; custom Markov matrix exponentiation.

**Issues:** DAG DP and stochastic DP are related by state-transition graphs but are not the same concept family. Probability recurrence may be acyclic (backward expectation) or cyclic (Markov chain linear system / matrix exponentiation). The title should make this distinction explicit. LC 935 is integer counting DP, not probability. LC 1575 is constrained path counting. Soup Servings needs a rigorously justified approximation threshold. Gambler's Ruin formula must handle p=0, p=1 and numerical stability near p=0.5.

**Recommendation:** Consider splitting the learning paths within this topic into DAG DP and probability/expectation/Markov chains; no need to create another topic if the navigation can clearly separate them. **Verdict: Partial concept coverage; Java not verified.**

## Topic 41 — Combinatorial & Modulo DP (12 required)

**Concept inventory:** finite-state counting; stars and bars; transition matrix; derangements/inclusion-exclusion; Stirling numbers; permutation statistics; binomial completion counts; lattice path counting with forbidden points; Lucas theorem; modular arithmetic and factorial/inverse precomputation.

**Required mapping:** LC 1220 vowel permutations; 1641 sorted vowels/stars-bars; 1411 grid colour row transitions; custom no-adjacent-ones; LC 1359 pickup/delivery; custom derangements; LC 1866 visible sticks/Stirling; LC 903 DI permutations; LC 1569 BST reorderings; LC 1643 kth instructions; custom forbidden lattice paths; custom Lucas theorem.

**Issues:** Lucas theorem is number theory/modular combinatorics and needs prerequisite coverage of factorials modulo p and small-prime assumptions. Forbidden lattice paths need correct ordering and inclusion-exclusion proof. LC 1569 also appears in Tree DP; choose one primary owner (tree structure/interleavings vs combinatorial recurrence). Matrix exponentiation may overlap Topic 40/39; distinguish counting transitions from digit automata. Need explain modulo inverse preconditions and why division modulo p is not ordinary division.

**Recommendation:** Keep as a focused combinatorial counting family; add no basic combinatorics questions unless an essential identity/technique is absent from the current set. **Verdict: Partial concept coverage; Java not verified.**

## Topic 42 — Data-Structure-Optimised DP (21 required)

**Concept inventory:** DP transition as range/prefix query; BIT/segment tree max; monotonic deque; CHT and Li Chao; monotone slopes vs monotone queries; divide-and-conquer DP; quadrangle inequality/Knuth optimisation; CDQ; segment-tree-merge; rollback CHT; sqrt decomposition; DP over segment-tree nodes; monotonic stack breakpoints.

**Required mapping:** LC 300/673 BIT-LIS; 1696/1425 deque; 2407 segment-tree LIS; CF 1029C prefix max; LC 1235 sort+binary search+BIT; CF 311E CHT; CF 660F partial monotonic hull; CF 319C Li Chao; LC 2188 race DP; CF 321E/868F D&C/Knuth; custom Landscape QI; ABC 218H rollback CHT; CF 1526G segment-tree merge; CF 1603F CDQ+BIT; USACO Sprinkler System; AtCoder DP L; custom two optimisations; LC 2355 monotone stack.

**Issues:** This is an advanced but heterogeneous toolkit; each optimisation has strict preconditions. D&C DP requires monotone optimal split; Knuth requires specific quadrangle/monotonicity conditions; CHT requires line-query order assumptions or Li Chao; deque requires a sliding/prefix window; CDQ requires a non-double-counting divide-and-conquer invariant. LC 300/673 are also in LIS; LC 1235 in Partition DP/Intervals. The custom CF 1029C/CF 311E references need exact statement validation. Need include counterexamples showing when each optimisation is invalid.

**Recommendation:** Keep as a capstone toolkit with a decision tree of preconditions, not a bag of templates. Reclassify primary algorithm placements and use cross-references. **Verdict: Partial concept breadth; Java not verified.**

## Topic 43 — Profile / Broken Profile DP (17 required)

**Concept inventory:** frontier occupancy mask; column transitions; cell-by-cell broken profile; binary/ternary profiles; pairwise adjacent-row compatibility; weighted profile interactions; forbidden-cell transitions; reachability-set profile; multi-column pieces; multi-row profiles; plug DP with connectivity labels; transfer matrix; exponentiation over width; symmetry/row-availability bitmask.

**Required mapping:** LC 790 domino/tromino; custom parquet; CF 318C forbidden cells; LC 1931 ternary grid colouring; LC 1659 happiness profile; LC 2267 reachability bitset; LC 1411 row profile; custom L-tromino/two-row profile; COCI Selotejp; CEOI Connect / USACO Compound Escape plug connectivity; ABC 215H transfer matrix; custom striped tiling. LC 473 Matchsticks to Square and LC 3276 Select Cells in Grid are ordinary subset/row-availability bitmask DP, not frontier-profile DP.

**Issues:** LC 473 and LC 3276 are misclassified as Profile DP. A bitmask alone does not make a problem profile DP; the mask must represent the frontier/interface between processed and unprocessed regions. Plug DP connectivity labels require canonical component renumbering and careful cycle closure. The two-row/multi-column tile cases need a state definition that captures all pieces crossing the boundary. Matrix exponentiation is appropriate only after proving a fixed transition matrix independent of position. Need distinguish binary occupancy masks, ternary cell states, reachability sets and connectivity partitions.

**Recommendation:** Reclassify LC 473/3276 to bitmask/subset DP. Keep true frontier and plug DP; this is a valuable advanced topic and should not be merged into ordinary bitmask DP. **Verdict: Partial concept coverage; Java not verified.**

## Cross-topic actions

1. Topic 38 already contains deep tree-DP concepts; keep it distinct from tree data structures/decomposition in Topic 17.
2. Reclassify LC 473 and LC 3276 out of Profile DP into subset/bitmask DP.
3. Separate DAG counting from stochastic probability/Markov-chain DP in Topic 40.
4. Rebuild Topic 30 and Topic 34 boundaries to avoid generic DP duplication.
5. Distinguish interval DP from partition DP and tree DP with explicit recurrence shapes and dependency order.
6. Keep Topic 42 as an advanced optimisation capstone; every technique must have preconditions, proof and counterexample.
7. Fix empty key_insight fields in Topics 38–43 after verifying the long sub_variant explanations; do not blindly copy prose without validating correctness.
8. Correct misclassified placements before adding questions. New concept families should be integrated by replacing weaker/duplicate placements or by creating a genuinely separate path with distinct outcomes.

**Batch 4 final:** Digit DP, Tree DP, Profile DP and Data-Structure-Optimised DP contain sophisticated material, but all require solution/code verification. The clearest classification errors are LC 473/3276 in Profile DP and the mixing of non-DP techniques into several DP chapters.
