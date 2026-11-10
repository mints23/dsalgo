# Proposed New Topic Blueprints — Advanced Track

These are curriculum outlines, not production topic records. Create a topic only after the existing 43-topic content audit confirms the gap, source material is verified, and a curated Medium/Hard problem set is selected. No Easy problems are part of the required path.

## 1. Linked Lists — Advanced Patterns
**Prerequisites:** references/pointers, Two Pointers, basic complexity analysis.

Concept sequence:
1. Pointer invariants, sentinel/dummy nodes, aliasing and mutation safety.
2. In-place reversal: full, sublist, k-group, alternating groups, recursive vs iterative.
3. Merge and partition: two-list merge, k-way merge, list sorting, stable partition.
4. Fast/slow and cycle structure: entry, intersection, cycle length, implicit functional graph.
5. Structural transformations: reorder, rotate, splice, flatten, clone with random pointers.
6. Advanced reasoning: O(1)-space constraints, restoration, concurrency/ownership caveats where relevant.

Mastery assessment: derive an in-place multi-step transformation, state pointer invariants before each mutation, and prove no node is lost or linked twice.

## 2. Stack, Queue & Deque
**Prerequisites:** arrays, linked lists, amortized analysis; Monotonic Stack/Queue remains a separate advanced pattern topic.

Concept sequence:
1. Stack/queue/deque invariants and amortized operation analysis.
2. Two-stack queue, min/max stack, queue with aggregate, persistent/rollback variants.
3. Expression parsing: precedence, associativity, unary operators, parentheses, evaluation.
4. Nested structures and streaming parsers; state machines over input.
5. Deque design: both-end operations, bounded windows, monotonic deque cross-link.
6. Design trade-offs: arrays vs linked nodes, resizing, lazy deletion, memory locality.

Mastery assessment: design a data structure with multiple O(1) amortized operations and justify the invariant and worst-case sequence.

## 3. Sorting & Selection
**Prerequisites:** arrays, comparator semantics, heaps, binary search.

Concept sequence:
1. Partition invariants, quicksort and randomized selection.
2. Quickselect, kth order statistics, median selection and expected vs worst-case bounds.
3. Merge-sort applications: inversion count, counting pairs, divide-and-conquer aggregation.
4. Custom comparators and exchange proofs; stable vs unstable ordering.
5. Counting, radix and bucket sorting; when bounded domains change the lower-bound model.
6. Sorting as a reduction: intervals, greedy scheduling, geometric sweeps, offline queries.

Mastery assessment: choose the right ordering/selection method under adversarial constraints, prove comparator correctness, and derive complexity including worst-case behavior.

## 4. Bit Manipulation & Bitmask Techniques
**Prerequisites:** integer representation, Boolean algebra, recursion/DP.

Concept sequence:
1. Bitwise algebra, signed integers, shifts, overflow and language semantics.
2. XOR cancellation, parity, lowbit, set/clear/test operations and bit tricks.
3. Subset and submask enumeration; complexity and ordering.
4. Bitset operations and word-level parallelism.
5. State compression for DP/backtracking; subset transitions and SOS DP.
6. Meet-in-the-middle, mask transforms and optimization of dense bitmask state spaces.

Mastery assessment: recognize when a set-valued state can be compressed into a mask, estimate state/transition complexity, and implement safe subset transforms.

## 5. Advanced String Algorithms
**Prerequisites:** string indexing, hashing, prefix functions, Trie, KMP.

Concept sequence:
1. Prefix/Z functions and border/periodicity reasoning (cross-link KMP).
2. Rolling hash and Rabin–Karp; collision probability, double hashing and deterministic alternatives.
3. Palindrome algorithms: Manacher and palindrome radii.
4. Suffix arrays, LCP, substring ordering and repeated-substring queries.
5. Suffix automaton: end-position equivalence, distinct substrings and occurrence counts.
6. Multi-pattern matching: Aho–Corasick cross-link, failure links and output aggregation.

Mastery assessment: select a string index based on query type, prove what each state/index represents, and compare deterministic guarantees with probabilistic hashing.

## 6. Mathematics & Number Theory
**Prerequisites:** modular arithmetic, basic combinatorics, integer overflow.

Concept sequence:
1. GCD, extended Euclid, linear Diophantine equations.
2. Modular arithmetic, inverse, exponentiation, Fermat/Euler conditions and CRT.
3. Prime factorization, SPF, divisor functions, totient and multiplicative functions (cross-link Sieve).
4. Combinatorics: nCr, factorial/inverse factorial, Lucas theorem, inclusion-exclusion.
5. Counting arguments, pigeonhole, invariants and constructive proofs.
6. Number-theoretic transforms only if the wider course warrants this advanced extension.

Mastery assessment: derive the mathematical reduction before coding, state modular preconditions, and prove the formula or counting argument.

## 7. Network Flow & Matching
**Prerequisites:** Graph Fundamentals, BFS/DFS, residual graph representation.

Concept sequence:
1. Flow networks, capacities, conservation, residual edges and augmenting paths.
2. Max-flow/min-cut theorem and cut-based correctness reasoning.
3. Dinic: level graph, blocking flow, complexity and implementation invariants.
4. Bipartite matching, vertex-disjoint paths, König's theorem and reductions.
5. Vertex capacities, lower bounds and circulation feasibility.
6. Min-cost max-flow and potentials; when the added complexity is justified.
7. Modeling reductions: assignment, scheduling, closure, resource allocation.

Mastery assessment: reduce a non-obvious problem to a flow network, justify the edge/capacity model, and identify the min-cut interpretation.

## 8. Offline Query Algorithms
**Prerequisites:** sorting, prefix sums, Fenwick/Segment Tree, DSU, coordinate compression.

Concept sequence:
1. Online vs offline decision criteria; query reordering and answer restoration.
2. Sweep line with sorted events and active structures.
3. Mo's algorithm and reversible add/remove operations.
4. Parallel binary search over a monotone answer with offline feasibility checks.
5. Rollback DSU and divide-and-conquer on time.
6. CDQ divide and conquer, offline LCA and contribution counting.
7. Trade-offs among preprocessing, memory, query order and update reversibility.

Mastery assessment: identify why online processing is expensive, design an offline order, prove that reordering preserves answers, and derive total complexity.

## Cross-topic ownership rules
- Two Pointers owns array/string pointer movement and fast/slow recognition; Linked Lists owns pointer rewiring and list transformations.
- Monotonic Stack/Queue owns monotone candidate structures; Stack/Queue owns general stack/queue ADTs and parsing.
- Top K owns heap-based selection patterns; Sorting & Selection owns partition/selection theory and sorting reductions.
- Backtracking and Profile DP may use bitmasks; Bit Manipulation owns bit algebra and generic mask operations.
- KMP and Trie remain existing focused topics; Advanced String Algorithms covers suffix/palindrome/string-index families and cross-links rather than duplicating their problem sets.
- Sieve and Combinatorial & Modulo DP remain existing focused topics; Mathematics & Number Theory owns mathematical prerequisites and direct formula methods.
- Bipartite Graph remains a graph property topic; Network Flow & Matching owns matching algorithms and flow reductions.
- BIT/Segment Tree/DSU topics own data structures; Offline Query Algorithms owns the strategy of query ordering, rollback and temporal decomposition.

## Release gate for each new topic
1. Existing topic audit confirms the gap.
2. Learning objectives and prerequisites are approved.
3. Required problems are Medium/Hard/custom advanced only, with verified statements and sources.
4. Every problem has a distinct role and is not duplicated without rationale.
5. Topic body contains recognition signals, invariants, proofs, complexity, pitfalls and trade-offs.
6. An unseen mastery assessment is defined.
7. Additive DB migration and transactional seeding are reviewed separately.
