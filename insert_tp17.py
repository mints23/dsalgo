# -*- coding: utf-8 -*-
path = r"E:\PracticeProjec\dsalgofrog\src\pages\index.astro"
NEW = ''

NEW += '''<div class="topic-card" id="tp17">
                <div class="topic-header">
                    <div class="topic-num">12</div>
                    <div style="flex:1">
                        <div style="display:flex;align-items:center;gap:.5rem;flex-wrap:wrap">
                            <div class="topic-title">Trees</div>
                            <span class="tier-badge tier-T1">Core Pattern</span>
                            <span class="topic-type">DFS/BFS · Tree DP · LCA · Euler Tour · HLD · Centroid Decomp · Small-to-Large · Virtual Tree</span>
                        </div>
                        <div class="topic-meta">49 problems · 5 stages · 4 sections · bottom-up DFS, rerooting, tree DP, binary lifting, HLD, centroid decomp, DSU on tree, virtual tree</div>
                    </div>
                </div>
                <div class="topic-body">'''

NEW += '''
                    <div class="info-box"><strong>Why This Topic Matters:</strong> Trees are the most structurally rich topic in competitive programming and top-tier interviews. Unlike linear structures, trees encode hierarchical relationships that make every problem simultaneously a graph problem, a recursion problem, and often a DP problem. The core invariant of every tree algorithm is: the answer for any node v is a function of the answers for its children — and the answer for any path, subtree, or query can be decomposed at a carefully chosen node. This recursive decomposability is what makes trees tractable: DFS linearises them (Euler tour), LCA reduces path queries to range queries, centroid decomposition turns arbitrary path queries into O(log n) divide-and-conquer layers, and Heavy-Light Decomposition flattens tree paths into array segments. Trees appear in every ICPC/IOI/Google interview because they combine recursion correctness, traversal order, DP state design, and advanced data structures in a single framework. Mastery of trees means mastery of the entire hierarchy from O(n) DFS to O(n log² n) HLD + segment tree.</div>'''

NEW += '''
                    <div class="sec-title">The Mental Model</div>
                    <div class="info-box"><strong>A tree is a recursion machine.</strong> Every node is the root of its own universe — its subtree. The answer for any node depends ONLY on what it receives from its children (bottom-up) and what it passes down from its parent (top-down). Every tree algorithm is one of three things: (1) a pure bottom-up DFS accumulation, (2) a two-pass rerooting (bottom-up then top-down), or (3) a decomposition that breaks the tree into independently queryable pieces. The art is knowing which decomposition to use.<br><br>
                        <strong>How this mental model scales through the 5 stages:</strong><br>
                        • <strong>Stage 1 — Simplest form:</strong> Pure bottom-up DFS. f(v) = combine(f(child1), f(child2), ...) + contribution(v). Height, diameter, subtree sums — all computable in a single post-order traversal. The recursion stack IS the algorithm.<br>
                        • <strong>Stage 2 — What changes:</strong> One constraint forces a two-pass: the answer at v depends on BOTH its subtree AND the rest of the tree (re-rooting). Add a top-down pass carrying the "contribution from above."<br>
                        • <strong>Stage 3 — What expands:</strong> State gains a second dimension. DP on trees: dp[v][0/1] (node taken/not taken), dp[v][k] (budget k remaining in subtree). The recurrence merges child DPs via knapsack or similar.<br>
                        • <strong>Stage 4 — What is hidden:</strong> The problem says nothing about trees. But the input encodes a tree structure (parent array, dependency graph, interval containment), and the answer requires tree DP or tree decomposition. Recognising the hidden tree IS the hard part.<br>
                        • <strong>Stage 5 — What is optimised:</strong> Naive tree DP is O(n²) due to knapsack merging or repeated path queries. Fix with: small-to-large merging (O(n log n)), virtual tree (O(k log n) for sparse queries), or HLD + segment tree (O(n log² n) per query).
                    </div>'''

NEW += '''
                    <div class="sec-title">Core Invariants / Proof Sketches</div>
                    <div class="core-box">
                        <strong>Invariant 1: Subtree DFS / Post-Order Correctness</strong><br>
                        <em>Invariant:</em> In a post-order DFS, when we process node v, ALL descendants of v have already been processed and their sub-answers are finalised.<br>
                        <em>Proof sketch:</em> A post-order traversal visits a node only after ALL its children (and their subtrees) are fully visited. By induction: leaf nodes are correct trivially (no children). For internal node v, all child subtrees are correct by the inductive hypothesis. Therefore f(v) = combine(f(child_i)) is correct. □<br><br>
                        <strong>Invariant 2: LCA via Binary Lifting</strong><br>
                        <em>Invariant:</em> For any two nodes u, v, after binary lifting preprocessing: LCA(u, v) is found in O(log n) by repeatedly lifting the deeper node by powers of 2 until both are at the same depth, then lifting both simultaneously.<br>
                        <em>Proof sketch:</em> ancestor[v][k] = 2^k-th ancestor of v. Preprocessing fills this table in O(n log n) using: ancestor[v][k] = ancestor[ancestor[v][k-1]][k-1]. To find LCA: (1) Bring u and v to the same depth by lifting the deeper one. (2) If they are equal, that's the LCA. (3) Otherwise, use binary search from highest bit down: if ancestor[u][k] ≠ ancestor[v][k], lift both by 2^k. After all bits: parent of current u (= current v) is the LCA. Correctness: we never overshoot (we only lift when the 2^k ancestor is BELOW LCA) so the stopping condition is exact. □<br><br>
                        <strong>Invariant 3: Centroid Decomposition Depth Bound</strong><br>
                        <em>Invariant:</em> The centroid of a tree is the node whose removal minimises the maximum component size (≤ n/2). The centroid decomposition tree has depth O(log n).<br>
                        <em>Proof sketch:</em> After removing centroid c, each component has size ≤ n/2 (by definition of centroid). Recursing on each component with size ≤ n/2 means the recursion depth is at most O(log n) (geometric series: n → n/2 → n/4 → ... → 1). Every root-to-leaf path in the centroid tree has length O(log n). Therefore any path in the original tree passes through O(log n) centroids, making per-path queries O(log n) amortised. □<br><br>
                        <strong>Invariant 4: Heavy-Light Decomposition Chain Count</strong><br>
                        <em>Invariant:</em> Any root-to-leaf path in a tree crosses at most O(log n) light edges.<br>
                        <em>Proof sketch:</em> A "heavy edge" goes to the child with the largest subtree. When we traverse a LIGHT edge from v to child c: the subtree of c has size &lt; subtree(v)/2 (otherwise c would be the heavy child). So each time we cross a light edge going down, the remaining subtree size more than halves. Starting from n, we can halve at most O(log n) times before reaching size 1. Therefore any path crosses O(log n) heavy chains, giving O(log n × query_per_chain) total. □
                    </div>'''

NEW += '''
                    <div class="sec-title">Sub-Variants to Master</div>
                    <div class="info-box" style="line-height:1.75">
                        <strong>Group 1 — Basic Tree Traversal and Properties:</strong><br>
                        • <strong>Tree height / depth</strong> — Stage 1 · O(n) · DFS post-order · baseline: single accumulation pass<br>
                        • <strong>Diameter of tree</strong> — Stage 1 · O(n) · DFS returning (max_depth, diameter) · first multi-value return: diameter may pass through node v<br>
                        • <strong>Subtree sum / count</strong> — Stage 1 · O(n) · DFS post-order accumulation · subtree as "universe" invariant<br>
                        • <strong>Path sum root-to-leaf</strong> — Stage 1 · O(n) · DFS pre-order accumulation · top-down pass carrying prefix state<br>
                        • <strong>Lowest Common Ancestor (LCA) — naive</strong> — Stage 1 · O(n) per query · DFS parent tracking · path = union of two root paths<br><br>
                        <strong>Group 2 — Re-rooting / Two-Pass:</strong><br>
                        • <strong>Sum of distances to all nodes</strong> — Stage 2 · O(n) · two-pass DFS · rerooting: top-down pass carries contribution-from-above<br>
                        • <strong>Minimum height re-rooting</strong> — Stage 2 · O(n) · two-pass DFS · same as above; height depends on direction of root<br>
                        • <strong>Count of good nodes (node ≥ all ancestors)</strong> — Stage 2 · O(n) · DFS carrying running max · top-down max passed from parent to child<br><br>
                        <strong>Group 3 — Tree DP:</strong><br>
                        • <strong>Maximum independent set on tree</strong> — Stage 3 · O(n) · dp[v][0/1] (excluded/included) · two-state DP; child answers conditionally merged<br>
                        • <strong>Tree knapsack (weight budget)</strong> — Stage 3 · O(n²) naively, O(n log n) with small-to-large · dp[v][k] = best value using k nodes in subtree · merging child DPs is the core transition<br>
                        • <strong>Minimum vertex cover</strong> — Stage 3 · O(n) · dp[v][0/1] · structurally identical to MIS but objective flips<br>
                        • <strong>Maximum matching on tree</strong> — Stage 3 · O(n) · dp[v][0/1] (matched/unmatched) · matching an edge = child takes parent's edge slot<br>
                        • <strong>Tree diameter via DP</strong> — Stage 3 · O(n) · dp[v] = max depth in subtree; update global answer · diameter = best depth from left child + best depth from right child at each node<br><br>
                        <strong>Group 4 — LCA Variants:</strong><br>
                        • <strong>Binary Lifting LCA</strong> — Stage 3 · O(n log n) preprocess, O(log n) per query · ancestor[v][k] = 2^k-th ancestor · standard LCA for path queries<br>
                        • <strong>Euler Tour + Sparse Table LCA</strong> — Stage 3 · O(n log n) preprocess, O(1) per query · RMQ on Euler tour · reduces LCA to range minimum query<br>
                        • <strong>LCA + path queries (sum/max on path u→v)</strong> — Stage 4 · O(n log n) preprocess, O(log n) per query · binary lifting with aggregate · each ancestor table stores aggregated value<br>
                        • <strong>Kth ancestor</strong> — Stage 3 · O(n log n) preprocess, O(log n) per query · binary lifting · decompose k in binary; jump by powers of 2<br><br>
                        <strong>Group 5 — Euler Tour / Linearisation:</strong><br>
                        • <strong>Subtree queries (sum/max in subtree)</strong> — Stage 3 · O(n log n) · DFS in/out timestamps + BIT/segment tree · subtree = contiguous range in DFS order<br>
                        • <strong>Path queries with Euler tour</strong> — Stage 3 · O(n log n) · Euler tour + BIT + LCA · path sum = prefix(u) + prefix(v) − 2×prefix(LCA) − val(LCA)<br>
                        • <strong>Subtree updates + point queries</strong> — Stage 3 · O(n log n) · DFS order + BIT with range update · subtree becomes a range; BIT range update applies<br><br>
                        <strong>Group 6 — Heavy-Light Decomposition:</strong><br>
                        • <strong>Path max/sum queries (static)</strong> — Stage 4 · O(n log n) preprocess, O(log² n) per query · HLD + segment tree · path decomposes into O(log n) chains; each chain is a range query<br>
                        • <strong>Path updates + path queries</strong> — Stage 4 · O(n log² n) · HLD + lazy segment tree · adds lazy propagation to chain segment tree<br>
                        • <strong>Subtree updates + path queries (combined)</strong> — Stage 5 · O(n log² n) · HLD + persistent/lazy segment tree · subtree update in HLD = contiguous range update<br><br>
                        <strong>Group 7 — Centroid Decomposition:</strong><br>
                        • <strong>Count paths of length K</strong> — Stage 4 · O(n log n) · centroid decomp + hashmap · every path passes through exactly one centroid in decomp tree<br>
                        • <strong>Nearest marked node (online updates)</strong> — Stage 5 · O(n log² n) · centroid decomp + heap per centroid · distance to nearest marked node via centroid ancestors<br>
                        • <strong>Number of paths with sum ≤ K</strong> — Stage 5 · O(n log² n) · centroid decomp + sorted merge · merge sorted distance arrays at centroid; two-pointer counts<br><br>
                        <strong>Group 8 — Advanced Tree Techniques:</strong><br>
                        • <strong>Small-to-large merging (DSU on tree)</strong> — Stage 5 · O(n log n) · merge smaller child's data structure into larger · each element merged O(log n) times<br>
                        • <strong>Virtual tree</strong> — Stage 5 · O(k log n) per query · LCA + sorted DFS order · build compressed tree on k key nodes for sparse queries<br>
                        • <strong>Link-Cut Tree (dynamic connectivity)</strong> — Stage 5 · O(n log n) amortised · splay tree per path · supports link/cut/path queries on dynamic trees<br>
                        • <strong>Auxiliary tree / Euler Tour Tree</strong> — Stage 5 · O(n log n) · balanced BST on Euler tour · supports subtree re-rooting and path inversion dynamically
                    </div>'''

NEW += '''
                    <div class="sec-title">Complexity Staircase</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>Sub-Variant</th><th>Time</th><th>Space</th><th>What Changed from Previous</th></tr></thead>
                        <tbody>
                        <tr><td>DFS subtree accumulation</td><td>O(n)</td><td>O(n)</td><td>Baseline: post-order recursion</td></tr>
                        <tr><td>Tree diameter</td><td>O(n)</td><td>O(n)</td><td>Multi-value return from DFS</td></tr>
                        <tr><td>Two-pass rerooting</td><td>O(n)</td><td>O(n)</td><td>Second DFS pass carries top-down state</td></tr>
                        <tr><td>Tree DP (dp[v][0/1])</td><td>O(n)</td><td>O(n)</td><td>State dimension added; conditional child merging</td></tr>
                        <tr><td>Binary Lifting LCA</td><td>O(n log n) / O(log n) query</td><td>O(n log n)</td><td>Ancestor table; precompute powers of 2</td></tr>
                        <tr><td>Euler Tour + BIT subtree queries</td><td>O(n log n)</td><td>O(n)</td><td>DFS timestamps linearise subtree to range</td></tr>
                        <tr><td>HLD path queries</td><td>O(n log n) / O(log² n) query</td><td>O(n log n)</td><td>Tree paths decomposed into O(log n) chains</td></tr>
                        <tr><td>Tree knapsack (naïve)</td><td>O(n²)</td><td>O(n²)</td><td>DP over subtree size; merging child DPs</td></tr>
                        <tr><td>Tree knapsack (small-to-large)</td><td>O(n log n)</td><td>O(n log n)</td><td>DSU on tree; each element merged O(log n) times</td></tr>
                        <tr><td>Centroid decomposition</td><td>O(n log n) / O(log n) depth</td><td>O(n log n)</td><td>Divide at centroid; O(log n) layers</td></tr>
                        <tr><td>Centroid + data structure</td><td>O(n log² n)</td><td>O(n log n)</td><td>Per-centroid DS for path aggregation</td></tr>
                        <tr><td>Virtual tree</td><td>O(k log n) per query</td><td>O(k)</td><td>Compressed tree on k key nodes only</td></tr>
                        <tr><td>Link-Cut Tree</td><td>O(log n) amortised per op</td><td>O(n)</td><td>Dynamic tree; path operations + link/cut</td></tr>
                        </tbody></table></div>'''

NEW += '''
                    <div class="sec-title">Mastery Problem Set</div>
                    <div class="info-box" style="padding:.4rem .8rem;margin-bottom:.4rem"><strong>📌 Section A — Standard Rooted / Unrooted Trees</strong> (DFS, tree DP, rerooting, LCA, Euler tour, HLD, centroid)</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>S.No</th><th>Layer</th><th>Stage</th><th>Source</th><th># / Name</th><th>Difficulty</th><th>P</th><th>Sub-Variant</th><th>New Idea Added</th><th>Key Insight</th></tr></thead>
                        <tbody>
                        <tr><td class="num-cell">1</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/diameter-of-binary-tree/" target="_blank">543 – Diameter of Binary Tree</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">DFS returning max depth; global diameter</td><td>THE baseline: post-order DFS returns max depth; diameter = max(left_depth + right_depth) updated at each node</td><td class="insight">Establishes the "return child sub-answer, update global at node" pattern; every tree DP builds on this</td></tr>
                        <tr><td class="num-cell">2</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximum-depth-of-binary-tree/" target="_blank">104 – Maximum Depth of Binary Tree</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Pure bottom-up accumulation</td><td>ONE change from S.No 1: single-value return; no global update</td><td class="insight">Baseline for subtree accumulation; depth(v) = 1 + max(depth(left), depth(right))</td></tr>
                        <tr><td class="num-cell">3</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/path-sum/" target="_blank">112 – Path Sum</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Top-down DFS; carry prefix sum</td><td>ONE change: pass running state DOWN (prefix sum) instead of accumulating UP</td><td class="insight">Introduces top-down pass; state passed from parent to child, not returned</td></tr>
                        <tr><td class="num-cell">4</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/path-sum-iii/" target="_blank">437 – Path Sum III</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Prefix sum hashmap + DFS</td><td>Adds prefix-sum hashmap to DFS; count paths with target sum without root constraint</td><td class="insight">Combines DFS + hashmap; path need not start at root or end at leaf</td></tr>
                        <tr><td class="num-cell">5</td><td><span class="l1">1</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/binary-tree-maximum-path-sum/" target="_blank">124 – Binary Tree Maximum Path Sum</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">DFS returning best single-arm; global path across node</td><td>Path can bend at any node; return value to parent = best SINGLE arm (no bend); global = best bend at this node</td><td class="insight">Hard: the "no bend upward" constraint on return value is the subtle split; candidates who return the full path break the recursion</td></tr>
                        <tr><td class="num-cell">6</td><td><span class="l1">1</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/longest-univalue-path/" target="_blank">687 – Longest Univalue Path</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">DFS with value-equality constraint on arm extension</td><td>ONE change from S.No 5: arm can only extend if child value equals parent value; same return/update structure</td><td class="insight">Adds a VALUE CONSTRAINT on arm extension; arm resets to 0 when value changes</td></tr>
                        <tr><td class="num-cell">7</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/sum-of-distances-in-tree/" target="_blank">834 – Sum of Distances in Tree</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Two-pass rerooting: bottom-up then top-down</td><td>ans[v] = ans[parent] + (n − subtree_size[v]) − subtree_size[v] derived via rerooting formula</td><td class="insight">Hard: deriving the O(1) rerooting transition from the distance-change formula requires careful counting; WHY hard: candidates try O(n) BFS per node (O(n²)) without seeing the rerooting trick</td></tr>
                        <tr><td class="num-cell">8</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/count-number-of-possible-root-nodes/" target="_blank">2581 – Count Number of Possible Root Nodes ✅</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Rerooting with conditional edge contribution</td><td>ONE change from S.No 7: contribution depends on whether edge direction in re-rooting matches a "guess"; track count of correct guesses per root</td><td class="insight">Hard: rerooting where the contribution PER EDGE changes conditionally; requires tracking which edges flip sign when root changes</td></tr>
                        <tr><td class="num-cell">9</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/tree-diameter/" target="_blank">1245 – Tree Diameter ✅</a></td><td><span class="diff-m">Medium</span></td><td>✅</td><td class="variant-cell">DFS diameter on general tree (not binary)</td><td>ONE change from S.No 1: tree has arbitrary branching; track top-2 depths among all children</td><td class="insight">Generalises diameter to n-ary tree; top-2 depths among children replace left/right binary case</td></tr>
                        <tr><td class="num-cell">10</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/house-robber-iii/" target="_blank">337 – House Robber III</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Tree DP dp[v][0/1]; merge child states conditionally</td><td>First tree DP: dp[v][1] = val[v] + Σ dp[child][0]; dp[v][0] = Σ max(dp[child][0], dp[child][1])</td><td class="insight">Canonical two-state tree DP; child states merged with conditional logic; independent children</td></tr>
                        <tr><td class="num-cell">11</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/binary-tree-cameras/" target="_blank">968 – Binary Tree Cameras</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Three-state tree DP: covered/camera/uncovered</td><td>ONE change: THREE states needed (dp[v][0/1/2] = needs coverage / has camera / covered by child); transitions more complex</td><td class="insight">Hard: three-state DP where parent must handle "uncovered" children; WHY hard: state transitions involve all combinations of child states</td></tr>
                        <tr><td class="num-cell">12</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/distribute-coins-in-binary-tree/" target="_blank">979 – Distribute Coins in Binary Tree</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">DFS returning "excess coins"; flows computed at each node</td><td>ONE change: DFS returns a SIGNED value (excess = +, deficit = −); moves = sum of |excess| over all nodes</td><td class="insight">Return value represents flow direction; absolute value accumulation = total moves</td></tr>
                        <tr><td class="num-cell">13</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/longest-zigzag-path-in-a-binary-tree/" target="_blank">1372 – Longest ZigZag Path in Binary Tree</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Two-state DFS per node: (left_len, right_len)</td><td>Returns TWO directional values per node (not one); zigzag extends by flipping direction</td><td class="insight">Directional state at each node; two values returned, one for each possible incoming direction</td></tr>
                        <tr><td class="num-cell">14</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/longest-path-with-different-adjacent-values/" target="_blank">2246 – Longest Path with Different Adjacent Values</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">DFS returning max arm; top-2 arms for global path</td><td>ONE change from S.No 1: arm can extend only if child value ≠ parent value; diameter pattern on n-ary tree</td><td class="insight">Generalises binary tree diameter to n-ary with value constraint; top-2 arm tracking</td></tr>
                        <tr><td class="num-cell">15</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/delete-nodes-and-return-forest/" target="_blank">1110 – Delete Nodes and Return Forest</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">DFS returning node; mark deleted nodes; collect roots</td><td>DFS decides to sever edges (mark children as new roots when parent deleted); post-order with set lookup</td><td class="insight">Combines DFS with deletion set; "return null if deleted" pattern changes tree structure during traversal</td></tr>
                        <tr><td class="num-cell">16</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/amount-of-time-for-binary-tree-to-be-infected/" target="_blank">2385 – Amount of Time for Binary Tree to Be Infected</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">BFS from infection start + tree distance to farthest node</td><td>Converts tree to undirected graph; BFS from source finds max time = max distance; combines tree structure with BFS</td><td class="insight">Stage 3 combination: tree structure + graph BFS; infection = multi-source BFS from a specific node</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#fff3cd,#ffe69c);padding:.55rem .8rem;font-weight:600;text-align:center">⚡ — CLIFF WARNING — Layer 2 → Layer 3: The next problems require combining tree traversal with non-trivial data structures (BITs, segment trees, binary lifting). The core DFS pattern is unchanged but the state stored at each node and the query mechanism become significantly more complex. Master DFS in/out timestamps and "subtree = contiguous range" before proceeding.</td></tr>
                        <tr><td class="num-cell">17</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/" target="_blank">236 – LCA of Binary Tree</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">DFS LCA: return node when found in either subtree</td><td>First LCA: post-order DFS; if left and right both non-null → current node is LCA; propagate non-null result upward</td><td class="insight">LCA via DFS: the "both subtrees return non-null" condition uniquely identifies LCA</td></tr>
                        <tr><td class="num-cell">18</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/lowest-common-ancestor-of-deepest-leaves/" target="_blank">1123 – LCA of Deepest Leaves</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">LCA of deepest leaves: return (depth, lca) pair</td><td>ONE change: LCA target is NOT given — must find the deepest leaves first; return (depth, lca) tuple from DFS</td><td class="insight">Return TUPLE from DFS; LCA derived by comparing depths from left and right subtrees</td></tr>
                        <tr><td class="num-cell">19</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/kth-ancestor-of-a-tree-node/" target="_blank">1483 – Kth Ancestor of a Tree Node ✅</a></td><td><span class="diff-m">Medium</span></td><td>✅</td><td class="variant-cell">Binary Lifting ancestor[v][k] = 2^k-th ancestor</td><td>Binary lifting baseline: precompute ancestor[v][j] = ancestor[ancestor[v][j-1]][j-1]; answer k-th ancestor by decomposing k in binary</td><td class="insight">O(n log n) preprocess; O(log n) per query; each bit of k = one jump; foundation for all LCA binary lifting</td></tr>
                        <tr><td class="num-cell">20</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximize-value-of-function-in-a-ball-passing-game/" target="_blank">2836 – Maximize Value of Function in a Ball Passing Game</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Binary lifting storing aggregate (XOR/sum) along ancestors</td><td>ONE change from S.No 19: store AGGREGATE VALUE along with ancestor (not just ancestor index); val[v][k] = sum of values on 2^k steps</td><td class="insight">Hard: binary lifting table stores both index and aggregated value simultaneously; WHY hard: combining two tables and merging aggregates correctly during the doubling step</td></tr>
                        <tr><td class="num-cell">21</td><td><span class="l3">3</span></td><td>4</td><td>USACO</td><td class="prob-name">USACO Gold – Cow at Large</td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Euler tour + BIT: subtree range queries</td><td>DFS assigns in-time/out-time; subtree of v = [in[v], out[v]]; query = BIT range query on that interval</td><td class="insight">Euler tour linearises subtree to contiguous range; enables O(log n) subtree queries with BIT</td></tr>
                        <tr><td class="num-cell">22</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/height-of-binary-tree-after-subtree-removal-queries/" target="_blank">2458 – Height of Binary Tree After Subtree Removal Queries</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">DFS order + prefix/suffix max arrays for each depth level</td><td>Store max height at each depth from left prefix and right suffix; answer query in O(1) after O(n) preprocessing</td><td class="insight">Hard: queries about "height of tree if subtree v removed" — requires precomputing depth-wise contributions; WHY hard: decomposing the remaining-tree height by depth layer</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#fff3cd,#ffe69c);padding:.55rem .8rem;font-weight:600;text-align:center">⚡ — CLIFF WARNING — Layer 3 → Layer 4: The next set requires HLD, centroid decomposition, or tree knapsack — techniques requiring 100+ lines of correct implementation and multiple non-trivial invariants simultaneously. Prepare by: (1) implementing HLD with segment tree from scratch 3× until error-free; (2) implementing centroid decomposition with distance hashmap from scratch 2×; (3) mastering the tree knapsack merging proof.</td></tr>
                        <tr><td class="num-cell">23</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/smallest-missing-genetic-value-in-each-subtree/" target="_blank">2003 – Smallest Missing Genetic Value in Each Subtree</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">DFS + small-to-large set merging (DSU on tree)</td><td>Small-to-large baseline: merge smaller child's set into larger; each element merges O(log n) times total</td><td class="insight">Hard: "for each node, find MEX of subtree values" — naïve O(n²); small-to-large gives O(n log n); WHY hard: recognising small-to-large as the right tool and correctly maintaining MEX</td></tr>
                        <tr><td class="num-cell">24</td><td><span class="l4">4</span></td><td>4</td><td>USACO</td><td class="prob-name">USACO Gold – Subtree Paths</td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">HLD: path queries on tree using segment tree on HLD order</td><td>HLD baseline: assign HLD positions; each heavy chain = contiguous array segment; path query = O(log n) chain segments each queried in O(log n)</td><td class="insight">Hard: implementing correct HLD with chain head tracking, LCA via HLD, and segment tree queries; WHY hard: three interacting components must all be correct simultaneously</td></tr>
                        <tr><td class="num-cell">25</td><td><span class="l4">4</span></td><td>4</td><td>Codeforces</td><td class="prob-name"><a class="lc-link" href="https://codeforces.com/problemset/problem/600/E" target="_blank">CF 600E – Lomsat Gelral</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">DSU on tree (small-to-large DFS); dominant colour per subtree</td><td>ONE change from S.No 23: maintain a frequency map + max-frequency colour; small-to-large merging of multisets</td><td class="insight">Hard: maintaining a complex aggregate (most-frequent element) while merging; WHY hard: the "inherit heavy child, merge light children" optimisation is non-obvious</td></tr>
                        <tr><td class="num-cell">26</td><td><span class="l4">4</span></td><td>4</td><td>Codeforces</td><td class="prob-name"><a class="lc-link" href="https://codeforces.com/problemset/problem/161/D" target="_blank">CF 161D – Distance in Tree</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Tree DP dp[v][d] = count nodes at distance d from v</td><td>NEW dimension: dp[v][d] = number of nodes at exactly distance d in subtree of v; merge children by convolving depth arrays</td><td class="insight">Depth-parameterised DP; O(n²) merging; transitions: dp[v][d] = Σ_child dp[child][d-1]</td></tr>
                        <tr><td class="num-cell">27</td><td><span class="l4">4</span></td><td>5</td><td>Codeforces</td><td class="prob-name"><a class="lc-link" href="https://codeforces.com/problemset/problem/1017/E" target="_blank">CF 1017E – The Supersaga</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Centroid decomposition + hashmap for path-count queries</td><td>Centroid decomp baseline: for each centroid c, compute distances from c to all nodes in subtree; use hashmap to count complementary paths</td><td class="insight">Hard: implementing centroid decomposition with correct "subtract same-component paths" exclusion; WHY hard: paths through the centroid must be counted exactly once, requiring careful subtraction of paths within the same sub-component</td></tr>
                        <tr><td class="num-cell">28</td><td><span class="l4">4</span></td><td>5</td><td>USACO</td><td class="prob-name">USACO Platinum – Cow Land</td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">HLD + segment tree with lazy propagation (point update, path query)</td><td>ONE change from S.No 24: adds POINT UPDATES to HLD; segment tree on HLD order supports O(log n) updates</td><td class="insight">Hard: combines HLD with a segment tree supporting updates; WHY hard: HLD position mapping must be consistent during updates; update = O(log² n)</td></tr>
                        <tr><td class="num-cell">29</td><td><span class="l4">4</span></td><td>5</td><td>AtCoder</td><td class="prob-name"><a class="lc-link" href="https://atcoder.jp/contests/abc133/tasks/abc133_f" target="_blank">ABC 133F – Colorful Tree</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Euler tour + offline LCA + BIT (path colour queries)</td><td>Offline queries sorted by colour; BIT tracks colour contributions on root-to-node paths; LCA splits path into two root-paths</td><td class="insight">Hard: offline query processing + Euler tour + BIT + LCA combined; WHY hard: four techniques must interoperate correctly in one solution</td></tr>
                        <tr><td class="num-cell">30</td><td><span class="l4">4</span></td><td>5</td><td>Codeforces</td><td class="prob-name"><a class="lc-link" href="https://codeforces.com/problemset/problem/343/D" target="_blank">CF 343D – Water Tree</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">HLD + segment tree with lazy propagation (subtree fill + path clear)</td><td>Adds SUBTREE UPDATE operation alongside path query to HLD solution; subtree = HLD contiguous range in DFS order</td><td class="insight">Hard: subtree update in HLD = range update on DFS-order segment; distinguishing subtree range (DFS order) from path range (HLD chain) is the critical realisation</td></tr>
                        <tr><td class="num-cell">31</td><td><span class="l4">4</span></td><td>5</td><td>IOI</td><td class="prob-name">IOI 2014 – Holiday</td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Virtual tree + tree DP on compressed tree</td><td>Build virtual tree on k key nodes; run DP only on O(k) virtual nodes; O(k log n) instead of O(n)</td><td class="insight">Hard: virtual tree requires Euler tour + LCA + sorted DFS order to build; then standard tree DP runs on compressed structure; WHY hard: building the virtual tree correctly is 60% of the implementation</td></tr>
                        <tr><td class="num-cell">32</td><td><span class="l4">4</span></td><td>5</td><td>Codeforces</td><td class="prob-name"><a class="lc-link" href="https://codeforces.com/problemset/problem/741/D" target="_blank">CF 741D – Arpa's Letter Problem</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Tree knapsack with small-to-large to avoid O(n²)</td><td>dp[v][k] = min cost for k elements in subtree; small-to-large merging reduces O(n²) knapsack to O(n log² n)</td><td class="insight">Hard: tree knapsack is O(n²) naïve; small-to-large reduces complexity; WHY hard: proving the merged knapsack DP is still correct after the optimisation</td></tr>
                        <tr><td class="num-cell">33</td><td><span class="l4">4</span></td><td>5</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/count-valid-paths-in-a-tree/" target="_blank">2867 – Count Valid Paths in a Tree</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Centroid decomp + prime-path counting</td><td>For each centroid: count paths with exactly one prime node using prefix parity arrays; subtract over-counted same-component paths</td><td class="insight">Hard: domain-specific constraint (prime number on path) processed via centroid decomp; WHY hard: parity tracking (0 or 1 prime nodes) across two half-paths merged at centroid</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#ffe6e6,#ffd0d0);padding:.55rem .8rem;font-weight:600;text-align:center">⚠️ TRAP ZONE — Problems that LOOK like tree algorithms but require a different technique or mental model.</td></tr>
                        <tr><td class="num-cell">34</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>LeetCode</td><td class="prob-name trap-name"><a class="lc-link" href="https://leetcode.com/problems/serialize-and-deserialize-binary-tree/" target="_blank">297 – Serialize and Deserialize Binary Tree ⚠️</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">⚠️ TRAP — encoding/decoding problem, NOT tree algorithm</td><td>Preorder traversal with null markers encodes tree; BFS level-order is alternative; no DP or query optimisation involved</td><td class="insight">NOT an algorithmic tree problem: the challenge is encoding format design and parsing, not algorithmic efficiency</td></tr>
                        <tr><td class="num-cell">35</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>LeetCode</td><td class="prob-name trap-name"><a class="lc-link" href="https://leetcode.com/problems/recover-a-tree-from-preorder-traversal/" target="_blank">1028 – Recover Binary Search Tree from Preorder ⚠️</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">⚠️ TRAP — stack-based reconstruction, NOT tree traversal algorithm</td><td>Use a monotone stack to track the "rightmost path" of the tree; insert nodes based on value vs. stack top</td><td class="insight">NOT a standard tree problem: it is a tree construction problem; applying standard DFS/DP gives wrong approach</td></tr>
                        <tr><td class="num-cell">36</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>LeetCode</td><td class="prob-name trap-name"><a class="lc-link" href="https://leetcode.com/problems/construct-binary-search-tree-from-preorder-traversal/" target="_blank">1008 – Construct BST from Preorder Traversal ⚠️</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">⚠️ TRAP — BST insertion order matters; NOT a general tree technique</td><td>Monotone stack insertion O(n) exploits BST property; general tree construction approach is O(n log n) for non-BST</td><td class="insight">NOT a general tree technique: BST property is fundamental; treating it as a general tree problem wastes the BST structure</td></tr>
                        </tbody></table></div>'''

# ── SECTION B ─────────────────────────────────────────────────────────────
NEW += '''
                    <div class="info-box" style="padding:.4rem .8rem;margin-bottom:.4rem;margin-top:.8rem"><strong>📌 Section B — Directed Trees</strong> (Rooted; Parent → Child Direction Matters)</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>S.No</th><th>Layer</th><th>Stage</th><th>Source</th><th># / Name</th><th>Difficulty</th><th>P</th><th>Sub-Variant</th><th>New Idea Added</th><th>Key Insight</th></tr></thead>
                        <tbody>
                        <tr><td class="num-cell">37</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximum-difference-between-node-and-ancestor/" target="_blank">1026 – Max Difference Between Node and Ancestor</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">DFS carrying (min, max) along root-to-node path</td><td>Top-down DFS passes running min AND max from root; ans = max(node − running_min, running_max − node)</td><td class="insight">TWO values carried top-down; answer updated at each node with current path extrema</td></tr>
                        <tr><td class="num-cell">38</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/count-good-nodes-in-binary-tree/" target="_blank">1448 – Count Good Nodes in Binary Tree</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Top-down DFS carrying running maximum</td><td>ONE change: carry single running max; count nodes where node.val ≥ running_max</td><td class="insight">Simpler top-down than S.No 37; single running state suffices</td></tr>
                        <tr><td class="num-cell">39</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/cycle-length-queries-in-a-tree/" target="_blank">2509 – Cycle Length Queries in a Tree</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Binary Lifting on implicit ancestor structure</td><td>LCA via binary lifting; cycle length = depth[u] + depth[v] − 2×depth[LCA] + 1; query for each (u,v) pair</td><td class="insight">Hard: combining LCA distance formula with query answering; cycle = path(u,v) + edge(v,u); WHY hard: the "+1" for closing the cycle is easy to miss under pressure</td></tr>
                        <tr><td class="num-cell">40</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/closest-leaf-in-a-binary-tree/" target="_blank">742 – Closest Leaf in Binary Tree ✅</a></td><td><span class="diff-m">Medium</span></td><td>✅</td><td class="variant-cell">Convert to undirected + BFS from leaf set</td><td>Transform directed tree to undirected; BFS from all leaves simultaneously; answer for k-node = first node in k's subtree reached</td><td class="insight">Stage 4: directed tree → undirected graph → multi-source BFS; transformation IS the hard part</td></tr>
                        <tr><td class="num-cell">41</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/difference-between-maximum-and-minimum-price-sum/" target="_blank">2538 – Difference Between Maximum and Minimum Price Sum</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Rerooting DP with two directional best-path values</td><td>dp[v] = max path sum starting at v going DOWN; rerooting adds "path going UP through parent"; answer = max − min path through each node</td><td class="insight">Hard: rerooting where the "up" contribution requires careful updating to avoid double-counting; WHY hard: correctly separating the two best arms to avoid using same path twice</td></tr>
                        </tbody></table></div>'''

# ── SECTION C ─────────────────────────────────────────────────────────────
NEW += '''
                    <div class="info-box" style="padding:.4rem .8rem;margin-bottom:.4rem;margin-top:.8rem"><strong>📌 Section C — Grid / Spatial Trees</strong> (Trees Embedded in a Grid or Space)</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>S.No</th><th>Layer</th><th>Stage</th><th>Source</th><th># / Name</th><th>Difficulty</th><th>P</th><th>Sub-Variant</th><th>New Idea Added</th><th>Key Insight</th></tr></thead>
                        <tbody>
                        <tr><td class="num-cell">42</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/time-needed-to-inform-all-employees/" target="_blank">1376 – Time Needed to Inform All Employees</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">DFS on adjacency list (rooted tree); max path accumulation</td><td>Manager → employee = directed tree; time = max root-to-leaf path weight; DFS computes this</td><td class="insight">Org chart = rooted tree with edge weights; same DFS as S.No 2 but weighted</td></tr>
                        <tr><td class="num-cell">43</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/all-nodes-distance-k-in-binary-tree/" target="_blank">863 – All Nodes Distance K in Binary Tree</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">BFS on tree after adding parent pointers</td><td>Convert binary tree to undirected (add parent edges); BFS from source for exactly K steps</td><td class="insight">Adding parent pointers converts directed to undirected; BFS works on undirected tree</td></tr>
                        <tr><td class="num-cell">44</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/merge-bsts-to-create-single-bst/" target="_blank">1932 – Merge BSTs to Create Single BST</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">DFS tree merge; in-order validation</td><td>Identify roots (nodes not appearing as leaf values); merge by replacing leaves with matching root trees; validate BST invariant in-order</td><td class="insight">Hard: multiple trees merged into one by value matching; structural recursion on merged tree; WHY hard: cycle detection + BST validation + correct merge all required simultaneously</td></tr>
                        </tbody></table></div>'''

# ── SECTION D ─────────────────────────────────────────────────────────────
NEW += '''
                    <div class="info-box" style="padding:.4rem .8rem;margin-bottom:.4rem;margin-top:.8rem"><strong>📌 Section D — Implicit Trees</strong> (Graph NOT Given; Must Be Modeled)</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>S.No</th><th>Layer</th><th>Stage</th><th>Source</th><th># / Name</th><th>Difficulty</th><th>P</th><th>Sub-Variant</th><th>New Idea Added</th><th>Key Insight</th></tr></thead>
                        <tbody>
                        <tr><td class="num-cell">45</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/tree-of-coprimes/" target="_blank">1766 – Tree of Coprimes</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">DFS on explicit tree; ancestor tracking by remainder classes</td><td>For each node v with value a[v], find nearest ancestor u with gcd(a[u], a[v]) = 1; maintain stack per value 1..50; fast lookup via coprimes of a[v]</td><td class="insight">Hard: relevant ancestor is found via NUMBER THEORY (coprime lookup table), not tree structure alone; WHY hard: combining DFS ancestor tracking with mathematical property lookup</td></tr>
                        <tr><td class="num-cell">46</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/number-of-ways-to-reorder-array-to-get-same-bst/" target="_blank">1569 – Number of Ways to Reorder Array to Get Same BST</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Implicit BST structure; tree DP on recursively defined subtrees</td><td>Given array → implicit BST structure; count orderings preserving BST = product of C(left+right, left) at each node recursively</td><td class="insight">Hard: the tree is IMPLICIT (derived from array values); recognising that BST insertion order defines a tree structure; WHY hard: the combinatorial formula and modular arithmetic combined with implicit tree DP</td></tr>
                        <tr><td class="num-cell">47</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/number-of-good-paths/" target="_blank">2421 – Number of Good Paths</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Implicit forest via sorted node processing; DSU on edges</td><td>Sort nodes by value; add edges in increasing node-value order; use DSU to count paths with equal max-value endpoints</td><td class="insight">Hard: the "tree" emerges from processing edges in value order; DSU tracks component sizes for counting; WHY hard: recognising that "paths where max = both endpoints" = count pairs of equal-value nodes in same component at insertion time</td></tr>
                        <tr><td class="num-cell">48</td><td><span class="l4">4</span></td><td>5</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/count-subtrees-with-max-distance-between-cities/" target="_blank">1617 – Count Subtrees with Max Distance Between Cities</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Implicit tree on subsets; BFS/diameter for each subset</td><td>Enumerate all 2^n subsets of cities; for each subset, verify it forms a connected subtree and compute diameter</td><td class="insight">Hard: brute-force is O(2^n × n); optimisation uses bitmask + BFS; implicit "is this subset a valid subtree?" check requires connectivity + diameter verification; WHY hard: combining bitmask enumeration with tree structural validation</td></tr>
                        <tr><td class="num-cell">49</td><td><span class="l4">4</span></td><td>5</td><td>🔧 CUSTOM</td><td class="prob-name">Interval Containment Tree</td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Implicit forest via interval containment; tree DP on extracted structure</td><td>Sort intervals; use stack to build containment tree (parent = smallest containing interval); run dp[v][0/1] MIS DP on the extracted forest</td><td class="insight">Tree structure emerges from interval containment; parent = smallest containing interval; standard subtree DP then applies</td></tr>
                        </tbody></table></div>'''

# ── CUSTOM PROBLEM STATEMENT ──────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Custom Problem Statement</div>
                    <div class="info-box">
                        <strong>🔧 CUSTOM — S.No 49: Interval Containment Tree</strong><br><br>
                        <strong>Problem:</strong> Given n intervals [l_i, r_i] (all distinct, all endpoints distinct, 1 ≤ l_i &lt; r_i ≤ 10⁹), two intervals are in a parent-child relationship if one CONTAINS the other and there is no third interval "between" them (no intermediate container). This defines a forest. Each interval has a weight w_i. Find the maximum weight independent set of this forest (no two selected intervals are in a parent-child relationship in the containment tree).<br><br>
                        <strong>Input:</strong> n intervals with weights. n ≤ 2×10⁵. &nbsp;<strong>Output:</strong> Maximum weight independent set on the containment forest.<br>
                        <strong>Stage:</strong> Stage 4 (implicit tree) + Stage 3 (tree DP on extracted forest).<br><br>
                        <strong>Intended solution:</strong><br>
                        1. Sort intervals by left endpoint ascending, break ties by right endpoint descending.<br>
                        2. Use a stack to build the containment tree: stack holds open "parent candidates"; when a new interval starts, its parent = stack top if contained; push current interval.<br>
                        3. Run dp[v][0/1] = maximum weight independent set on the extracted forest (same as S.No 10 — House Robber III).<br>
                        <strong>Time complexity:</strong> O(n log n) for sorting + O(n) for tree construction + O(n) for tree DP.
                    </div>'''

# ── STATE EVOLUTION FOR TREE DP ───────────────────────────────────────────
NEW += '''
                    <div class="sec-title">State Evolution for Tree DP</div>
                    <div class="core-box" style="line-height:1.8">
                        <strong>Group: dp[v][0/1] — Two-State Tree DP (MIS / Camera / Robber)</strong><br><br>
                        <strong>Stage 1 state:</strong> dp[v] = max_value_in_subtree_of_v<br>
                        Recurrence: dp[v] = val[v] + Σ dp[child]<br>
                        Base case: dp[leaf] = val[leaf]<br>
                        Preferred: bottom-up (post-order DFS) — children must be computed first<br><br>
                        <strong>Stage 2 state:</strong> dp[v][s] where s ∈ {0=excluded, 1=included}<br>
                        Recurrence: dp[v][1] = val[v] + Σ dp[child][0]; &nbsp;dp[v][0] = Σ max(dp[child][0], dp[child][1])<br>
                        Base case: dp[leaf][1] = val[leaf]; dp[leaf][0] = 0<br>
                        Preferred: bottom-up — child states consumed during parent's computation<br><br>
                        <strong>Stage 3 state:</strong> dp[v][s] where s ∈ {0=not_covered, 1=has_camera, 2=covered_by_child}<br>
                        Recurrence (Camera problem): see state machine — 6 combinations of child states determine parent transitions<br>
                        Base case: dp[leaf][0] = 0 (needs coverage from parent), dp[leaf][1] = 1, dp[leaf][2] = INF<br>
                        Preferred: bottom-up; optimisation: memoised top-down is simpler for 3+ state machines; pure DFS is O(n)<br><br>
                        <strong>Stage 4 state:</strong> dp[v][k] = maximum value using exactly k nodes from subtree of v<br>
                        Recurrence: dp[v][k] = val[v] + max over j: dp[child][j] + dp[rest_of_subtree][k-1-j]<br>
                        This is the tree knapsack: O(n²) naïve, O(n log n) with small-to-large or DFS order merging<br>
                        Preferred: bottom-up with careful size tracking; top-down with memoisation also correct<br>
                        Optimisation: merge DPs in DFS order (process children one by one; accumulated DP has size = subtree processed so far) → O(n²) total; small-to-large reduces to O(n log² n)
                    </div>'''

# ── PATTERN RECOGNITION TRIGGERS ─────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Pattern Recognition Triggers</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>Linguistic Triggers:</strong><br>
                        • "find the [max/min/sum] for each node considering its entire subtree" → Stage 1/2 bottom-up DFS; post-order accumulation; O(n)<br>
                        • "find the answer if the tree is re-rooted at each node" → Stage 2 rerooting; two-pass DFS; second pass carries top-down contribution; O(n)<br>
                        • "queries on path from u to v" → Stage 4 HLD or Stage 3 LCA + binary lifting; path = O(log n) chains or O(log n) ancestor jumps<br>
                        • "count paths with property P in the tree" → Stage 4 centroid decomposition; every path passes through exactly one centroid in decomp tree; O(n log n)<br>
                        • "for each node, find the nearest/farthest ancestor/descendant satisfying condition" → Stage 3 Euler tour + BIT OR Stage 3 binary lifting with augmented table<br><br>
                        <strong>Structural Triggers:</strong><br>
                        • Input is a parent array parent[i] → rooted tree; DFS from root; O(n) traversal; check if problem is subtree-local (Stage 1) or path-based (Stage 3+)<br>
                        • Answer for node v depends ONLY on values in its subtree → pure bottom-up; no rerooting needed<br>
                        • Queries arrive online AND involve paths/subtrees → HLD + segment tree with updates; O(log² n) per query<br><br>
                        <strong>Constraint Triggers:</strong><br>
                        • n ≤ 10⁵ AND path queries with updates → HLD + segment tree; O(n log² n) total<br>
                        • n ≤ 2×10⁵ AND offline path counting → centroid decomposition; O(n log n)<br><br>
                        <strong>Anti-Triggers (do NOT apply tree techniques):</strong><br>
                        • "find the minimum spanning tree" → NOT tree algorithms (the tree is the OUTPUT) → Use Kruskal/Prim on edge weights<br>
                        • "find all paths between every pair of nodes" → NOT tree DP or HLD → All-pairs shortest paths (Floyd-Warshall O(n³) or BFS/Dijkstra per source)<br>
                        • "find the maximum flow from source to sink in a tree" → tree max-flow = min edge weight on path (LCA + binary lifting); if phrased with multiple paths, standard flow algorithms apply
                    </div>'''

# ── DECISION FRAMEWORK ────────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Decision Framework</div>
                    <div class="info-box">
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code>Q1: Is the input a tree (connected, n-1 edges, no cycles)?
  → YES: Continue.
  → NO:  Is there an implicit tree structure?
         (containment, BST insertion order, ancestor-dependency?)
         If YES: extract the tree first (Stage 4 reduction), then proceed.
         If NO: this is a general graph problem.

Q2: Is the answer for each node determined ONLY by its subtree?
  → YES: Pure bottom-up DFS (post-order). Stage 1. O(n).
  → NO:  Continue.

Q3: Does the answer change if the root changes?
    (i.e., does the answer depend on the "upward" part of the tree?)
  → YES: Two-pass rerooting. Stage 2. O(n).
         First pass: bottom-up accumulation.
         Second pass: top-down propagation of "contribution from above."
  → NO:  Continue.

Q4: Does the answer at each node depend on a CHOICE
    (include/exclude, state machine with 2–3 states)?
  → YES: Tree DP. dp[v][state]. Stage 3. O(n × |states|).
         If state space is small (≤ 3): pure DFS, no optimisation.
         If state = budget k: tree knapsack; O(n²) naïve.
  → NO:  Continue.

Q5: Are there QUERIES on the tree (not a single-answer problem)?
  → Q5a: Are queries on SUBTREES?
          → YES: Euler tour (DFS in/out timestamps) + BIT/segment tree.
                 Stage 3. O(n log n) preprocess + O(log n) per query.
  → Q5b: Are queries on PATHS (u → v)?
          → YES: LCA needed?
                   Static (no updates): Binary Lifting LCA.
                   With path aggregation: HLD + segment tree. Stage 4.
  → Q5c: Are queries COUNTING paths with a property?
          → YES: Centroid decomposition. O(n log n). Stage 4–5.
  → NO:  Continue.

Q6: Is the naive solution O(n²) or worse?
  → YES: Identify the bottleneck:
         - Merging child sets        → small-to-large (DSU on tree). O(n log n). Stage 5.
         - Range query per node      → Euler tour + BIT. O(n log n). Stage 5.
         - Knapsack merging          → small-to-large DP. O(n log² n). Stage 5.
         - Sparse queries on k nodes → virtual tree. O(k log n)/query. Stage 5.
  → NO:  Your current approach is optimal.

──────────────────────────────────────────────
Stage identification:
  Q2 (subtree-only)         → Stage 1. O(n).
  Q3 (rerooting)            → Stage 2. O(n).
  Q4 (tree DP)              → Stage 3. O(n) to O(n²).
  Q5 (queries)              → Stage 3–4. O(n log n) to O(n log² n).
  Q6 (optimisation needed)  → Stage 5. O(n log n) or O(n log² n).
──────────────────────────────────────────────</code></pre>
                    </div>'''

# ── WHEN THIS TECHNIQUE BREAKS ────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">When This Technique BREAKS</div>
                    <div class="warn-box"><strong>[Stage 1] Applying bottom-up DFS when the answer depends on the direction of traversal (re-rooting needed):</strong> For problems like "sum of distances to all nodes," a single bottom-up pass gives only the subtree sum, not the total. Fix: two-pass rerooting (Stage 2). Wrong model: assuming every tree problem is a single DFS.</div>
                    <div class="warn-box"><strong>[Stage 2] Rerooting with incorrect transition formula:</strong> When re-rooting from parent p to child v, the formula is: ans[v] = ans[p] + (n − subtree_size[v]) − subtree_size[v]. Off-by-one in subtree sizes or missing the "gain from rest of tree" causes wrong answers. Fix: derive the formula by manually computing ans[v] for a 3-node tree before generalising.</div>
                    <div class="warn-box"><strong>[Stage 3] Tree DP with incorrect merging of child states (double-counting):</strong> In knapsack-on-tree DP, merging child DPs naïvely looks O(n²) per node but is O(n²) globally (each pair (u, v) contributes at their LCA). Fix: always verify complexity with the "pairs-at-LCA" argument, not the per-node subtree size squared.</div>
                    <div class="warn-box"><strong>[Stage 3] LCA returning incorrect result when u = LCA or v = LCA:</strong> The standard binary lifting LCA handles the case where one node IS the LCA by checking equality after depth alignment. If this check is skipped, the algorithm overshoots. Fix: after bringing both nodes to the same depth, check equality BEFORE doing the binary search phase.</div>
                    <div class="warn-box"><strong>[Stage 4] HLD: incorrect segment tree index mapping:</strong> HLD assigns new positions to nodes based on heavy chain order. Forgetting that the segment tree index = pos[v] (not v itself) causes reads/writes at wrong positions. Fix: always use pos[v] when accessing the segment tree; never use v directly.</div>
                    <div class="warn-box"><strong>[Stage 4] Centroid decomposition: counting paths through the centroid that stay within one subtree as "cross-centroid" paths:</strong> When computing paths through centroid c, you must ADD paths from all subtrees then SUBTRACT paths within each individual subtree (inclusion-exclusion). Missing the subtraction double-counts paths that don't pass through c. Fix: for each subtree, compute the contribution then subtract back.</div>
                    <div class="warn-box"><strong>[Stage 5] Small-to-large merging: merging the LARGE into the SMALL instead of vice versa:</strong> This reverses the complexity benefit. Small-to-large works because each element can be moved O(log n) times (each merge at least doubles the set it moves into). Merging large into small means elements move into smaller sets, losing the bound. Fix: always iterate over the SMALLER set and insert into the LARGER.</div>'''

# ── PROOF OF CORRECTNESS SKELETON ────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Proof of Correctness Skeleton</div>
                    <div class="core-box">
                        <strong>Stage 1 — Tree Diameter via DFS (Bottom-Up)</strong><br>
                        <em>Claim:</em> The global diameter = max over all nodes v of: (max_depth_left_subtree[v] + max_depth_right_subtree[v]).<br>
                        <em>Proof:</em> Every path in the tree has a unique highest node (the node where the path "bends"). For any path P with endpoints a and b, let v = LCA(a, b). Then length of P = depth_in_subtree(a, v) + depth_in_subtree(b, v), which equals the sum of the two deepest arms in the subtrees of v's children. The DFS considers v as the "bend node" when processing v's children. Since the DFS visits every node as a potential bend node, the global maximum over all v is the true diameter. □<br><br>
                        <strong>Stage 3 — Binary Lifting LCA Correctness</strong><br>
                        <em>Claim:</em> After preprocessing ancestor[v][k] = 2^k-th ancestor of v, LCA(u, v) is computed correctly in O(log n).<br>
                        <em>Proof sketch:</em> (1) Depth alignment: If depth[u] &gt; depth[v], lift u by exactly depth[u] − depth[v] using binary representation. After this step, depth[u] = depth[v]. ✓ (2) Equal depth, different nodes: We want to find the highest bit k such that ancestor[u][k] ≠ ancestor[v][k]. We lift both by 2^k. After processing all bits from high to low, u and v are just below the LCA. ✓ (3) Why we never overshoot: We only lift when ancestor[u][k] ≠ ancestor[v][k]. If ancestor[u][k] = ancestor[v][k] = LCA or above, we do NOT lift — this correctly stops us from going past the LCA. After all bits processed, parent[u] = parent[v] = LCA. □<br><br>
                        <strong>Stage 5 — Small-to-Large Merging Complexity O(n log n)</strong><br>
                        <em>Claim:</em> If we always merge smaller set into larger, each element participates in O(log n) merges, giving O(n log n) total.<br>
                        <em>Proof sketch:</em> Each time an element e is moved from set S_small into set S_large (|S_small| ≤ |S_large|), the set containing e at least DOUBLES in size (moves from ≤ x into ≥ x, giving new size ≥ 2x). Starting from size 1, the size can double at most O(log n) times before reaching n. Therefore, element e participates in at most O(log n) merges. With n elements and O(log n) merges each, total operations = O(n log n). □
                    </div>'''

# ── IMPLEMENTATION PITFALLS ───────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Implementation Pitfalls (Code-Level)</div>
                    <div class="warn-box"><strong>Bug 1 — Diameter: returning depth instead of max-arm to parent [Stage 1]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: returns full diameter instead of single arm
def dfs(node):
    if not node: return 0
    l, r = dfs(node.left), dfs(node.right)
    self.ans = max(self.ans, l + r)
    return l + r   # BUG: parent receives sum of both arms
# FIX: return max single arm
    return 1 + max(l, r)   # FIX: parent extends one arm only</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 2 — Rerooting: using wrong subtree size in transition [Stage 2]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># CORRECT formula (easy to get wrong under pressure):
ans[v] = ans[parent] + (n - subtree_size[v]) - subtree_size[v]
# Common BUG: uses parent size instead of child's size
ans[v] = ans[parent] + n - 2 * subtree_size[parent]   # BUG: uses parent size
# FIX: must use CHILD's subtree size, not parent's
# Derivation: moving root from parent to v:
#   nodes in v's subtree: each gets 1 closer = -subtree_size[v]
#   nodes NOT in v's subtree: each gets 1 farther = +(n - subtree_size[v])</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 3 — LCA binary lifting: initialising root's ancestor incorrectly [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: root has no parent; ancestor[root][0] left uninitialised or set to -1
ancestor[root][0] = -1   # BUG: subsequent lifts access ancestor[-1][k] = garbage
# FIX: set root's ancestor to itself (lifting past root stays at root)
ancestor[root][0] = root   # FIX: safe for all lifting operations</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 4 — DFS on undirected tree without tracking parent: infinite loop [Stage 1]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: undirected tree stored as bidirectional adjacency list; DFS cycles back
def dfs(node):
    for neighbor in adj[node]:
        dfs(neighbor)   # BUG: visits parent again → infinite recursion
# FIX: pass parent to DFS; skip the edge back to parent
def dfs(node, parent):
    for neighbor in adj[node]:
        if neighbor != parent:
            dfs(neighbor, node)</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 5 — Tree DP dp[v][0]: locking children to excluded state [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code>dp[v][1] = val[v] + sum(dp[c][0] for c in children)   # CORRECT
dp[v][0] = sum(dp[c][0] for c in children)             # BUG: locks children to excluded
# FIX: when v is excluded, each child is FREE to be included OR excluded
dp[v][0] = sum(max(dp[c][0], dp[c][1]) for c in children)   # FIX</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 6 — Euler tour: off-by-one in subtree range query [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: subtree query as [in[v], out[v]) — exclusive end misses last node
bit.range_query(in[v], out[v])       # BUG if out[v] = in[v] (leaf node: query empty)
# FIX: DFS assigns out[v] AFTER all descendants; query is INCLUSIVE [in[v], out[v]]
bit.range_query(in[v], out[v] + 1)   # FIX: inclusive range with 0-indexed BIT
# OR: use 1-indexed in/out times and query [in[v], out[v]] inclusive</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 7 — Binary lifting: incorrect aggregate merge during doubling step [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: when computing "sum of values on path to k-th ancestor",
# val[v][k] is mistakenly set as just the value at the 2^k-th ancestor
val[v][k] = a[ancestor[v][k-1]]   # BUG: only single node value, not path sum
# FIX: val[v][k] = SUM of values on the 2^k steps FROM v
val[v][k] = val[v][k-1] + val[ancestor[v][k-1]][k-1]   # FIX: accumulate both halves</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 8 — HLD: always moving u upward without checking which chain is deeper [Stage 4]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: always lifting u without ensuring u's chain head is deeper than v's
while chain_head[u] != chain_head[v]:
    seg_tree.query(pos[chain_head[u]], pos[u])
    u = parent[chain_head[u]]   # BUG: should lift the DEEPER chain head each step
# FIX: always lift the node whose chain head is deeper
while chain_head[u] != chain_head[v]:
    if depth[chain_head[u]] &lt; depth[chain_head[v]]:
        u, v = v, u   # ensure u's chain head is deeper
    result = combine(result, seg_tree.query(pos[chain_head[u]], pos[u]))
    u = parent[chain_head[u]]</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 9 — Centroid decomposition: not marking centroid as removed before recursion [Stage 4]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: centroid c is not removed before recursing; included in child component sizes
c = get_centroid(root, -1, component_size)
for u in adj[c]:
    if not removed[u]:
        decompose(u)   # BUG: c still exists; get_centroid sees it as part of component
# FIX: mark centroid as removed IMMEDIATELY after finding it
c = get_centroid(root, -1, component_size)
removed[c] = True   # FIX: must mark BEFORE recursing
for u in adj[c]:
    if not removed[u]:
        decompose(u)</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 10 — Small-to-large: iterating over larger set, inserting into smaller [Stage 5]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: wrong merge direction destroys the O(n log n) bound
for elem in large_set:
    small_set.add(elem)   # BUG: inserting large into small; elements not doubling
result = small_set        # BUG: also wrong set returned
# FIX: always iterate over SMALLER, insert into LARGER
if len(a) &lt; len(b):
    a, b = b, a   # ensure a is larger
for elem in b:    # iterate smaller (b)
    a.add(elem)   # insert into larger (a)
result = a</code></pre>
                    </div>'''

# ── RED FLAGS / COMMON MISTAKES ───────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Red Flags / Common Mistakes</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>[Stage 1] Treating tree problems as graph BFS problems:</strong> Candidates run BFS on trees for problems that only require a single DFS. BFS cannot naturally maintain the "subtree universe" invariant that makes tree DP work. Correct model: for any tree problem where the answer at v depends only on v's subtree, use DFS (post-order). BFS is for level-by-level or multi-source propagation.<br>
                        <strong>[Stage 2] Missing the rerooting insight and solving O(n) per query instead:</strong> For "sum of distances" problems, candidates run BFS from each node — O(n²) total. The correct rerooting formula ans[child] = ans[parent] + (n − 2 × subtree_size[child]) must be DERIVED before coding. Correct model: when re-rooting from p to child v, ask "which nodes get closer? which get farther?" — nodes in v's subtree get 1 closer; all others get 1 farther.<br>
                        <strong>[Stage 3] Binary lifting LCA: forgetting to check u == v after depth alignment:</strong> After bringing u and v to the same depth, if they happen to be equal, that node IS the LCA. Skipping this check and entering the binary search phase gives wrong results. Correct model: check u == v immediately after depth alignment; this is the "path goes straight through one node" case.<br>
                        <strong>[Stage 4] HLD: building the segment tree on node IDs instead of HLD positions:</strong> HLD assigns a new pos[v] to each node based on chain traversal order. Using v directly in the segment tree gives wrong answers because the heavy-chain contiguity property relies on the new ordering. Correct model: after HLD assignment, the segment tree lives in pos[] space. Always translate: seg[pos[v]] = val[v].<br>
                        <strong>[Stage 4] Centroid decomposition: forgetting to subtract paths that don't pass through the centroid:</strong> The centroid decomposition counts paths from EVERY node in the current component through the centroid. Paths where BOTH endpoints are in the SAME sub-component don't pass through the centroid and must be subtracted. Correct model: total paths through centroid c = (all paths from c's component) − (paths within each sub-component). Always implement inclusion-exclusion.<br>
                        <strong>[Stage 5] Applying HLD when centroid decomposition is more appropriate (and vice versa):</strong> HLD optimises PATH QUERIES on a FIXED tree with UPDATES. Centroid decomposition answers COUNTING QUERIES over ALL PATHS without updates. Correct model: HLD = "given a specific path (u, v), query/update it efficiently." Centroid = "count/aggregate over ALL paths satisfying a property."<br>
                        <strong>[Stage 3] Tree DP: starting DFS from wrong root:</strong> If the problem root is node 0 but the tree is stored 1-indexed, starting DFS from node 0 produces wrong parent-child relationships. Correct model: always verify the root before starting DFS; print the tree structure for a small example and visually confirm.
                    </div>'''

# ── INTERVIEWER FOLLOW-UP QUESTIONS ──────────────────────────────────────
NEW += '''
                    <div class="sec-title">Interviewer Follow-Up Questions</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>#</th><th>Stage</th><th>Question</th><th>Intended Answer Direction</th></tr></thead>
                        <tbody>
                        <tr><td>1</td><td>2</td><td>"Your diameter solution uses DFS. What if the tree had edge weights that could be negative?"</td><td>With negative edges, the diameter is still computable via the same DFS structure (post-order, update global at bend node); however, arms must be clamped to 0 if negative (a path can always stop earlier); negative edges can make shortest path = longest path — clarify if the problem asks for longest or heaviest path</td></tr>
                        <tr><td>2</td><td>2</td><td>"Sum of distances works in O(n). What if nodes have weights and you want the weighted sum of distances?"</td><td>Same two-pass rerooting; replace +1 per node with +weight[node] per node; the formula becomes ans[v] = ans[parent] + (total_weight − 2 × subtree_weight[v]) where subtree_weight[v] = sum of weights in v's subtree</td></tr>
                        <tr><td>3</td><td>3</td><td>"Your binary lifting uses O(n log n) space. Can you do LCA in O(n) space?"</td><td>Yes: Euler tour + sparse table for RMQ on depth array; RMQ gives O(1) per query with O(n log n) preprocess; or use O(n) Farach-Colton and Bender algorithm (impractical but theoretically optimal); binary lifting is the practical standard at O(n log n) space and O(log n) query</td></tr>
                        <tr><td>4</td><td>3</td><td>"How would you handle path sum queries on a tree with point updates?"</td><td>HLD + segment tree with point updates; each update changes at most one position in the segment tree (O(log n)); each path query traverses O(log n) chains and queries O(log n) range per chain = O(log² n) total; alternatively, Euler tour + BIT if only subtree updates/queries are needed</td></tr>
                        <tr><td>5</td><td>4</td><td>"Extend your HLD solution to handle SUBTREE updates (add x to all nodes in subtree of v) AND path queries."</td><td>Subtree update in HLD = range update on [in[v], out[v]] in DFS order; path query = HLD chain queries; use a lazy segment tree that supports both range update and range query; the key insight: DFS order for subtrees and HLD order for paths are DIFFERENT orderings, but the HLD assignment can be made consistent with DFS order by assigning HLD positions in a DFS-order-compatible way</td></tr>
                        <tr><td>6</td><td>4</td><td>"What is the difference between centroid decomposition and heavy-light decomposition? When would you use each?"</td><td>HLD: decomposes paths into O(log n) contiguous array segments for per-path queries/updates on a FIXED tree. Centroid: decomposes the tree into O(log n) depth layers for counting/aggregating over ALL paths in the tree. Use HLD when you have specific (u, v) path queries with updates. Use centroid when you need to count paths satisfying a global property (sum = k, length = k, etc.).</td></tr>
                        <tr><td>7</td><td>5</td><td>"How do you build a virtual tree on k key nodes? Walk me through the steps."</td><td>(1) Compute Euler tour timestamps for all nodes. (2) Sort the k key nodes by DFS timestamp. (3) For each consecutive pair in sorted order, add their LCA to the key set. (4) Sort the augmented key set by DFS timestamp again. (5) Build the virtual tree using a stack: process nodes in DFS order; each node's parent in the virtual tree = the last node on the stack whose subtree contains the current node. Result: O(k) nodes, O(k log n) construction.</td></tr>
                        <tr><td>8</td><td>5</td><td>"Your tree knapsack is O(n²). How would you optimise it for a budget of K ≤ sqrt(n)?"</td><td>For small K: the tree knapsack merges DPs of total size O(n × K) which is O(n × sqrt(n)) — already better than O(n²). The key observation is that the total work in merging is bounded by O(n × K) using the DFS-order merge argument: each pair of nodes (u, v) contributes only once at their LCA and only if both nodes are within the budget K. For K = sqrt(n), this gives O(n^1.5).</td></tr>
                        <tr><td>9</td><td>Beyond</td><td>"How would you support link/cut operations on a tree while maintaining path queries?"</td><td>Link-Cut Trees (LCTs): represent the tree as a set of "preferred paths" each stored in a splay tree; link(u, v) adds edge and updates preferred paths; cut(u, v) removes edge; path query = access(u), access(v), then query the splay tree; O(log n) amortised per operation; implementation is 200+ lines and rarely expected in interviews — knowing it exists and its complexity is sufficient</td></tr>
                        <tr><td>10</td><td>Beyond</td><td>"You have a tree with 10⁶ nodes. You need to answer 10⁵ path queries, each asking for the median value on the path from u to v. What is your approach?"</td><td>HLD decomposes each path into O(log n) chains; each chain is a range in the HLD array; for median on a range, use a merge sort tree or wavelet tree (O(log² n) per query); total: O(n log² n) preprocess + O(log³ n) per query; alternative: persistent segment tree on Euler tour + LCA for offline queries in O(n log n + q log n)</td></tr>
                        </tbody></table></div>'''

# ── MASTERY PLAN ──────────────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">3-Phase Mastery Plan</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>Phase 1 — Solve (strictly by Stage):</strong><br>
                        <em>Stage 1 — Establish the post-order DFS invariant:</em><br>
                        S.No 2 (Max Depth) → S.No 1 (Diameter) → S.No 3 (Path Sum, top-down) → S.No 4 (Path Sum III, DFS + hashmap) → S.No 5 (Max Path Sum, arm vs. bend) → S.No 42 (weighted DFS)<br>
                        After these: write any bottom-up DFS from scratch in under 5 minutes; state "what does the return value represent?" before coding<br><br>
                        <em>Stage 2 — Add rerooting:</em><br>
                        S.No 37 (top-down min/max) → S.No 38 (good nodes count) → S.No 7 (Sum of Distances) → S.No 8 (conditional rerooting) → S.No 9 (n-ary diameter)<br>
                        Drill: for each rerooting problem, derive the O(1) formula for ans[child] = f(ans[parent]) on paper before coding<br><br>
                        <em>Stage 3 — Tree DP and LCA basics:</em><br>
                        S.No 10 (House Robber III) → S.No 11 (Tree Cameras, 3-state) → S.No 17 (LCA DFS) → S.No 19 (Binary Lifting) → S.No 21 (Euler tour + BIT) → S.No 13 (ZigZag, directional state) → S.No 43 (BFS + parent pointers)<br>
                        Critical drill: implement binary lifting LCA from scratch twice; verify with a hand-traced example on a 7-node tree<br><br>
                        <em>Stage 4 — HLD and centroid decomp:</em><br>
                        S.No 24 (HLD baseline) → S.No 28 (HLD + updates) → S.No 30 (HLD + subtree update) → S.No 27 (centroid baseline) → S.No 33 (centroid + prime counting)<br>
                        For each: implement HLD from scratch until you can write it without errors in under 30 minutes<br><br>
                        <em>Stage 5 — Advanced optimisations:</em><br>
                        S.No 23 (small-to-large MEX) → S.No 25 (DSU on tree) → S.No 32 (tree knapsack small-to-large) → S.No 31 (virtual tree) → S.No 47 (implicit tree + DSU) → S.No 49 (interval containment tree DP)<br><br>
                        <strong>Phase 2 — Drill (speed and pattern recognition):</strong><br>
                        • Bottom-up DFS drill: given a new tree problem, state "return value", "global update", "base case" in 30 seconds before coding<br>
                        • Rerooting drill: given a subtree-only answer, derive the rerooting formula for moving root from p to child v in under 2 minutes<br>
                        • Binary lifting drill: implement 1483 (Kth Ancestor) from scratch in under 15 minutes; no reference<br>
                        • HLD drill: implement path max query with HLD + segment tree in under 30 minutes; label "chain head", "pos[v]", "DFS order" explicitly in code<br>
                        • Stage recognition drill: cover problem titles; state Stage (1–5) and key technique in 15 seconds each<br><br>
                        <strong>Phase 3 — Validate (unseen problem sources):</strong><br>
                        • Stage 1–2: CSES Problem Set — Tree Algorithms section (all problems from "Subordinates" through "Finding a Centroid")<br>
                        • Stage 3–4: Codeforces Div. 1 C/D problems tagged "trees" from rounds not in this guide (filter by 1600–2200 difficulty)<br>
                        • Stage 4–5: USACO Platinum tree problems from recent years not listed here; AtCoder ABC/ARC F-level tree problems
                    </div>
                </div>
            </div>'''

# ── REPLACEMENT ───────────────────────────────────────────────────────────
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

start = content.find('<div class="topic-card" id="tp17">')
end_marker = '<div class="topic-card" id="tp18">'
end = content.find(end_marker, start)

print('start:', start, 'end:', end, 'old_len:', end - start)

new_content = content[:start] + NEW + '\n            ' + content[end:]
print('new_file_len:', len(new_content))

with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print('Done.')