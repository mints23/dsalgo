# Progressive Concept Audit — Phase 2D (Topics 17–18)

**Source:** Live production problem rows and topic metadata.  
**Status:** Question-level concept-delta review; recommendations only.

## Topic 17 — Trees

**Inventory:** 49 placements; all Medium/Hard.  
**Verdict:** **Very broad advanced coverage. The content includes structural DFS/BFS, tree DP, rerooting, LCA/binary lifting, Euler tours, HLD, DSU on tree, centroid decomposition, virtual trees, and DSU on value-sorted paths. Organize as a prerequisite graph rather than a single list.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Diameter of Binary Tree | Postorder returns child-arm summary while updating a global path through the node | Core foundation |
| 2 | Maximum Depth of Binary Tree | Bottom-up subtree accumulation | Reference / prerequisite |
| 3 | Path Sum | Top-down state carried from parent to child | Core DFS direction contrast |
| 4 | Path Sum III | Prefix-sum frequency map along a root-to-current path; backtrack map on return | Core integration |
| 5 | Binary Tree Maximum Path Sum | Return one arm upward, but allow two arms in global candidate | Core tree-DP invariant |
| 6 | Longest Univalue Path | Arm extension conditional on node-value equality | Core constraint extension |
| 7 | Sum of Distances in Tree | Two-pass rerooting; derive O(1) answer change across one edge | Core advanced rerooting |
| 8 | Count Number of Possible Root Nodes | Rerooting with edge contributions that flip conditionally | Advanced rerooting extension |
| 9 | Tree Diameter | General-tree diameter using the two largest child arms | Transfer from binary to n-ary |
| 10 | House Robber III | Two-state take/skip DP merged from children | Core tree DP |
| 11 | Binary Tree Cameras | Three-state covered/camera/uncovered DP | Core state expansion |
| 12 | Distribute Coins in Binary Tree | Subtree excess represents flow across parent edge; sum absolute flows | Core flow interpretation |
| 13 | Longest ZigZag Path in Binary Tree | Direction-dependent two-state values returned from each node | Core directional DP |
| 14 | Longest Path with Different Adjacent Values | General-tree top-two valid arms with edge/value constraint | Integration |
| 15 | Delete Nodes and Return Forest | DFS returns surviving root; deleted nodes create new forest roots | Core structural mutation |
| 16 | Amount of Time for Binary Tree to Be Infected | Convert tree to graph traversal from a selected start node | Integration with BFS |
| 17 | LCA of Binary Tree | Recursive return semantics identify split point where both targets occur | Core LCA foundation |
| 18 | LCA of Deepest Leaves | Return a (depth, candidate-LCA) tuple | Core summary-state extension |
| 19 | Kth Ancestor of a Tree Node | Binary lifting table stores 2^k-th ancestor | Core query preprocessing |
| 20 | Maximize Value of Function in a Ball Passing Game | Binary lifting stores both destination and aggregate along jumps | Advanced aggregate lifting |
| 21 | USACO Gold — Cow at Large (custom) | Euler-tour subtree interval plus BIT for subtree queries | Advanced integration; statement/source required |
| 22 | Height of Binary Tree After Subtree Removal Queries | DFS order/depth grouping plus prefix/suffix maxima | Advanced offline query |
| 23 | Smallest Missing Genetic Value in Each Subtree | Small-to-large set merging and incremental MEX maintenance | Advanced DSU-on-tree |
| 24 | USACO Gold — Subtree Paths (custom) | Heavy-Light Decomposition converts path queries into chain ranges | Advanced HLD; statement/source required |
| 25 | CF 600E — Lomsat Gelral | DSU on tree: retain heavy child state and merge light subtrees | Advanced DSU-on-tree |
| 26 | CF 161D — Distance in Tree | Depth-indexed subtree DP counts node pairs at distance K | Core tree-knapsack / distance DP |
| 27 | CF 1017E — The Supersaga | Centroid decomposition with path-count aggregation and same-component subtraction | Advanced centroid decomposition; verify problem title/source |
| 28 | USACO Platinum — Cow Land | HLD plus segment tree for path aggregates with updates | Advanced HLD integration |
| 29 | ABC 133F — Colorful Tree | Euler tour + offline LCA + BIT for path color queries | Advanced multi-technique integration |
| 30 | CF 343D — Water Tree | HLD/DFS-order range updates with lazy segment tree | Advanced subtree/path distinction |
| 31 | IOI 2014 — Holiday | Virtual tree built from Euler order and LCA, then DP on compressed tree | Advanced virtual-tree pattern |
| 32 | CF 741D — Arpa's Letter Problem | Tree knapsack / small-to-large aggregation over parity masks | Advanced tree DP; verify exact technique and proof |
| 33 | Count Valid Paths in a Tree | Centroid decomposition counts paths satisfying prime-node constraint | Advanced centroid + number theory |
| 34 | Serialize and Deserialize Binary Tree | Encoding format and parsing, not a tree algorithm | Diagnostic trap; separate general serialization/parsing |
| 35 | Recover Binary Search Tree from Preorder | Stack-based BST construction/recovery, not generic tree traversal | Diagnostic trap; clarify exact problem title |
| 36 | Construct BST from Preorder Traversal | Use BST ordering and insertion bounds, not generic tree algorithms | Diagnostic trap / BST construction |
| 37 | Max Difference Between Node and Ancestor | Carry path minimum and maximum top-down | Core path-state variant |
| 38 | Count Good Nodes in Binary Tree | Carry one running maximum from root | Reference / simpler top-down state |
| 39 | Cycle Length Queries in a Tree | Binary lifting/LCA distance plus closing edge | Integration |
| 40 | Closest Leaf in Binary Tree | Add parent edges and multi-source BFS from leaves | Integration |
| 41 | Difference Between Maximum and Minimum Price Sum | Rerooting with two best directional path contributions | Advanced rerooting |
| 42 | Time Needed to Inform All Employees | Weighted rooted-tree DFS; maximum root-to-leaf path sum | Reference / weighted tree traversal |
| 43 | All Nodes Distance K in Binary Tree | Add parent pointers to turn tree into undirected graph, then BFS | Integration |
| 44 | Merge BSTs to Create Single BST | Merge fragments by root value, detect cycles/duplicate use, validate BST bounds | Advanced construction/validation |
| 45 | Tree of Coprimes | DFS ancestor state grouped by number-theoretic coprime relation | Advanced integration |
| 46 | Number of Ways to Reorder Array to Get Same BST | Implicit BST recursion plus combinatorial interleaving counts | Advanced combinatorial tree DP |
| 47 | Number of Good Paths | Process nodes by value and use DSU component counts to count valid endpoint pairs | Advanced DSU on value threshold |
| 48 | Count Subtrees with Max Distance Between Cities | Enumerate subsets, validate connectivity, compute diameter | Advanced bitmask + tree structure |
| 49 | Interval Containment Tree (custom) | Build parent as smallest containing interval, then apply tree DP | Custom reduction; statement/source required |

### Recommended concept paths

1. **DFS summaries and path states:** #2 → #1 → #5 → #6 → #12 → #13 → #14.
2. **Top-down versus bottom-up:** #3 → #4 → #37 → #38 → #42.
3. **Tree DP and constraints:** #10 → #11 → #26 → #32 → #46.
4. **Rerooting:** #7 → #8 → #41.
5. **LCA and ancestor queries:** #17 → #18 → #19 → #20 → #39.
6. **Tree to graph transformations:** #16 → #40 → #43.
7. **Euler tour / HLD / virtual tree:** #21 → #22 → #24 → #28 → #29 → #30 → #31.
8. **Small-to-large / centroid / DSU:** #23 → #25 → #27 → #33 → #45 → #47.
9. **Method selection / construction:** #34 → #35 → #36 → #44 → #48 → #49.

### Changes recommended (not yet applied)

- The topic is too broad to be taught as one sequential track. Keep a single Trees entry but expose subpaths: traversal summaries, tree DP, rerooting, LCA/binary lifting, Euler/HLD, small-to-large/centroid, and tree-to-graph transformations.
- #2 is a useful prerequisite but not an advanced core problem; #1 is a better first meaningful interview problem for the global-vs-returned-state distinction.
- #1 and #5 should explicitly teach the "one arm returned, two arms used globally" invariant. #10/#11 should then introduce state vectors for child-combination DP.
- #7/#8/#41 are all rerooting but need distinct derivations; avoid treating them as three unrelated tricks.
- #19/#20/#39 form a good binary-lifting progression: ancestor only → ancestor plus aggregate → path-distance query.
- #21–31 are advanced structures and need source links, constraints, implementation references, and clear prerequisites. Several are custom/competitive-programming entries without LeetCode IDs.
- #23 and #25 both use small-to-large but differ in what state is merged and whether the answer is a MEX or frequency mode. Teach the shared amortized argument once, then contrast.
- #27 and #33 need exact source/statement verification; #32 also needs a correctness check of the described parity-mask / tree-knapsack reduction.
- #34–36 are useful diagnostics but should not be counted as core tree-algorithm questions.
- #47 belongs partly to DSU/Graphs; #48 belongs partly to Bitmask DP. Keep them as integration problems.
- Final mastery challenge should require a learner to select among rerooting, HLD, binary lifting, centroid decomposition, DSU-on-tree, virtual tree, or plain DFS from query/update constraints.

---

## Topic 18 — Trie

**Inventory:** 25 placements; 24 Medium/Hard and 1 Easy reference.  
**Verdict:** **Good progression from ordinary prefix tries to augmented counters, binary XOR tries, trie + DP/grid search, and persistent/multi-pattern variants. Advanced string algorithms remain a separate gap.**

### Question-by-question review

| Order | Problem | New logic / concept contribution | Treatment |
|---:|---|---|---|
| 1 | Implement Trie (Prefix Tree) | Node structure and insert/search/startsWith operations | Core foundation |
| 2 | Replace Words | Terminal-node prefix match; stop at shortest valid root | Core application |
| 3 | Sum of Prefix Scores of Strings | passCount augmentation tracks how many words share each prefix | Core node augmentation |
| 4 | Map Sum Pairs | Weighted prefix aggregation; reinsert updates by delta | Core update semantics |
| 5 | Short Encoding of Words | Reverse strings to convert suffix elimination into prefix trie leaves | Core suffix transformation |
| 6 | Search Suggestions System | Lexicographic DFS / top-K suggestions below a prefix node | Core query/output extension |
| 7 | Design Add and Search Words | Wildcard search branches over children; complexity depends on wildcard positions | Core branching extension |
| 8 | Implement Trie II | Deletion requires separate terminal count and prefix count | Core mutable trie |
| 9 | Maximum XOR of Two Numbers in an Array | Binary trie greedily chooses opposite bit, justified by bit significance | Core binary trie |
| 10 | CF 706D — Vasiliy's Multiset | Dynamic binary trie with path counts for insert/delete/max-XOR | Core dynamic extension |
| 11 | Count Pairs With XOR in a Range | Count XOR less than a threshold by bitwise prefix cases | Core counting extension |
| 12 | Maximum Strong Pair XOR II | Algebraic constraint becomes a sorted sliding window plus dynamic XOR trie | Advanced integration |
| 13 | Extra Characters in a String | Trie-driven prefix transitions inside DP | Core Trie + DP integration |
| 14 | Word Search II | Shared Trie prunes grid DFS across many words; remove found words to avoid repeat traversal | Advanced integration |
| 15 | Concatenated Words | Trie + DP per word; exclude the word itself to avoid trivial self-match | Advanced integration |
| 16 | Maximum XOR With an Element From Array | Offline sort by query limit; insert only eligible values into trie | Advanced offline processing |
| 17 | Stream of Characters | Reverse trie plus active cursors for suffix matching on a stream | Advanced streaming pattern |
| 18 | Palindrome Pairs | Reverse-prefix trie plus palindrome-prefix/suffix checks | Advanced string integration |
| 19 | Prefix and Suffix Search | Encode suffix + separator + word into one combined trie query | Advanced key encoding |
| 20 | Maximum Genetic Difference Query | Binary trie maintained during DFS for root-to-node path values | Advanced tree + trie integration |
| 21 | Persistent XOR Trie: k-th smallest XOR in range (custom) | Persistent versions and count differences for range order statistics | Advanced persistence; statement/source required |
| 22 | Aho-Corasick Multi-Pattern Stream Counter (custom) | Failure links and output links enable simultaneous matching of many patterns | Advanced string automaton; statement/source required |
| 23 | Word Break | HashSet + DP is simpler when only exact dictionary membership is needed | Diagnostic trap |
| 24 | Word Search | One-word grid DFS does not benefit from a trie; trie is useful for many patterns | Diagnostic trap |
| 25 | Count Pairs with Longest Common Prefix ≥ k (custom) | Sorting + adjacent comparisons can beat trie construction for offline counting | Diagnostic trap; source/statement required |

### Recommended concept paths

1. **Prefix trie and node augmentation:** #1 → #2 → #3 → #4 → #8.
2. **Reverse/suffix transformations:** #5 → #17 → #18.
3. **Binary XOR trie:** #9 → #10 → #11 → #12 → #16 → #20 → #21.
4. **Trie-guided search and DP:** #6 → #7 → #13 → #14 → #15.
5. **Encoding and automata:** #19 → #22.
6. **Method selection:** #23 → #24 → #25.

### Changes recommended (not yet applied)

- Make node augmentation the core learning idea: terminal count, pass count, weighted sum, subtree count, and deletion state are different fields with different invariants.
- #3 and #4 are a strong pair: count prefixes, then maintain weighted aggregates correctly under reinsertion.
- #5 and #17 are related reverse-trie transformations; #17 adds online suffix matching and active cursors.
- #9–#12 form a strong binary-trie progression. Require a proof that the highest differing bit dominates all lower bits, then introduce dynamic deletion and threshold counting.
- #14/#15 are strong integration problems but belong partly to Backtracking/DP; trie should be the shared prefix-pruning structure.
- #16 is a valuable offline-query pattern: sorting makes the eligible set monotone, so a dynamic trie can grow without deletions.
- #20 should explicitly show the DFS enter/exit invariant for the values currently present in the trie.
- #21 needs a complete statement, constraints, source, and proof that version-count subtraction gives the range multiset.
- #22 needs complete automaton construction, output-link semantics, and a proof of the stated amortized complexity.
- #18/#19 are advanced string applications; do not let the Trie topic imply it replaces suffix array, suffix automaton, rolling hash, or Manacher.
- #23–25 are useful selection diagnostics, not core Trie questions.
- Final mastery challenge: process many online prefix/suffix/XOR queries under insert/delete and path constraints; learner must choose between a normal trie, binary trie, offline sorting, persistent trie, or Aho-Corasick.

---

## Status

Topics 01–18 have now received progressive concept-delta reviews. Topics 19–43 remain. No production curriculum rows have been modified.
