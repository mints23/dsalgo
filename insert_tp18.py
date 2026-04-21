# -*- coding: utf-8 -*-
path = r"E:\PracticeProjec\dsalgofrog\src\pages\index.astro"
NEW = ''

NEW += '''<div class="topic-card" id="tp18">
                <div class="topic-header">
                    <div class="topic-num">13</div>
                    <div style="flex:1">
                        <div style="display:flex;align-items:center;gap:.5rem;flex-wrap:wrap">
                            <div class="topic-title">Trie</div>
                            <span class="tier-badge tier-T1">Core Pattern</span>
                            <span class="topic-type">Prefix Tree · Binary XOR Trie · Wildcard · Offline Queries · Aho-Corasick · Persistent Trie · Trie + DP</span>
                        </div>
                        <div class="topic-meta">25 problems · 5 stages · standard prefix trie, binary XOR trie, wildcard, trie+DP, offline sorting, Aho-Corasick, persistent trie</div>
                    </div>
                </div>
                <div class="topic-body">'''

NEW += '''
                    <div class="info-box"><strong>Why This Topic Matters:</strong> Tries (prefix trees) are the canonical data structure for prefix-based string queries and XOR optimisation on integers. The core invariant is that <em>every node represents exactly one unique prefix, and shared prefixes share nodes</em> — making insert, search, and prefix-check all run in O(L) time (L = string length), independent of the number of strings stored. Tries appear in five distinct problem families: (1) prefix/suffix string matching, autocomplete, and word replacement, (2) XOR maximisation/minimisation on integer sets via binary tries, (3) word segmentation and grid word search via trie-driven DP and DFS, (4) multi-pattern stream matching via Aho-Corasick automata (trie + failure links), and (5) range XOR queries via persistent tries. Mastery of tries means mastery of the full complexity ladder from O(L) prefix lookup to O(b·log n) persistent range XOR queries — a span that covers problems from LeetCode Medium to IOI-level difficulty.</div>'''

NEW += '''
                    <div class="sec-title">The Mental Model</div>
                    <div class="info-box"><strong>A trie is a decision tree on characters (or bits).</strong> Each edge represents one character (or one bit) choice; each path from root to node spells one unique prefix; each path from root to a marked leaf spells one complete string. The one-sentence mental model: <em>"A trie materialises the set of all prefixes of your strings as a tree, so that any prefix query costs O(length of prefix), not O(number of strings)."</em><br><br>
                        <strong>How this mental model scales through the 5 stages:</strong><br>
                        • <strong>Stage 1 — Simplest form:</strong> Traverse one character at a time; array[26] children per node; isEnd flag. Insert/search/startsWith all cost O(L). The trie IS the algorithm.<br>
                        • <strong>Stage 2 — What changes:</strong> Augment each node with a counter or aggregated value. Wildcard '.' branches on ALL children (DFS). Delete operation requires reference counts at each node to safely prune branches.<br>
                        • <strong>Stage 3 — What expands:</strong> Replace alphabet {a..z} with bits {0, 1}. Now the trie answers XOR queries: the greedy opposite-bit walk maximises XOR. Combine binary trie with DP (word segmentation) or grid DFS (word search with pruning).<br>
                        • <strong>Stage 4 — What is hidden:</strong> The problem does NOT mention tries. But the input encodes a prefix/XOR constraint. Recognition: offline sort of queries → insert elements one by one into binary trie. Or: reverse all strings and insert → suffix becomes prefix. Or: failure links on trie = Aho-Corasick for multi-pattern matching.<br>
                        • <strong>Stage 5 — What is optimised:</strong> Persist trie versions across insertions (persistent trie) for range XOR queries. Or: Euler-tour a tree while maintaining a binary trie (add on DFS-enter, remove on DFS-exit) for per-node XOR queries.</div>'''

NEW += '''
                    <div class="sec-title">Core Invariants / Proof Sketches</div>
                    <div class="core-box">
                        <strong>Invariant 1: Prefix Uniqueness — O(L) per Operation</strong><br>
                        <em>Invariant:</em> Every node in a trie has a unique label = the string spelled by the root-to-node path. Insert and search of a string of length L each traverse exactly L nodes.<br>
                        <em>Proof sketch:</em> At step i, we follow the unique edge labelled s[i] from the current node. At most one such edge exists (since children are keyed by character). If it does not exist: insert creates it, search returns false. The work is exactly L steps per operation. No overlap exists between two strings' paths except at the shared prefix. □<br><br>
                        <strong>Invariant 2: Greedy Correctness for Binary Trie XOR Maximisation</strong><br>
                        <em>Invariant:</em> For a fixed query x and a binary trie containing integers, the greedy walk — at each bit b from MSB to LSB, choose the child whose bit differs from x's bit b (if it exists) — produces the maximum XOR.<br>
                        <em>Proof sketch:</em> XOR is maximised by maximising the most significant differing bit. At bit b, setting result bit b to 1 contributes 2^b. The total contribution of all lower bits is at most 2^0 + 2^1 + ... + 2^(b-1) = 2^b − 1 &lt; 2^b. Therefore, a greedy choice that sets the current bit to 1 always dominates any combination of lower bits, even if all lower bits are set to 0. By induction from MSB to LSB, the greedy path is globally optimal. □<br><br>
                        <strong>Invariant 3: Aho-Corasick Failure Link Correctness — O(n + m + z) Matching</strong><br>
                        <em>Invariant:</em> The failure link of node v points to the trie node spelling the longest proper suffix of path(v) that is also a prefix in the trie. During text processing, following failure links never re-processes a character.<br>
                        <em>Proof sketch:</em> The failure links form a DAG from each node toward the root. When a mismatch occurs at node v on character c, we follow fail(v) and retry c. The depth strictly decreases with each failure link traversal. Amortised over the entire text: each character advances the depth by at most 1 and causes at most 1 failure link traversal (since each failure link decreases depth). Total transitions ≤ 2n. With z total match outputs (reported via output links): total time = O(n + m + z). □
                    </div>'''

NEW += '''
                    <div class="sec-title">Sub-Variants to Master</div>
                    <div class="info-box" style="line-height:1.75">
                        <strong>Group 1 — Standard String Trie:</strong><br>
                        • <strong>Insert / search / startsWith</strong> — Stage 1 · O(L) per op · array[26] children + isEnd flag · baseline<br>
                        • <strong>Trie with prefix count</strong> — Stage 2 · O(L) per op · passCount field at each node · augmented node<br>
                        • <strong>Trie with weighted prefix sum</strong> — Stage 2 · O(L) per op · aggregated value field · replace count with sum<br>
                        • <strong>Suffix trie (reverse-insert)</strong> — Stage 2 · O(L) per op · reverse strings before inserting · suffix → prefix reduction<br>
                        • <strong>Trie with delete (reference counting)</strong> — Stage 2 · O(L) per op · endCount + prefixCount · safe node pruning<br>
                        • <strong>Wildcard '.' search</strong> — Stage 2 · O(26^L) worst case · DFS branch on '.' node · exponential branching<br><br>
                        <strong>Group 2 — Binary XOR Trie:</strong><br>
                        • <strong>Max XOR of two numbers in a set</strong> — Stage 3 · O(b) per op · bit 31 to 0; greedy opposite-bit · XOR = trie problem<br>
                        • <strong>Binary trie with insert/delete/query</strong> — Stage 3 · O(b) per op · count field per node; skip count-0 nodes · dynamic set<br>
                        • <strong>Count pairs with XOR in range [lo, hi]</strong> — Stage 3 · O(b·q) · subtree count; prefix counting at each bit · range XOR count<br>
                        • <strong>Max XOR in sliding window</strong> — Stage 3 · O(n·b) · two-pointer + trie with deletion · window constraint as sorted inequality<br>
                        • <strong>Offline binary trie (sorted queries)</strong> — Stage 4 · O((n+q)·b) · sort nums + queries by constraint; insert one by one · offline reduction<br>
                        • <strong>Binary trie on tree DFS</strong> — Stage 5 · O(n·b) total · DFS enter/exit = insert/remove from trie · Euler tour + trie<br>
                        • <strong>Persistent XOR trie</strong> — Stage 5 · O(b) per version; O(b) per query · shared nodes across versions · range XOR queries<br><br>
                        <strong>Group 3 — Trie + Algorithm Combination:</strong><br>
                        • <strong>Trie + DP (word segmentation)</strong> — Stage 3 · O(n·L) · trie drives valid transitions in DP · DP state on string position<br>
                        • <strong>Trie + grid DFS (multi-word search with pruning)</strong> — Stage 3 · O(m·n·4^L) pruned · trie node advanced with DFS; prune on word-found · trie enables O(1) prefix check in DFS<br>
                        • <strong>Trie-driven DP per word (concatenated words)</strong> — Stage 4 · O(k·L²) for k words of length L · exclude current word from trie during its DP · input transformation<br>
                        • <strong>Palindrome pairs via reversed trie</strong> — Stage 4 · O(n·L²) · insert reversed words; match prefix/suffix with palindrome check · dual-direction search<br>
                        • <strong>Combined prefix+suffix trie (encoded words)</strong> — Stage 4 · O(n·L²) preprocess, O(L) query · encode as suffix+"#"+word · dual constraint as single trie<br><br>
                        <strong>Group 4 — Advanced Trie Structures:</strong><br>
                        • <strong>Reverse trie + active cursor set (stream matching)</strong> — Stage 4 · O(n·m) amortised · insert reversed patterns; maintain active positions per character · suffix = prefix of reversed<br>
                        • <strong>Aho-Corasick automaton</strong> — Stage 4 · O(n + m + z) · BFS-computed failure links; output links · optimal multi-pattern matching<br>
                        • <strong>Compressed trie / Patricia trie</strong> — Stage 4 · O(L) per op · edge labels are strings not single chars · space optimisation
                    </div>'''

NEW += '''
                    <div class="sec-title">Complexity Staircase</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>Sub-Variant</th><th>Time</th><th>Space</th><th>What Changed from Previous</th></tr></thead>
                        <tbody>
                        <tr><td>Standard trie (insert/search/startsWith)</td><td>O(L) per op</td><td>O(26·n·L)</td><td>Baseline: character-by-character traversal with array[26] children</td></tr>
                        <tr><td>Trie with prefix count / weighted sum</td><td>O(L) per op</td><td>O(26·n·L)</td><td>Added counter or value field at each node; same traversal cost</td></tr>
                        <tr><td>Trie with delete (reference counting)</td><td>O(L) per op</td><td>O(26·n·L)</td><td>Two separate counts (endCount, prefixCount); decrement both on delete</td></tr>
                        <tr><td>Wildcard '.' search</td><td>O(26^d) worst case (d = depth)</td><td>O(26·n·L)</td><td>Wildcard triggers DFS branch over all non-null children; exponential branching</td></tr>
                        <tr><td>Binary XOR trie (max/min XOR)</td><td>O(b) per op (b = bit-width)</td><td>O(2·n·b)</td><td>Binary children (0/1); greedy opposite-bit walk replaces character walk</td></tr>
                        <tr><td>Binary XOR trie with delete</td><td>O(b) per op</td><td>O(2·n·b)</td><td>Count per node; skip count-0 child during query</td></tr>
                        <tr><td>XOR range count [lo, hi]</td><td>O(b) per query</td><td>O(2·n·b)</td><td>Subtree-size field; count(XOR &lt; limit) via bit-by-bit prefix counting</td></tr>
                        <tr><td>Trie + DP (word segmentation)</td><td>O(n·L)</td><td>O(26·k·L + n)</td><td>DP array indexed by string positions; trie drives which transitions are valid</td></tr>
                        <tr><td>Trie + grid DFS with pruning</td><td>O(m·n·4^L) worst → much less with pruning</td><td>O(26·k·L)</td><td>Trie node advanced with each DFS step; found-word branches pruned from trie</td></tr>
                        <tr><td>Offline binary XOR trie</td><td>O((n+q)·b)</td><td>O(2·n·b)</td><td>Sort queries and nums; insert incrementally; avoids rebuilding trie per query</td></tr>
                        <tr><td>Binary trie on tree DFS</td><td>O(n·b) total</td><td>O(2·n·b)</td><td>DFS enter = insert into trie; DFS exit = delete from trie; Euler tour integration</td></tr>
                        <tr><td>Persistent XOR trie</td><td>O(b) per insert/query</td><td>O(n·b·log n) shared nodes</td><td>Each insertion creates a new root (O(b) new nodes); old nodes shared; enables range queries</td></tr>
                        <tr><td>Aho-Corasick automaton</td><td>O(n + m + z)</td><td>O(m·26)</td><td>BFS-computed failure links; output links; linear multi-pattern matching</td></tr>
                        </tbody></table></div>'''

NEW += '''
                    <div class="sec-title">Mastery Problem Set</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>S.No</th><th>Layer</th><th>Stage</th><th>Source</th><th># / Name</th><th>Difficulty</th><th>P</th><th>Sub-Variant</th><th>New Idea Added</th><th>Key Insight</th></tr></thead>
                        <tbody>
                        <tr><td class="num-cell">1</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/implement-trie-prefix-tree/" target="_blank">208 – Implement Trie (Prefix Tree)</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Standard trie: insert / search / startsWith</td><td>THE baseline: array[26] children per node; isEnd flag; O(L) per operation; all other trie variants extend this skeleton</td><td class="insight">Establishes the trie node structure and the three core operations; every other trie problem builds on this exact template</td></tr>
                        <tr><td class="num-cell">2</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/replace-words/" target="_blank">648 – Replace Words</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Prefix replacement: stop at first isEnd</td><td>ONE change from S.No 1: stop traversal as soon as isEnd = true; return accumulated prefix as the replacement; short-circuit search</td><td class="insight">First real application: isEnd acts as a "shortest prefix sentinel"; if no word prefix found, return the original word unchanged</td></tr>
                        <tr><td class="num-cell">3</td><td><span class="l1">1</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/sum-of-prefix-scores-of-strings/" target="_blank">2416 – Sum of Prefix Scores of Strings</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Prefix count: passCount field at each node</td><td>ONE change: add `passCount` at each node (incremented during every insert); score of a string = sum of passCount along its path</td><td class="insight">passCount = number of strings sharing this prefix; first augmentation of the trie node beyond isEnd; O(n·L) total for all scores</td></tr>
                        <tr><td class="num-cell">4</td><td><span class="l1">1</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/map-sum-pairs/" target="_blank">677 – Map Sum Pairs</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Weighted prefix sum: value aggregation at each node</td><td>ONE change from S.No 3: replace integer count with weighted sum; on insert(key, val), add val to each node on the path; sum query = node.val at prefix end</td><td class="insight">The aggregated value at each node must be updated on RE-insert (delta = new_val − old_val); key is re-inserted with the difference to avoid double-counting</td></tr>
                        <tr><td class="num-cell">5</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/short-encoding-of-words/" target="_blank">820 – Short Encoding of Words</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Suffix trie: reverse-insert strings</td><td>ONE change: insert REVERSED strings; suffix of original = prefix of reversed; leaves = words not a suffix of any other word</td><td class="insight">Suffix problem → prefix problem by reversing; count leaf nodes; answer = Σ(leaf_word_length + 1); removes words that ARE suffixes of others</td></tr>
                        <tr><td class="num-cell">6</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/search-suggestions-system/" target="_blank">1268 – Search Suggestions System</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Trie + sorted DFS to collect top-K results</td><td>ONE change from S.No 2: after reaching the prefix node, DFS the subtree in lexicographic order (visit children a→z); collect first 3 complete words found</td><td class="insight">DFS in child-order a→z automatically gives lexicographic results; stop after 3 found; OR pre-sort words and store sorted lists at each trie node</td></tr>
                        <tr><td class="num-cell">7</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/design-add-and-search-words-data-structure/" target="_blank">211 – Design Add and Search Words</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Wildcard '.' search: DFS branching on all children</td><td>ONE change: when current character == '.', recursively search ALL non-null children; any path that reaches the end of the pattern returns true</td><td class="insight">Wildcard converts O(L) search to O(26^d) worst case; in practice bounded by word length; the branching DFS is identical to standard search except at '.' nodes</td></tr>
                        <tr><td class="num-cell">8</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/implement-trie-ii-prefix-tree/" target="_blank">1804 – Implement Trie II ✅</a></td><td><span class="diff-m">Medium</span></td><td>✅</td><td class="variant-cell">Trie delete with separate endCount + prefixCount</td><td>ONE change: track endCount (exact match count) AND prefixCount (pass-through count) separately; delete decrements both; erase node when prefixCount reaches 0</td><td class="insight">Two counters needed because endCount only marks word ends while prefixCount tracks any string passing through; node is safely removed only when both are 0</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#fff3cd,#ffe69c);padding:.55rem .8rem;font-weight:600;text-align:center">⚡ CLIFF WARNING — Standard Trie → Binary XOR Trie: The binary trie replaces the 26-character alphabet with a 2-way bit split (0/1), shifting the problem domain from strings to integers. The mental model changes completely: we no longer spell words — we navigate the binary representation of numbers. Prepare by: (1) clearly understanding bitwise operations; (2) confirming the greedy-opposite-bit proof before coding; (3) always working from MSB (bit 31 or 30) down to bit 0.</td></tr>
                        <tr><td class="num-cell">9</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximum-xor-of-two-numbers-in-an-array/" target="_blank">421 – Maximum XOR of Two Numbers in an Array</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Binary XOR trie: greedy opposite-bit walk for max XOR</td><td>NEW data model: insert integers bit-by-bit from MSB (bit 31) to LSB; for each query x, greedily choose the child whose bit DIFFERS from x's bit (maximises that XOR bit)</td><td class="insight">First binary trie: the greedy opposite-bit strategy is proved optimal because 2^b &gt; sum of all lower bits; insert all numbers first, then query each number against the existing trie</td></tr>
                        <tr><td class="num-cell">10</td><td><span class="l2">2</span></td><td>3</td><td>Codeforces</td><td class="prob-name"><a class="lc-link" href="https://codeforces.com/problemset/problem/706/D" target="_blank">CF 706D – Vasiliy's Multiset</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Binary XOR trie with dynamic insert/delete/max-query</td><td>ONE change from S.No 9: support delete(x) by decrementing count at each node; during query, skip children with count = 0; supports a dynamic multiset</td><td class="insight">Count field at each node = number of integers whose path passes through it; decrement on delete; count-0 child = unavailable path; enables a live dynamic set with O(b) per operation</td></tr>
                        <tr><td class="num-cell">11</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/count-pairs-with-xor-in-a-range/" target="_blank">1803 – Count Pairs With XOR in a Range</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Binary XOR trie: count pairs with XOR in [lo, hi]</td><td>ONE change: instead of maximising XOR, COUNT pairs with XOR in [lo, hi]; compute count(XOR &lt; hi+1) − count(XOR &lt; lo); at each bit level, accumulate subtree counts when a whole subtree is included</td><td class="insight">Hard: the "count XOR &lt; limit" traversal requires tracking accumulated result at each bit level and adding subtree counts when the prefix forces remaining XOR bits to be less; WHY hard: the bit-by-bit prefix counting has 4 cases (bit of limit, bit of query) that must all be handled correctly</td></tr>
                        <tr><td class="num-cell">12</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximum-strong-pair-xor-ii/" target="_blank">2935 – Maximum Strong Pair XOR II</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Binary XOR trie + sliding window on sorted array</td><td>ONE change from S.No 10: the constraint |x−y| ≤ min(x,y) ↔ x ≤ 2y defines a valid window on sorted array; two-pointer left/right; delete trie entry when left pointer advances past valid range</td><td class="insight">Hard: recognising that the algebraic constraint defines a sorted sliding window is the key insight; then trie-with-delete from S.No 10 handles the rest; WHY hard: the algebraic simplification x ≤ 2y is non-obvious from |x−y| ≤ min(x,y)</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#fff3cd,#ffe69c);padding:.55rem .8rem;font-weight:600;text-align:center">⚡ CLIFF WARNING — Binary Trie → Trie + Algorithm Combination: The next problems combine the trie with a second algorithm (DP or DFS). The trie structure is unchanged but now DRIVES another algorithm rather than being the sole component. The key shift: the trie no longer returns the final answer directly — it provides O(L) prefix membership checks that enable an O(n) or O(n·L) outer algorithm to avoid O(n²) scanning.</td></tr>
                        <tr><td class="num-cell">13</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/extra-characters-in-a-string/" target="_blank">2707 – Extra Characters in a String</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Trie + DP: trie drives valid DP transitions</td><td>NEW combination: dp[i] = min extra chars in s[0..i−1]; for each position i, walk backward through trie matching s[j..i−1] for all j; when trie.isEnd = true at depth (i−j), dp[i] = min(dp[i], dp[j])</td><td class="insight">First trie+DP combination: the trie replaces an O(n) set lookup at each DP position with an O(1) prefix check during backward trie traversal; total O(n·L) where L = max word length</td></tr>
                        <tr><td class="num-cell">14</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/word-search-ii/" target="_blank">212 – Word Search II</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Trie + grid DFS with trie-guided pruning</td><td>ONE change: DFS on 2D grid with current trie node advanced at each step; when trie.isEnd = true, record the word; PRUNE: set trie.isEnd = false and delete the branch if no more words exist below, preventing re-visiting</td><td class="insight">Hard: the critical optimisation is deleting found words from the trie to prevent re-traversal; without pruning, the grid DFS revisits the same paths for already-found words causing TLE; WHY hard: candidates miss the pruning step</td></tr>
                        <tr><td class="num-cell">15</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/concatenated-words/" target="_blank">472 – Concatenated Words</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Trie-driven DP per word with self-exclusion</td><td>ONE change from S.No 13: run word-break DP for EACH word w using the trie of all OTHER words (exclude w from the trie during its own check); a word qualifies if it can be split into ≥2 existing words</td><td class="insight">Hard: the word being checked must be EXCLUDED from the trie during its own DP check; trivial self-match is the failure mode; WHY hard: building the trie once without exclusion and then marking exclusion during DP is the correct approach; rebuilding per word is TLE</td></tr>
                        <tr><td class="num-cell">16</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximum-xor-with-an-element-from-array/" target="_blank">1707 – Maximum XOR With an Element From Array</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Offline binary XOR trie: sort queries + nums by constraint</td><td>NEW offline technique: sort queries by xi limit AND sort nums by value; process queries in increasing xi order, inserting nums ≤ xi into the binary trie before answering each query</td><td class="insight">Hard: online approach rebuilds trie per query = O(n·q·b); offline sort reduces to O((n+q)·b); WHY hard: recognising that the "num ≤ xi" constraint is a monotone filter that enables offline processing via sorting</td></tr>
                        <tr><td class="num-cell">17</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/stream-of-characters/" target="_blank">1032 – Stream of Characters</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Reverse trie + active cursor set for suffix matching</td><td>NEW technique: reverse all words and insert into trie; maintain a set of "active trie cursors" that advance with each character; on new character c, advance all cursors to child[c]; add root as a fresh cursor each time; cursor reaching isEnd = pattern found</td><td class="insight">Hard: inserting words forward and scanning backward is O(n·m); the reverse-insert trick converts suffix matching to prefix matching, enabling O(1) advancement per cursor; WHY hard: the active cursor set grows O(m) per step in worst case — managing its size is non-trivial</td></tr>
                        <tr><td class="num-cell">18</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/palindrome-pairs/" target="_blank">336 – Palindrome Pairs</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Trie for palindrome pairs: reversed prefix + palindrome suffix check</td><td>ONE change: insert all REVERSED words into trie; for each word w, walk the trie matching chars of w; if we hit a word-end node while w still has chars remaining, check if remaining suffix of w is a palindrome (and vice versa for the symmetric case)</td><td class="insight">Hard: two distinct cases must both be handled: (1) reversed prefix of w matches a stored word and the remaining suffix is a palindrome; (2) the full reverse of w matches a prefix of a stored word whose remaining suffix is a palindrome; WHY hard: the symmetric case and its palindrome check require precomputation of all palindrome substrings</td></tr>
                        <tr><td class="num-cell">19</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/prefix-and-suffix-search/" target="_blank">745 – Prefix and Suffix Search ✅</a></td><td><span class="diff-h">Hard</span></td><td>✅</td><td class="variant-cell">Combined prefix+suffix trie via "#" encoding</td><td>ONE change: for word w at index i, insert ALL strings of form (suffix+"#"+w) into a single trie; query (prefix, suffix) maps to searching (suffix+"#"+prefix) in the trie; map each end node to the word's index</td><td class="insight">Hard: the dual-constraint (prefix AND suffix) is encoded into a single trie by enumerating all suffix+"#"+word combinations; the "#" separator prevents false matches; WHY hard: the key insight — encoding two constraints into one trie query — is non-obvious</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#fff3cd,#ffe69c);padding:.55rem .8rem;font-weight:600;text-align:center">⚡ CLIFF WARNING — Stage 4 → Stage 5 (Advanced Structures): The next problems require persistent tries or dynamic tries on tree DFS. These involve ~150+ lines of correct implementation with shared node management, version pointers, or careful DFS enter/exit ordering. Prepare by: (1) implementing a standard persistent segment tree first; (2) understanding how binary trie insert creates O(b) new nodes per version while sharing unchanged nodes.</td></tr>
                        <tr><td class="num-cell">20</td><td><span class="l4">4</span></td><td>5</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximum-genetic-difference-query/" target="_blank">1938 – Maximum Genetic Difference Query</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Binary trie on tree DFS (offline DFS + insert/remove)</td><td>NEW technique: DFS on tree; on entering node v, insert v's value into binary trie; answer all queries at v (max XOR with any ancestor = binary trie query); on exiting v, delete v's value from binary trie</td><td class="insight">Hard: the binary trie is a dynamic data structure modified during tree DFS — it represents the current root-to-v path at each DFS step; WHY hard: offline query grouping per node + DFS enter/exit insert/delete + binary trie must all interoperate correctly</td></tr>
                        <tr><td class="num-cell">21</td><td><span class="l4">4</span></td><td>5</td><td>🔧 CUSTOM</td><td class="prob-name">Persistent XOR Trie: k-th smallest XOR in range</td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Persistent binary trie for range XOR queries</td><td>NEW structure: build persistent trie on prefix XOR array — each version = trie after inserting prefix[0..v]; version v is created by inserting prefix[v] into version v−1, sharing all unchanged nodes; range [l,r] query uses two versions (v=r and v=l−1) to find the k-th smallest XOR</td><td class="insight">[See custom problem statement below] Stage 5: persistent trie = persistent segment tree idea applied to binary trie; O(b) new nodes per insertion; range query traverses two trie versions simultaneously; k-th smallest requires count fields at each node</td></tr>
                        <tr><td class="num-cell">22</td><td><span class="l4">4</span></td><td>4</td><td>🔧 CUSTOM</td><td class="prob-name">Aho-Corasick Multi-Pattern Stream Counter</td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Aho-Corasick: failure links for optimal multi-pattern matching</td><td>NEW technique: after inserting all patterns into trie, compute failure links via BFS: fail[root] = root; fail[child via char c] = transition(fail[parent], c); during text processing, always follow fail link on mismatch; output links report all patterns ending at each position</td><td class="insight">[See custom problem statement below] Stage 4: failure links allow O(n + m + z) matching regardless of pattern overlap; the BFS construction is simple but the correctness proof (amortised depth argument) requires careful understanding; WHY hard: candidates who skip output links miss patterns embedded in longer patterns</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#ffe6e6,#ffd0d0);padding:.55rem .8rem;font-weight:600;text-align:center">⚠️ TRAP ZONE — Problems that LOOK like trie problems but a different technique is strictly better.</td></tr>
                        <tr><td class="num-cell">23</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>LeetCode</td><td class="prob-name trap-name"><a class="lc-link" href="https://leetcode.com/problems/word-break/" target="_blank">139 – Word Break ⚠️</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">⚠️ TRAP — DP with HashSet is simpler than Trie+DP here</td><td>Trie+DP technically works but O(n²) DP with a Python set/Java HashSet achieves same complexity with lower constant and far less code; trie adds complexity without benefit</td><td class="insight">NOT a trie-required problem: wordDict membership check in O(avg_L) with a HashSet is effectively O(1); the DP structure doesn't benefit from prefix sharing because we check EXACT matches, not prefixes; use trie only when you need prefix enumeration</td></tr>
                        <tr><td class="num-cell">24</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>LeetCode</td><td class="prob-name trap-name"><a class="lc-link" href="https://leetcode.com/problems/word-search/" target="_blank">79 – Word Search ⚠️</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">⚠️ TRAP — single pattern search; DFS+backtrack only</td><td>Only ONE word is searched; trie provides no benefit with a single pattern; pure DFS+backtracking on the grid is both correct and optimal</td><td class="insight">NOT a trie problem: trie is valuable for Word Search II (LC 212) because it unifies MULTIPLE patterns and enables pruning; for a single word, DFS+backtrack is the correct approach — adding a trie is over-engineering</td></tr>
                        <tr><td class="num-cell">25</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>🔧 CUSTOM</td><td class="prob-name trap-name">Count Pairs with Longest Common Prefix ≥ k ⚠️</td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">⚠️ TRAP — sort + linear scan beats trie construction</td><td>Sort all strings lexicographically; adjacent pairs in sorted order share the longest common prefixes; linear scan on sorted array in O(n log n × L) vs trie construction O(n·L); when only a COUNT is needed (no enumeration), sorting is simpler</td><td class="insight">NOT always a trie problem: when the answer is a count (not an enumeration), lexicographic sorting + two-pointer on adjacent pairs solves the problem without trie overhead; trie is needed when prefix queries are ONLINE or require subtree aggregation</td></tr>
                        </tbody></table></div>'''

# ── CUSTOM PROBLEM STATEMENTS ─────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Custom Problem Statements</div>
                    <div class="info-box">
                        <strong>🔧 CUSTOM — S.No 21: Persistent XOR Trie (k-th smallest XOR in range)</strong><br><br>
                        <strong>Problem:</strong> Given an array A of n non-negative integers (A[i] &lt; 2^30), answer q queries. Each query (l, r, k) asks: among all values A[l] XOR A[l+1], A[l] XOR A[l+2], …, A[l] XOR A[r] (all XOR values of A[l] with elements A[l+1..r]), what is the k-th smallest?<br><br>
                        <strong>Input:</strong> n ≤ 10⁵, q ≤ 10⁵, A[i] &lt; 2^30. <strong>Output:</strong> k-th smallest XOR for each query, or −1 if fewer than k values exist.<br>
                        <strong>Intended solution:</strong> Build a persistent binary trie on the prefix XOR array P[0..n]: P[0]=0, P[i]=A[0] XOR...XOR A[i−1]. Version i = trie after inserting P[0..i]; each version shares all unchanged nodes with the previous version (O(b) new nodes per insert). For query (l, r, k): XOR of A[l..j] = P[j+1] XOR P[l]. Find k-th smallest among {P[l+1] XOR P[l], ..., P[r+1] XOR P[l]} by traversing versions r+1 and l simultaneously; at each bit, count going into the 0-child determines which branch to take. <strong>Time:</strong> O((n+q)·b) where b=30.
                    </div>
                    <div class="info-box" style="margin-top:.6rem">
                        <strong>🔧 CUSTOM — S.No 22: Aho-Corasick Multi-Pattern Stream Counter</strong><br><br>
                        <strong>Problem:</strong> Given k pattern strings (total length m ≤ 10⁵) and a text string T of length n ≤ 10⁶, output for each position i in T the total count of pattern occurrences (across all patterns, including overlaps) that END at position i.<br><br>
                        <strong>Input:</strong> k patterns with total length m ≤ 10⁵. Text length n ≤ 10⁶. <strong>Output:</strong> n integers (count at each position).<br>
                        <strong>Intended solution:</strong> (1) Insert all patterns into a standard trie. (2) BFS to compute failure links: fail[root] = root; for each node u with char-c child v: fail[v] = goto(fail[u], c) where goto follows the automaton transition (not raw trie child). (3) Compute output[v] = endCount[v] + output[fail[v]] for each node. (4) Process T character by character using the goto function; at each state, ans[i] += output[state]. <strong>Time:</strong> O(m·26 + n + z) where z = total matches.
                    </div>'''

# ── PATTERN RECOGNITION TRIGGERS ─────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Pattern Recognition Triggers</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>Linguistic Triggers:</strong><br>
                        • "find all words with prefix X" / "autocomplete" / "suggest words starting with" → Stage 1–2 standard trie; insert all words; traverse to prefix node; DFS subtree; O(L + results)<br>
                        • "replace each word with its shortest root" / "find the shortest prefix that is a word" → Stage 1 trie; stop at first isEnd; O(L) per word<br>
                        • "maximise / minimise the XOR of X with any element in the array" → Stage 3 binary XOR trie; greedy opposite-bit; O(b) per query<br>
                        • "count pairs (i,j) with XOR in range [lo, hi]" → Stage 3 binary XOR trie with subtree counts; count(XOR &lt; hi+1) − count(XOR &lt; lo); O(n·b)<br>
                        • "given a stream of characters, report when any of the patterns ends" → Stage 4 Aho-Corasick (or reverse trie + active cursors); O(n + m + z)<br><br>
                        <strong>Structural Triggers:</strong><br>
                        • Input is a list of strings AND queries ask about prefixes, suffixes, or both → trie (possibly with suffix+"#"+word encoding for dual constraint); stage depends on combination complexity<br>
                        • Input is a list of integers AND queries ask to maximise/minimise XOR with a constraint → binary XOR trie; if constraint is monotone (num ≤ xi), use offline sorting (Stage 4)<br>
                        • Input is a tree of integers AND queries ask max XOR from node to any ancestor → Stage 5 binary trie on DFS (insert on enter, delete on exit); queries answered at each node<br><br>
                        <strong>Constraint Triggers:</strong><br>
                        • n ≤ 10⁵, string lengths L ≤ 20, online queries → standard trie; O(n·L) build + O(L) per query<br>
                        • n ≤ 10⁵, integers up to 10⁹ (≈ 30 bits), q ≤ 10⁵ queries with constraint "num ≤ xi" → offline binary XOR trie; O((n+q)·30)<br><br>
                        <strong>Anti-Triggers (do NOT apply trie):</strong><br>
                        • "find the longest common prefix of the ENTIRE array" → NOT trie → sort the array and compare first and last strings character by character; O(n·L) sorting beats trie with lower constant and no extra space<br>
                        • "count pairs with XOR equal to exactly X" → NOT trie → HashMap; for each element a, check if a XOR X exists; O(n) vs O(n·b) trie<br>
                        • "word break with a fixed dictionary, single query" → NOT trie → DP with HashSet; trie adds O(26·k·L) space for no runtime benefit when the dictionary does not change between queries
                    </div>'''

# ── DECISION FRAMEWORK ────────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Decision Framework</div>
                    <div class="info-box">
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code>Q1: Does the problem involve STRINGS (not integers)?
  → YES: Continue to Q2.
  → NO:  Does the problem involve XOR on integers?
         → YES: Go to Q5 (binary XOR trie branch).
         → NO:  This is NOT a trie problem.

Q2: Does the query ask about PREFIXES of the strings?
  → YES: Standard trie. Stage 1.
         Build: insert all strings (array[26] children + isEnd).
         Query: traverse to prefix node in O(L).
  → NO:  Does the query ask about SUFFIXES?
         → YES: Reverse all strings before inserting.
                Suffix query = prefix query on reversed strings. Stage 2.
         → NO:  Continue to Q3.

Q3: Is there a second dimension to the query
    (count, weighted sum, top-K, delete)?
  → YES: Augment trie node with counter / value / list. Stage 2.
         Delete: add prefixCount + endCount; decrement on delete.
         Top-K: DFS subtree in lex order; collect first K.
  → NO:  Does the query involve WILDCARDS ('.' = any char)?
         → YES: DFS branch at '.' nodes. Stage 2. O(26^d) worst.
         → NO:  Go to Q4.

Q4: Is the trie COMBINED with a second algorithm?
  → Trie + DP (word segmentation / extra chars): Stage 3.
  → Trie + grid DFS with pruning (multi-word search): Stage 3–4.
  → Trie + palindrome suffix check: Stage 4.
  → Trie + combined prefix/suffix "#" encoding: Stage 4.
  → Reverse trie + active cursors (stream): Stage 4.
  → Aho-Corasick failure links (stream, many patterns): Stage 4.

Q5 — Binary XOR Trie:
  Q5a: Static set, max/min XOR query?
       → Insert all; greedy opposite-bit walk. Stage 3. O(b).
  Q5b: Dynamic set (insert + delete)?
       → Add count field; skip count-0 children. Stage 3.
  Q5c: Count pairs with XOR in [lo, hi]?
       → Add subtree-size field. count(&lt; hi+1) − count(&lt; lo). Stage 3.
  Q5d: Constraint "num ≤ xi" per query?
       → Offline sort. Stage 4. O((n+q)·b).
  Q5e: Sliding window constraint (both elements in valid range)?
       → Sort + two-pointer + delete. Stage 3–4.
  Q5f: Queries on tree path (max XOR with ancestor)?
       → DFS + insert/delete on enter/exit. Stage 5. O(n·b).
  Q5g: Range [l, r] XOR queries (arbitrary ranges)?
       → Persistent binary trie on prefix XOR. Stage 5. O(b)/query.

──────────────────────────────────────────────────────────
Stage identification:
  Q2 simple prefix lookup     → Stage 1. O(L).
  Q3 augmented node           → Stage 2. O(L).
  Q5a/b binary XOR            → Stage 3. O(b).
  Q5c XOR range count         → Stage 3. O(n·b).
  Q4 combination / Q5d offline→ Stage 4. O((n+q)·b) or O(n·L).
  Q5f tree DFS / Q5g persist  → Stage 5. O(n·b) or O(b·log n).
──────────────────────────────────────────────────────────</code></pre>
                    </div>'''

# ── WHEN THIS TECHNIQUE BREAKS ────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">When This Technique BREAKS</div>
                    <div class="warn-box"><strong>[Stage 1] Using a trie when a HashSet achieves identical complexity with less code:</strong> For single-keyword existence queries (not prefix queries), a HashSet lookup is O(avg_L) amortised — the same as a trie traversal, but with lower constant and zero implementation overhead. Fix: use trie only when you need prefix enumeration, prefix counting, or prefix-shortest match. If you only need "does this exact word exist?", use a HashSet.</div>
                    <div class="warn-box"><strong>[Stage 2] Wildcard '.' in long words with deep tries causes TLE:</strong> A single '.' at the start of a 20-character pattern causes 26 recursive DFS calls, each potentially branching again. With multiple wildcards the cost is O(26^d). Fix: for large alphabets and deep patterns, use a regex engine or a bitset-based NFA simulation instead of trie DFS. Trie wildcard matching is only practical when d is small (≤ 8).</div>
                    <div class="warn-box"><strong>[Stage 3] Binary trie XOR maximum fails when the integer range is very large and sparse:</strong> A 32-bit binary trie has depth 32 and up to 2^32 leaf nodes, but with n elements only O(n·32) nodes are created. This is fine. However, if integers can be 64-bit (10^18), the depth doubles to 60, doubling all complexities. Fix: always determine the bit-width b first; use b = ceil(log2(max_val + 1)) levels, not 32 by default.</div>
                    <div class="warn-box"><strong>[Stage 3] Trie + DP on long strings with large dictionary causes TLE:</strong> The O(n·L) trie+DP approach (n = string length, L = max word length) assumes L is small. If L ≈ n (long dictionary words), the complexity degrades to O(n²). Fix: bound L to the actual maximum word length in the dictionary; add an early-exit when the trie traversal reaches a depth exceeding max_word_length.</div>
                    <div class="warn-box"><strong>[Stage 4] Offline binary trie: processing queries out of sorted order:</strong> The offline technique relies on queries being processed in SORTED order by constraint (e.g., xi ascending). If queries are sorted but nums are not separately sorted, elements outside the constraint get inserted incorrectly. Fix: sort queries by xi AND sort nums independently; use a two-pointer or binary search on the nums array to find which nums to insert before each query.</div>
                    <div class="warn-box"><strong>[Stage 4] Aho-Corasick: using raw trie children instead of the goto function for failure link computation:</strong> When computing fail[child_of_u_via_c], the correct formula uses the GOTO function (which follows failure links when the child is absent), not the raw trie child pointer. Using raw children means failure links point to wrong nodes for characters not present in the pattern set. Fix: always build the goto function first (filling in "what state do we go to from state s on character c, following failure links if needed?"), then use goto during failure link BFS.</div>'''

# ── PROOF OF CORRECTNESS SKELETON ────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Proof of Correctness Skeleton</div>
                    <div class="core-box">
                        <strong>Stage 1 Proof — Standard Trie Insert/Search Correctness</strong><br>
                        <em>Claim:</em> After inserting n strings, search(w) returns true if and only if w was previously inserted.<br>
                        <em>Invariant maintained:</em> After inserting string s, for every prefix s[0..i] there exists exactly one node at depth i+1 whose root-to-node path spells s[0..i]; the node at depth |s| has isEnd = true.<br>
                        <em>Proof by induction on |s|:</em> Base: empty string inserts at root with isEnd = true. Step: inserting s of length L — at each depth i, if the child for s[i] does not exist, create it. By induction, after inserting s[0..i], a node at depth i+1 spelling s[0..i] exists. After the loop, depth-L node's isEnd is set. Search traverses the same path and returns isEnd at depth L. If any child is missing during search, the string was never inserted (no node created for that prefix). □<br><br>
                        <strong>Stage 3 Proof — Binary Trie Greedy XOR Maximisation</strong><br>
                        <em>Claim:</em> The greedy algorithm (choose opposite bit at each level, fall back to same bit if opposite unavailable) returns the maximum XOR achievable.<br>
                        <em>Exchange argument:</em> Suppose the greedy choice at bit b is to go to child 1 (opposite of query bit 0). Suppose an alternative path goes to child 0 at bit b (same as query bit 0), and then optimally chooses all 1-bits below. The alternative path achieves at most 0 · 2^b + (2^(b-1) + ... + 2^0) = 2^b − 1 at bit b and below. The greedy path achieves 1 · 2^b + anything ≥ 2^b. Since 2^b &gt; 2^b − 1, the greedy choice at bit b strictly dominates any alternative. By induction from MSB to LSB, the greedy path is globally optimal. □<br><br>
                        <strong>Stage 5 Proof — Persistent Trie Correctness (Range Query)</strong><br>
                        <em>Claim:</em> Version-v trie correctly represents the set {P[0], P[1], ..., P[v]}, and version-r XOR version-l can answer range [l+1, r] set queries.<br>
                        <em>Proof sketch:</em> By induction: version 0 = trie with only P[0]. Version v = version v−1 with P[v] inserted; only the O(b) nodes on P[v]'s insertion path are newly created; all other nodes are shared (pointed to) from version v−1. For range query [l, r]: version r contains {P[0..r]}, version l contains {P[0..l]}. The COUNT difference (count[r][child] − count[l][child]) at each node gives the count of elements from P[l+1..r] in that subtree. Navigating with this difference correctly restricts the query to the range. □
                    </div>'''

# ── IMPLEMENTATION PITFALLS ───────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Implementation Pitfalls (Code-Level)</div>
                    <div class="warn-box"><strong>Bug 1 — Not initializing children to None; accessing undefined index [Stage 1]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: using a list without initialization; index error on access
class TrieNode:
    def __init__(self):
        self.children = []   # BUG: empty list; children[2] throws IndexError
# FIX: fixed-size array initialized to None
class TrieNode:
    def __init__(self):
        self.children = [None] * 26   # FIX: all 26 slots pre-allocated</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 2 — search() and startsWith() using the same end condition [Stage 1]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: both search and startsWith return True when prefix path exists
def search(self, word):
    node = self._traverse(word)
    return node is not None   # BUG: returns True for prefix, not exact match
# FIX: search must check isEnd; startsWith only checks path existence
def search(self, word):
    node = self._traverse(word)
    return node is not None and node.isEnd   # FIX: isEnd required for exact match
def startsWith(self, prefix):
    return self._traverse(prefix) is not None   # FIX: prefix only needs path</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 3 — Wildcard '.' returning on first matching child instead of all [Stage 2]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: returns True on first child match; misses other branches
def _search(self, node, word, i):
    if word[i] == '.':
        for child in node.children:
            if child and self._search(child, word, i+1):
                return True   # CORRECT: but only if we also handle the base case properly
# Common BUG variant: break after first child even when it returns False
        for child in node.children:
            if child:
                return self._search(child, word, i+1)   # BUG: returns on FIRST non-null child
# FIX: try ALL non-null children; return True only if any succeeds</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 4 — Delete decrementing only endCount but not prefixCount [Stage 2]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: only endCount decremented; prefixCount stays inflated
def delete(self, word):
    node = self.root
    for ch in word:
        node = node.children[ord(ch) - ord('a')]
        # BUG: forgot node.prefixCount -= 1 here
    node.endCount -= 1   # BUG: node.prefixCount not decremented along path
# FIX: decrement prefixCount at EVERY node on the path
def delete(self, word):
    node = self.root
    for ch in word:
        idx = ord(ch) - ord('a')
        node = node.children[idx]
        node.prefixCount -= 1   # FIX: must decrement at every node
    node.endCount -= 1</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 5 — Binary trie: not padding integers to fixed bit-width; shorter numbers miss leading-zero branches [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: inserting number 3 (binary: 11) as only 2 bits when others use 32 bits
def insert(self, num):
    node = self.root
    while num:           # BUG: stops when num becomes 0; inserts fewer bits
        bit = num &amp; 1
        num >>= 1
        ...
# FIX: always iterate over exactly b bits from MSB to LSB
def insert(self, num, b=30):
    node = self.root
    for i in range(b, -1, -1):   # FIX: iterate all b+1 bits
        bit = (num >> i) &amp; 1
        ...</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 6 — Binary trie XOR: choosing the SAME bit as the query (minimising instead of maximising) [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: wants maximum XOR but chooses same bit as query bit
def query_max_xor(self, num, b=30):
    node = self.root
    result = 0
    for i in range(b, -1, -1):
        bit = (num >> i) &amp; 1
        want = bit      # BUG: takes SAME bit → minimises XOR, not maximises
        if node.children[want]:
            node = node.children[want]
            result |= (bit &lt;&lt; i)
# FIX: want the OPPOSITE bit to maximise XOR
        want = 1 - bit   # FIX: opposite bit maximises this XOR bit</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 7 — XOR range count: off-by-one in count(XOR &lt; limit) vs count(XOR ≤ limit) [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: count pairs with XOR in [lo, hi]
# Wrong: count(XOR &lt;= hi) - count(XOR &lt; lo)  -- off-by-one on hi
count = count_less(hi) - count_less(lo)   # BUG: misses XOR == hi case
# FIX: use count_less(hi + 1) to include hi
count = count_less(hi + 1) - count_less(lo)   # FIX: [lo, hi] inclusive</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 8 — Word Search II: not pruning found words from trie; O(4^L) re-traversal [Stage 3/4]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: found words are added to result but trie is not pruned
if node.word:
    result.append(node.word)
    # BUG: node.word not cleared; same word found multiple times
# FIX: clear the word from the trie node immediately after finding it
if node.word:
    result.append(node.word)
    node.word = None   # FIX: prevents re-finding; also prune parent branches
# FULL FIX: after DFS returns, set child pointer to None if subtree is now all-None
# (reduces future DFS branches into already-exhausted subtrees)</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 9 — Offline XOR trie: sorting queries but not sorting nums independently [Stage 4]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: queries sorted by xi but nums inserted in original order
queries.sort(key=lambda q: q[2])   # sort by xi limit
for qi, (xi, q_idx) in enumerate(queries):
    while j &lt; len(nums) and nums[j] &lt;= xi:  # BUG: nums not sorted; skips valid nums
        trie.insert(nums[j]); j += 1
# FIX: sort BOTH nums array AND queries array independently
nums.sort()   # FIX: sort nums by value
queries.sort(key=lambda q: q[2])   # sort queries by xi limit
# Now the two-pointer on sorted nums correctly inserts all nums &lt;= xi</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 10 — Aho-Corasick: forgetting to add root as a fresh active state on each character; missing patterns that start at current position [Stage 4]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: only advancing existing cursors; missing new starts at current character
state = root
for ch in text:
    state = goto[state][ord(ch) - ord('a')]   # BUG: single state; misses patterns
    result += output[state]
# FIX (cursor-set approach): always include root as a fresh start
active = set()
for ch in text:
    new_active = {goto[root][ord(ch)]}   # FIX: root always tries fresh match
    for s in active:
        next_s = goto[s][ord(ch)]
        if next_s is not None: new_active.add(next_s)
    active = new_active</code></pre>
                    </div>'''

# ── RED FLAGS / COMMON MISTAKES ───────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Red Flags / Common Mistakes</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>[Stage 1] Rebuilding the trie from scratch for every query instead of building once and querying many times:</strong> The entire value of a trie comes from amortising the O(n·L) build cost across multiple O(L) queries. If you rebuild per query, you lose all benefit. Correct model: build once; query many times. If the dictionary changes between queries, maintain the trie incrementally (insert/delete) rather than rebuilding.<br>
                        <strong>[Stage 2] Using a dict-based trie for performance-critical paths:</strong> Python dict-based tries (children = {}) have higher constant factors than array-based tries (children = [None]*26) for lowercase ASCII inputs. Under tight time limits with large inputs, the array-based approach is 2–3× faster. Correct model: use array[26] for lowercase ASCII; use dict only for large or variable alphabets (Unicode, arbitrary tokens).<br>
                        <strong>[Stage 3] Thinking that binary trie can only maximise XOR, not minimise:</strong> The same greedy structure works for minimum XOR — just choose the SAME bit as the query bit at each level (instead of opposite). The proof is symmetric. Correct model: max XOR = opposite bit; min XOR = same bit; both are O(b) greedy walks on the same trie structure.<br>
                        <strong>[Stage 4] For Word Search II, not recognising that found words must be pruned:</strong> Candidates correctly implement trie-guided DFS but forget to delete found words from the trie. Without pruning, the DFS re-explores already-found paths, causing TLE on test cases with many words sharing prefixes. Correct model: immediately after recording a found word, set node.word = None AND prune empty parent branches by returning a "leaf can be removed" signal up the DFS call stack.<br>
                        <strong>[Stage 4] Confusing "reverse trie + active cursors" with Aho-Corasick:</strong> The active-cursor approach works for Stream of Characters (small pattern set, online queries) but has O(m) cursors per step in worst case. Aho-Corasick processes each character in O(1) amortised regardless of pattern count. Correct model: use active cursors when pattern count is small (≤ 100); use Aho-Corasick when patterns are many and the total match count z is large.<br>
                        <strong>[Stage 5] Building a persistent trie with full node copying instead of path copying:</strong> Persistent trie creates O(b) NEW nodes per insertion (only the path from root to the modified leaf), sharing all other nodes. Copying the entire trie on each insertion is O(n·b) per insert — O(n²·b) total — and defeats the purpose. Correct model: on insert, walk from root to leaf; at each level, create a new node that COPIES the children pointers of the old node, then overrides only the one changed child pointer.
                    </div>'''

# ── INTERVIEWER FOLLOW-UP QUESTIONS ──────────────────────────────────────
NEW += '''
                    <div class="sec-title">Interviewer Follow-Up Questions</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>#</th><th>Stage</th><th>Question</th><th>Intended Answer Direction</th></tr></thead>
                        <tbody>
                        <tr><td>1</td><td>2</td><td>"Your trie uses an array[26] at each node. How would you handle Unicode strings or arbitrary token sets?"</td><td>Replace array[26] with a HashMap (dict in Python); key = character; value = child node; insert/search are still O(L) but with higher constant; for very large alphabets (e.g., Chinese characters), a compressed trie (Patricia trie) or a ternary search trie further reduces space</td></tr>
                        <tr><td>2</td><td>2</td><td>"Your search implementation doesn't handle deletions. How would you support them?"</td><td>Add prefixCount (incremented on insert, decremented on delete) and endCount (exact match count) to each node; after decrementing, if prefixCount = 0 the node can be safely removed; traverse from the leaf backward and null the parent's pointer to this node when prefixCount = 0</td></tr>
                        <tr><td>3</td><td>3</td><td>"Your binary XOR trie inserts all numbers first then queries. What if numbers are inserted and queried interleaved (online)?"</td><td>The binary trie with count field handles online inserts naturally: insert each number before its queries; the greedy max-XOR query works correctly on the current trie state at any point; no batch processing required — each insert is O(b), each query is O(b)</td></tr>
                        <tr><td>4</td><td>3</td><td>"Your max XOR solution is O(n·b). Can you solve it without a trie in O(n log n)?"</td><td>Sort the array; for each element x, binary search for the element closest to the bitwise complement of x; this is O(n log n) but only gives an approximation of max XOR; for EXACT max XOR, the trie is O(n·b) and is the standard optimal approach; there is no O(n log n) exact solution without a trie-like structure</td></tr>
                        <tr><td>5</td><td>4</td><td>"Your Word Search II solution prunes found words. What is the worst-case time complexity after pruning?"</td><td>After pruning, each cell of the grid is visited at most once per trie branch still active; in the worst case, all words share a common prefix of length L and the grid is m×n; pruned complexity: O(m·n·4·min(L, max_path_length)); in practice, pruning reduces runtime by 10–100× on dense tests</td></tr>
                        <tr><td>6</td><td>4</td><td>"How would you modify the offline XOR trie to handle queries that ask for the k-th largest XOR instead of the maximum?"</td><td>Add a subtree count field to each binary trie node; at each bit level during query, check the count of the "opposite bit" child; if count ≥ k, recurse into it (this subtree has ≥ k elements with higher XOR); else subtract count from k and recurse into the "same bit" child; O(b) per query</td></tr>
                        <tr><td>7</td><td>5</td><td>"Your Aho-Corasick solution is O(n + m + z). What if z is very large (many overlapping matches)? Can you count total matches in O(n + m)?"</td><td>Yes: instead of following output links per character (which is O(z) total), precompute output[v] = endCount[v] + output[fail[v]] once during BFS (O(m) precomputation); then each character costs O(1) to accumulate output[state]; total count = Σ output[state_i] for all characters; O(n + m) total regardless of z</td></tr>
                        <tr><td>8</td><td>5</td><td>"Can you support range prefix queries: given queries (l, r, prefix), count strings in positions l..r that start with prefix?"</td><td>Build a persistent trie: version i = trie after inserting strings[0..i]; for range [l, r], use versions r and l-1; at the prefix node, count[r] − count[l-1] gives the number of strings with that prefix in the range; O(|prefix|) per query after O(n·L) build; same idea as persistent segment tree applied to trie</td></tr>
                        <tr><td>9</td><td>Beyond</td><td>"How would you distribute a trie across multiple machines for a search engine autocomplete system serving 10⁹ queries/day?"</td><td>Partition the trie by first character or first two characters (26 or 676 shards); each shard owns a subtree; queries are routed to the correct shard based on the first character(s) of the prefix; within each shard, use a compressed trie (Patricia trie) to reduce node count; replicate hot shards (e.g., 'a'-prefix) for load balancing; cache the top-K results at each popular prefix node</td></tr>
                        <tr><td>10</td><td>Beyond</td><td>"You have a stream of 10⁹ strings and need to find the top-10 most frequent prefixes at any point. How do you do this without storing all strings?"</td><td>Use a Count-Min Sketch for approximate prefix frequency counting; maintain a small trie of the top-K prefixes by frequency; on each new string, increment prefix counters in the sketch; periodically scan to update the top-K heap; exact solution: space-efficient trie with frequency pruning (prune nodes whose frequency drops below threshold); approximate with bounded error using sketching data structures</td></tr>
                        </tbody></table></div>'''

# ── MASTERY PLAN ──────────────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">3-Phase Mastery Plan</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>Phase 1 — Solve (strictly by Stage):</strong><br>
                        <em>Stage 1 — Establish the trie skeleton:</em><br>
                        S.No 1 (Implement Trie) → S.No 2 (Replace Words) → S.No 3 (Prefix Scores) → S.No 4 (Map Sum)<br>
                        After these: write a trie from scratch in under 5 minutes; recite "array[26], isEnd, passCount" as the standard node fields<br><br>
                        <em>Stage 2 — Add augmentation and transformations:</em><br>
                        S.No 5 (Short Encoding, reverse insert) → S.No 6 (Search Suggestions, DFS subtree) → S.No 7 (Add and Search, wildcard) → S.No 8 (Implement Trie II, delete)<br>
                        Drill: for S.No 5–8, state what CHANGES from the baseline trie before writing any code<br><br>
                        <em>Stage 3 — Enter binary XOR and combination territory:</em><br>
                        S.No 9 (Max XOR, binary trie baseline) → S.No 10 (CF 706D, dynamic) → S.No 11 (XOR range count) → S.No 12 (sliding window + delete) → S.No 13 (Trie+DP) → S.No 14 (Word Search II + pruning)<br>
                        Critical drill: implement binary trie from scratch twice (max XOR then dynamic with delete); verify greedy-opposite-bit proof on a 4-element example<br><br>
                        <em>Stage 4 — Advanced combinations and offline techniques:</em><br>
                        S.No 15 (Concatenated Words, self-exclusion) → S.No 16 (LC 1707, offline sort) → S.No 17 (Stream + reverse trie) → S.No 18 (Palindrome Pairs) → S.No 19 (Prefix+Suffix, "#" encoding) → S.No 22 (Aho-Corasick)<br>
                        For S.No 22: implement Aho-Corasick failure links from scratch; trace a 5-pattern, 20-character example manually<br><br>
                        <em>Stage 5 — DFS trie and persistence:</em><br>
                        S.No 20 (LC 1938, binary trie on tree DFS) → S.No 21 (Persistent XOR Trie)<br>
                        For S.No 21: implement persistent segment tree first as a warm-up; then adapt to binary trie<br><br>
                        <strong>Phase 2 — Drill (speed and pattern recognition):</strong><br>
                        • Standard trie: write insert + search + startsWith from scratch in under 4 minutes<br>
                        • Binary XOR trie: write insert + max_xor from scratch in under 8 minutes; label "b=30, iterate MSB to LSB, want = 1-bit"<br>
                        • Stage recognition: given problem title only, state Stage (1–5) and key technique in 10 seconds each<br>
                        • Trie+DP drill: solve LC 472 (Concatenated Words) and LC 2707 (Extra Characters) back-to-back; identify the ONE difference<br>
                        • Offline XOR trie drill: solve LC 1707 in under 20 minutes with explicit "sort nums, sort queries, two-pointer" structure<br><br>
                        <strong>Phase 3 — Validate (unseen problem sources):</strong><br>
                        • Stage 1–2: CSES Problem Set — String Algorithms section (all problems from "Word Frequencies" through "Finding Borders")<br>
                        • Stage 3: Codeforces problems tagged "trie" with difficulty 1600–2000 from rounds not listed in this guide<br>
                        • Stage 4: AtCoder ABC/ARC problems combining tries with other data structures (filter: ABC D–F level, "trie" tag)<br>
                        • Stage 5: Codeforces Div. 1 C/D problems tagged "data structures" + "strings" from recent years; any problem requiring persistent trie
                    </div>'''

# ── GRADUATION TEST ───────────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Graduation Test</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>Problem 1 — LC 1938: Maximum Genetic Difference Query</strong><br>
                        <strong>Primary stage tested:</strong> Stage 5 (binary trie on tree DFS with offline enter/exit)<br>
                        <strong>Stage combination required:</strong> Stage 3 (binary XOR trie with delete) + Stage 4 (offline query grouping per tree node) + Stage 5 (DFS insert/remove)<br>
                        <strong>Why solving this cold certifies mastery:</strong> This problem requires simultaneously: (a) recognising that max XOR with an ancestor = binary trie traversal; (b) knowing that "ancestor" means "any node on the DFS stack" = insert on DFS-enter + delete on DFS-exit; (c) offline grouping of queries by tree node. Solving it cold demonstrates Stage 3 (binary trie), Stage 4 (offline reduction), and Stage 5 (dynamic trie during DFS) are all internalized and can be composed on the fly.<br><br>
                        <strong>Problem 2 — LC 2935: Maximum Strong Pair XOR II</strong><br>
                        <strong>Primary stage tested:</strong> Stage 4 (input transformation: algebraic constraint → sliding window)<br>
                        <strong>Stage combination required:</strong> Stage 4 (recognise |x−y| ≤ min(x,y) ↔ x ≤ 2y on sorted array = sliding window) + Stage 3 (binary trie with delete for max XOR in dynamic set)<br>
                        <strong>Why solving this cold certifies mastery:</strong> The hard part is NOT the trie — it is recognising the algebraic simplification that converts the constraint into a sorted sliding window. Solving it cold proves Stage 4 "input transformation" mastery: the candidate can identify a non-obvious reduction that transforms a constraint-optimisation problem into a standard dynamic-trie problem they've seen before.<br><br>
                        <strong>Problem 3 — Custom Persistent XOR Trie (S.No 21)</strong><br>
                        <strong>Primary stage tested:</strong> Stage 5 (persistent binary trie)<br>
                        <strong>Stage combination required:</strong> Stage 3 (binary XOR trie with count fields for k-th smallest) + Stage 5 (persistent versioning for range restriction)<br>
                        <strong>Why solving this cold certifies mastery:</strong> Persistent tries require internalising the "share unchanged nodes, copy only the O(b)-node path" pattern. Solving the k-th smallest XOR in a range cold proves the candidate can compose: (a) standard binary trie insertion; (b) persistent versioning (same idea as persistent segment tree); (c) two-version simultaneous traversal for range restriction; (d) k-th smallest navigation using count fields. No single stage is individually hard — the challenge is composing all four correctly in one implementation.
                    </div>
                </div>
            </div>'''

# ── REPLACEMENT ───────────────────────────────────────────────────────────
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

start = content.find('<div class="topic-card" id="tp18">')
end_marker = '<div class="topic-card" id="tp19">'
end = content.find(end_marker, start)

print('start:', start, 'end:', end, 'old_len:', end - start)

new_content = content[:start] + NEW + '\n            ' + content[end:]
print('new_file_len:', len(new_content))

with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print('Done.')