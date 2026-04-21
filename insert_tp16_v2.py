path = r"E:\PracticeProjec\dsalgofrog\src\pages\index.astro"

NEW = ''

# ── CARD OPEN + HEADER ────────────────────────────────────────────────────
NEW += '''<div class="topic-card" id="tp16">
                <div class="topic-header">
                    <div class="topic-num">11</div>
                    <div style="flex:1">
                        <div style="display:flex;align-items:center;gap:.5rem;flex-wrap:wrap">
                            <div class="topic-title">Monotonic Stack / Queue</div>
                            <span class="tier-badge tier-T1">Core Pattern</span>
                            <span class="topic-type">Next/Prev Greater · Histogram Span · Sliding Deque · Hidden Dominance · DP Optimisation</span>
                        </div>
                        <div class="topic-meta">33 problems · 5 stages · NGE/PGE/NSE/PSE, circular, histogram, contribution counting, sliding-window deque, retroactive stack, deque-optimised DP</div>
                    </div>
                </div>
                <div class="topic-body">'''

# ── WHY THIS TOPIC MATTERS ────────────────────────────────────────────────
NEW += '''
                    <div class="info-box"><strong>Why This Topic Matters:</strong> The Monotonic Stack/Queue pattern solves a precisely-defined class of problems: for each element in a sequence, efficiently find the nearest element that is strictly greater, strictly smaller, or satisfies some dominance relationship — either to the left, to the right, or within a sliding window. The core invariant is: a monotonic stack maintains a sequence of "still-relevant" candidates by evicting any element that has been dominated; every eviction event itself IS the answer to a sub-problem. This pattern is ubiquitous because it converts an apparent O(n²) "for each element, scan left/right" into O(n) by amortising: each element enters and leaves the stack exactly once. In top-tier interviews it is the canonical example of amortised analysis; in competitive programming it is the engine behind histogram-area, largest rectangle problems, and the critical inner loop of O(n log n) DP optimisations. The monotonic deque extends this to sliding-window extrema and is the O(n) replacement for O(n log n) lazy-deletion heaps in window-maximum problems.</div>'''

# ── MENTAL MODEL ──────────────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">The Mental Model</div>
                    <div class="info-box"><strong>A monotonic stack is a "last surviving champion" structure.</strong> Imagine a sequence of soldiers in a line. Each new soldier challenges everyone behind them: any soldier shorter (or taller) than the newcomer is immediately eliminated. The eliminated soldiers were only ever relevant up to the point they were beaten — and the moment they are beaten, THAT is the answer to their sub-problem (the new soldier is their "next greater element"). The stack at any moment holds only the soldiers who have not yet been beaten — the ones still waiting for their challenger.<br><br>
                        <strong>The universal monotonic stack invariant:</strong> At every step i, the stack contains exactly those indices j &lt; i (in increasing order) for which no element between j and i has beaten them under the dominance criterion. The stack is monotone because any element that breaks monotonicity would have been evicted by an earlier element that already dominates it.<br><br>
                        <strong>How this mental model scales through the 5 stages:</strong><br>
                        • <strong>Stage 1 — Simplest form:</strong> "Next Greater Element" in a linear array. Stack holds indices. When element i beats stack.top(), pop and record: ans[stack.top()] = i. O(n).<br>
                        • <strong>Stage 2 — What changes:</strong> The array is circular (process 2n), or we need PREVIOUS greater instead of next (scan right-to-left), or strict vs. non-strict comparison. The eviction rule is the same; only the scan direction or the comparison operator flips.<br>
                        • <strong>Stage 3 — What expands:</strong> The answer is not the element itself but a COMPUTED QUANTITY derived from the span (e.g., area = height × width in histogram). The stack stores extra state (index, not just value) to compute spans.<br>
                        • <strong>Stage 4 — What is hidden:</strong> The problem does not mention "next greater" or "stack." The key insight is that the answer structure — maximum rectangle, valid parentheses depth, minimum cost — implies a dominance relationship that triggers the stack. The reduction IS the hard part.<br>
                        • <strong>Stage 5 — What is optimised:</strong> The monotonic deque replaces a heap for sliding-window extrema (O(n) vs O(n log n)), or the monotonic stack is embedded inside a DP recurrence to collapse an O(n²) transition to O(n).
                    </div>'''

# ── CORE INVARIANT / PROOF SKETCH ────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Core Invariant / Proof Sketch</div>
                    <div class="core-box">
                        <strong>Invariant (Monotone Decreasing Stack for Next Greater Element):</strong> At all times, the stack S contains indices in increasing order of position, with values in DECREASING order (top = smallest). For every adjacent pair (S[i], S[i+1]) in the stack, there is no element between positions S[i] and S[i+1] with value ≥ a[S[i]].<br><br>
                        <em>Proof sketch (amortised correctness by induction on i):</em><br>
                        <em>Claim:</em> When element a[i] causes index j to be popped from the stack, a[i] is the FIRST element to the right of j that is ≥ a[j] (i.e., a[i] is the true "next greater element" of a[j]).<br>
                        <em>Proof:</em> Suppose some element a[k] with j &lt; k &lt; i satisfies a[k] ≥ a[j]. Then when processing k, j would have been popped at that point (since a[k] ≥ a[j] violates the stack's decreasing invariant). But we assumed j is still in the stack when i is processed — contradiction. Therefore no such k exists, and a[i] is indeed the first greater element to the right of j. ✓<br>
                        <em>O(n) amortised:</em> Each index enters the stack exactly once (on its own turn) and leaves at most once (when beaten). Total push + pop operations = 2n → O(n). □<br><br>
                        <strong>Invariant (Monotone Deque for Sliding Window Maximum):</strong> The deque D always holds indices in increasing order of position, with values in DECREASING order. The front of D = index of the maximum of the current window. Elements are evicted from the BACK when a new element dominates them (they can never be the future window maximum) and from the FRONT when they fall outside the window.<br><br>
                        <em>Proof sketch:</em> An element at the back of the deque can be evicted when a[new] ≥ a[back] because: the new element is both larger AND has a later expiry than the back element — so the back element will never be the future window maximum. The front is the maximum because all elements to its right in the deque are smaller (decreasing invariant), and all expired elements have been pruned. □
                    </div>'''

# ── SUB-VARIANTS ──────────────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Sub-Variants to Master</div>
                    <div class="info-box" style="line-height:1.75">
                        <strong>Group 1 — Next / Previous Greater or Smaller (Linear):</strong><br>
                        • <strong>Next Greater Element (NGE) on array</strong> — Stage 1 · O(n) · decreasing stack of indices · THE baseline; eviction event = answer; stack holds "waiting for challenger"<br>
                        • <strong>Previous Greater Element (PGE)</strong> — Stage 1 · O(n) · decreasing stack; scan left-to-right, answer on push not pop · ONE flip: answer recorded when element is pushed (its blocker = current stack top)<br>
                        • <strong>Next Smaller Element (NSE)</strong> — Stage 1 · O(n) · increasing stack · comparator flips: evict when new &lt; top; eviction event = NSE answer<br>
                        • <strong>Previous Smaller Element (PSE)</strong> — Stage 1 · O(n) · increasing stack; scan left-to-right · combine with NSE for span computation; answer on push<br>
                        • <strong>NGE on circular array</strong> — Stage 2 · O(n) · decreasing stack; process 2n elements (index mod n) · circular boundary added; same eviction rule; process array twice<br><br>
                        <strong>Group 2 — Span / Width Computation:</strong><br>
                        • <strong>Largest Rectangle in Histogram</strong> — Stage 3 · O(n) · increasing stack of (height, index) · span = i − stack.top().index − 1; width computed from span at eviction<br>
                        • <strong>Maximal Rectangle in Binary Matrix</strong> — Stage 3 · O(n·m) · histogram per row; monotone stack · 2D extension: build histogram row-by-row; apply 1D histogram solver<br>
                        • <strong>Sum of Subarray Minimums</strong> — Stage 3 · O(n) · increasing stack; count left_span × right_span per element · eviction records both left and right spans; contribution = val × left_span × right_span<br>
                        • <strong>Sum of Subarray Ranges (max − min)</strong> — Stage 3 · O(n) · two separate monotone stacks (one increasing, one decreasing) · decomposes into sum-of-maximums minus sum-of-minimums<br><br>
                        <strong>Group 3 — Monotonic Deque (Sliding Window):</strong><br>
                        • <strong>Sliding Window Maximum</strong> — Stage 3 · O(n) · decreasing deque of indices; front = window max · deque replaces O(n log n) heap; FRONT = max; expire from front; evict from back<br>
                        • <strong>Sliding Window Minimum</strong> — Stage 3 · O(n) · increasing deque · one comparator flip from window max<br>
                        • <strong>Sliding Window with Variable Size (max − min ≤ limit)</strong> — Stage 3 · O(n) · two deques (max and min) + two pointers · two deques track simultaneous max and min; window shrinks when max−min &gt; limit<br>
                        • <strong>Jump Game VI (sliding window DP max)</strong> — Stage 5 · O(n) · decreasing deque; window = [i−k, i−1] of DP values · deque replaces O(nk) DP inner loop; front of deque = max DP in window<br><br>
                        <strong>Group 4 — Stack as Span Counter:</strong><br>
                        • <strong>Daily Temperatures</strong> — Stage 1 · O(n) · decreasing stack of indices · answer = i − j for each popped j; eviction distance IS the answer<br>
                        • <strong>Online Stock Span</strong> — Stage 2 · O(n) amortised · decreasing stack of (price, span) · SPAN accumulated on push; multi-day spans merged by absorbing previous spans<br>
                        • <strong>Number of Visible People in Queue</strong> — Stage 3 · O(n) · decreasing stack; count pops + 1 (or +0 if stack empty) · count of evictions per element = visible count<br><br>
                        <strong>Group 5 — Hidden / Transformed Monotone Stack:</strong><br>
                        • <strong>Trapping Rain Water</strong> — Stage 4 · O(n) · decreasing stack OR two-pointer · water = (min(left_max, right_max) − height[i]) × width; stack tracks unfilled "basins"<br>
                        • <strong>Remove K Digits</strong> — Stage 4 · O(n) · increasing stack; pop when top &gt; current AND k &gt; 0 · result = stack contents; k remaining → pop from top; output is lexicographically smallest<br>
                        • <strong>Remove Duplicate Letters (Lexicographically Smallest)</strong> — Stage 4 · O(n) · increasing stack + last-occurrence map · pop allowed only if character appears later; combines stack with future-availability check<br>
                        • <strong>132 Pattern</strong> — Stage 4 · O(n) · decreasing stack from right; track "second element" (k3 candidate) · scan right-to-left; stack holds potential "3" values; second-largest popped = "2" value<br>
                        • <strong>Asteroid Collision</strong> — Stage 4 · O(n) · stack simulates collision; pop when top positive &lt; |new negative| · collision resolution via stack; not a "next greater" but a dominance-chain simulation<br>
                        • <strong>Decode String (nested depth)</strong> — Stage 4 · O(n) · stack of (repeat_count, current_string) pairs · stack tracks nested state; each [ pushes, each ] pops and expands<br>
                        • <strong>Largest Rectangle under Skyline</strong> — Stage 4 · O(n) · increasing stack · identical to histogram; the "skyline" framing hides the histogram structure<br>
                        • <strong>Maximum Width Ramp</strong> — Stage 4 · O(n) · decreasing stack for candidates + right-to-left scan · build decreasing stack left-to-right; scan right-to-left; two-pass O(n) without segment tree<br><br>
                        <strong>Group 6 — DP Optimised by Monotone Stack/Deque:</strong><br>
                        • <strong>Largest Sum of Averages (K partitions)</strong> — Stage 5 · O(n log n) or O(n) with deque · DP optimised by convex hull trick (CHT) or deque · monotone deque collapses O(n²) DP to O(n)<br>
                        • <strong>Minimum Cost to Cut a Stick</strong> — Stage 5 · O(n² log n) · interval DP; monotone stack acceleration on inner loop · stack reduces repeated recomputation in interval recurrences<br>
                        • <strong>Constrained Subsequence Sum</strong> — Stage 5 · O(n) · decreasing deque on DP values; window = k · dp[i] = a[i] + max(dp[i-1]..dp[i-k]); deque holds max DP in window of size k<br>
                        • <strong>Shortest Subarray with Sum ≥ K</strong> — Stage 5 · O(n) · increasing deque on prefix sums · prefix sum + monotone deque replaces O(n²) sliding window; increasing prefix deque enables O(1) check
                    </div>'''

# ── COMPLEXITY STAIRCASE ──────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Complexity Staircase</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>Sub-Variant</th><th>Time</th><th>Space</th><th>What Changed from Previous</th></tr></thead>
                        <tbody>
                        <tr><td>Next Greater Element (linear)</td><td>O(n)</td><td>O(n)</td><td>Baseline: decreasing stack, eviction = answer</td></tr>
                        <tr><td>Previous Greater Element</td><td>O(n)</td><td>O(n)</td><td>Scan direction: answer on PUSH not pop</td></tr>
                        <tr><td>NGE on circular array</td><td>O(n)</td><td>O(n)</td><td>Process 2n elements; index mod n</td></tr>
                        <tr><td>Daily Temperatures</td><td>O(n)</td><td>O(n)</td><td>Answer = eviction DISTANCE (i − j) not value</td></tr>
                        <tr><td>Online Stock Span</td><td>O(n) amortised</td><td>O(n)</td><td>Accumulated span stored IN stack entries</td></tr>
                        <tr><td>Largest Rectangle in Histogram</td><td>O(n)</td><td>O(n)</td><td>Span = left_bound + right_bound; width at eviction</td></tr>
                        <tr><td>Sum of Subarray Minimums</td><td>O(n)</td><td>O(n)</td><td>Contribution = val × left_span × right_span</td></tr>
                        <tr><td>Sum of Subarray Ranges</td><td>O(n)</td><td>O(n)</td><td>Two stacks: one increasing, one decreasing</td></tr>
                        <tr><td>Sliding Window Maximum</td><td>O(n)</td><td>O(k)</td><td>Deque: expire from front; evict from back</td></tr>
                        <tr><td>Sliding Window max−min ≤ limit</td><td>O(n)</td><td>O(k)</td><td>Two deques simultaneously; window shrinks</td></tr>
                        <tr><td>Trapping Rain Water (stack)</td><td>O(n)</td><td>O(n)</td><td>Basin computation: width × height at eviction</td></tr>
                        <tr><td>132 Pattern</td><td>O(n)</td><td>O(n)</td><td>Scan right-to-left; maintain "second" candidate</td></tr>
                        <tr><td>Constrained Subsequence Sum</td><td>O(n)</td><td>O(k)</td><td>Deque on DP values; window = k</td></tr>
                        <tr><td>Shortest Subarray Sum ≥ K</td><td>O(n)</td><td>O(n)</td><td>Deque on PREFIX SUMS (not elements); increasing</td></tr>
                        </tbody></table></div>'''

# ── MASTERY PROBLEM SET ───────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Mastery Problem Set</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>S.No</th><th>Layer</th><th>Stage</th><th>Source</th><th># / Name</th><th>Difficulty</th><th>P</th><th>Sub-Variant</th><th>New Idea Added</th><th>Key Insight</th></tr></thead>
                        <tbody>
                        <tr><td class="num-cell">1</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/next-greater-element-i/" target="_blank">496 – Next Greater Element I</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">NGE linear (query on subset)</td><td>THE baseline: decreasing stack; when a[i] &gt; stack.top(), pop and record nge[popped] = a[i]</td><td class="insight">Stack holds "waiting for challenger"; eviction event IS the answer; O(n) amortised because each element pushes/pops exactly once</td></tr>
                        <tr><td class="num-cell">2</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/daily-temperatures/" target="_blank">739 – Daily Temperatures</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">NGE: answer = DISTANCE (i − j), not value</td><td>ONE change: answer = i − j (days to wait), not the value itself; stack stores INDICES not values</td><td class="insight">Adds index tracking; distance between current and popped index IS the answer; establishes "stack stores indices, compares values via a[idx]"</td></tr>
                        <tr><td class="num-cell">3</td><td><span class="l1">1</span></td><td>1</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/online-stock-span/" target="_blank">901 – Online Stock Span</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">NGE online with ACCUMULATED SPAN</td><td>Stack stores (price, span) pairs; when popping, add popped span to current span before pushing</td><td class="insight">ONE change from S.No 2: multi-day spans are MERGED on push; span accumulation inside the stack entry</td></tr>
                        <tr><td class="num-cell">4</td><td><span class="l1">1</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/next-greater-element-ii/" target="_blank">503 – Next Greater Element II</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">NGE on CIRCULAR array</td><td>Process 2n elements; use i mod n for index; same decreasing stack and eviction rule</td><td class="insight">ONE change from S.No 1: circular wrap requires second pass; index mod n handles circularity</td></tr>
                        <tr><td class="num-cell">5</td><td><span class="l1">1</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/132-pattern/" target="_blank">456 – 132 Pattern</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">NGE from RIGHT; track "second" (k2) candidate</td><td>Scan right-to-left; decreasing stack holds potential "3" values; popped elements = "2" candidates (k2 must be &lt; k3 and &gt; k1)</td><td class="insight">ONE change: scan direction flips (right-to-left); popped value becomes the "middle" candidate; first element smaller than k2 = answer</td></tr>
                        <tr><td class="num-cell">6</td><td><span class="l1">1</span></td><td>2</td><td>🔧 CUSTOM</td><td class="prob-name">Previous Smaller Element Array</td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">PSE: answer on PUSH, not pop</td><td>Increasing stack scanned left-to-right; when pushing index i, pse[i] = stack.top() (the current top is i's blocker)</td><td class="insight">ONE change from S.No 1: previous (not next) direction; answer recorded at PUSH time; comparator flips from decreasing to increasing stack</td></tr>
                        <tr><td class="num-cell">7</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/largest-rectangle-in-histogram/" target="_blank">84 – Largest Rectangle in Histogram</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Span = left_width × height at eviction</td><td>Increasing stack; on pop of index j: width = i − stack.top() − 1; area = height[j] × width</td><td class="insight">Hard: span requires BOTH left and right bounds — left = previous stack top after pop, right = current i; WHY hard: off-by-one in width formula is nearly universal first bug</td></tr>
                        <tr><td class="num-cell">8</td><td><span class="l2">2</span></td><td>2</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximal-rectangle/" target="_blank">85 – Maximal Rectangle in Binary Matrix</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">2D extension of histogram: build height per row</td><td>Compute prefix histogram heights row-by-row; apply S.No 7 solution to each row</td><td class="insight">Hard: 2D reduction to 1D histogram is non-obvious; each row = new heights array; O(n×m) time; WHY hard: recognising the column-wise height accumulation as a histogram reduction</td></tr>
                        <tr><td class="num-cell">9</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/sum-of-subarray-minimums/" target="_blank">907 – Sum of Subarray Minimums</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Contribution counting: left_span × right_span per element</td><td>For each element, compute left_span (PSE distance) and right_span (NSE distance); contribution = val × left × right</td><td class="insight">Adds CONTRIBUTION FORMULA: each element's contribution to total sum = value × #subarrays where it is the minimum; needs both PSE and NSE</td></tr>
                        <tr><td class="num-cell">10</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/sum-of-subarray-ranges/" target="_blank">2104 – Sum of Subarray Ranges</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">TWO stacks: sum(maxima) − sum(minima)</td><td>Run S.No 9 logic twice — once with increasing stack (sum of mins), once with decreasing stack (sum of maxes); answer = difference</td><td class="insight">ONE structural change: two independent monotone stacks on the same array; decompose range = max − min into two separate sum problems</td></tr>
                        <tr><td class="num-cell">11</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/sliding-window-maximum/" target="_blank">239 – Sliding Window Maximum</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Monotone DEQUE: front = window max; expire from front</td><td>Decreasing deque of indices; when a[i] ≥ a[deque.back()]: pop back; when deque.front() out of window: pop front; answer = a[deque.front()]</td><td class="insight">Hard: deque is a double-ended structure — eviction from BACK (new beats old) AND expiry from FRONT (window moves); these are two different events; WHY hard: distinguishing the two eviction directions under pressure</td></tr>
                        <tr><td class="num-cell">12</td><td><span class="l2">2</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/longest-continuous-subarray-with-absolute-diff-less-than-or-equal-to-limit/" target="_blank">1438 – Longest Subarray with Abs Diff ≤ Limit</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">TWO deques (max + min) + two-pointer</td><td>Max-deque + min-deque simultaneously; shrink window left pointer when max_deque.front() − min_deque.front() &gt; limit</td><td class="insight">ONE change from S.No 11: TWO deques maintained simultaneously to track both extrema; window can shrink</td></tr>
                        <tr><td class="num-cell">13</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/remove-k-digits/" target="_blank">402 – Remove K Digits</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Increasing stack; pop when top &gt; current AND budget k &gt; 0</td><td>Maintain increasing stack; pop while stack.top() &gt; digit and k &gt; 0; final answer = stack contents (strip leading zeros)</td><td class="insight">Stage 4 disguise: not stated as "stack problem"; increasing stack on digits = lexicographically smallest result; k budget constrains number of pops</td></tr>
                        <tr><td class="num-cell">14</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/remove-duplicate-letters/" target="_blank">316 – Remove Duplicate Letters</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Increasing stack + last-occurrence map; pop only if char appears later</td><td>Pop stack.top() only if last_occurrence[top] &gt; i (it will appear again); maintain in_stack set to avoid duplicates</td><td class="insight">ONE change from S.No 13: unlimited k BUT pop is CONDITIONAL on future availability; requires last-occurrence HashMap</td></tr>
                        <tr><td class="num-cell">15</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/trapping-rain-water/" target="_blank">42 – Trapping Rain Water</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Decreasing stack; water computed at BASIN between two walls</td><td>On pop of index j: left wall = new stack top; right wall = i; water += (min(height[left], height[i]) − height[j]) × (i − left − 1)</td><td class="insight">Hard: stack tracks "basin floors"; water filled at eviction = basin between left and right walls; O(n) single pass; WHY hard: width = i − stack.top() − 1 AFTER pop (stack top has changed)</td></tr>
                        <tr><td class="num-cell">16</td><td><span class="l3">3</span></td><td>3</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/sum-of-total-strength-of-wizards/" target="_blank">2281 – Sum of Total Strength of Wizards</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Contribution counting with PREFIX SUMS of prefix sums</td><td>For each wizard as minimum: left_span × right_span × (sum of subarrays where it's min) = requires prefix sum of prefix sums</td><td class="insight">Hard: extends S.No 9 but answer = sum of (minimum × subarray_sum); requires double prefix sums to compute subarray-sum contributions efficiently; WHY hard: combining monotone stack spans with double prefix sums</td></tr>
                        <tr><td class="num-cell">17</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/car-fleet-ii/" target="_blank">1776 – Car Fleet II</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Decreasing stack; collision time = computed function; pop when caught</td><td>Stack of (speed, collision_time); when car i catches car on stack top, pop top; collision time = (pos[i] − pos[j]) / (speed[i] − speed[j])</td><td class="insight">Hard: "catching" = next smaller element on the time axis; stack holds cars that haven't been caught yet; WHY hard: the dominance relation is a COMPUTED TIME not a raw array value</td></tr>
                        <tr><td class="num-cell">18</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/car-fleet/" target="_blank">853 – Car Fleet</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Decreasing stack on ARRIVAL TIMES; fleet merging</td><td>Sort by position; compute arrival time = (target − pos) / speed; decreasing stack of arrival times; equal or faster cars merge into fleet</td><td class="insight">Stage 4 disguise: "fleet" = stack of groups; cars that can never catch the one ahead form their own fleet; arrival time &gt; stack top = new fleet</td></tr>
                        <tr><td class="num-cell">19</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/asteroid-collision/" target="_blank">735 – Asteroid Collision</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Stack as collision chain simulator</td><td>Positive asteroids push; negative asteroids trigger pop-loop (collision) until stack top is negative, empty, or top is larger</td><td class="insight">Stage 4: no "next greater" framing; collision chain = repeated dominance; stack models surviving asteroids after all collisions; pop-loop with conditional</td></tr>
                        <tr><td class="num-cell">20</td><td><span class="l3">3</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/remove-all-adjacent-duplicates-in-string/" target="_blank">1047 – Remove All Adjacent Duplicates in String</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Stack as character accumulator; pop on equality</td><td>Push char; if stack.top() == current: pop (adjacent duplicate eliminated); answer = remaining stack</td><td class="insight">Stage 4: no "monotone" in problem; stack maintains invariant that no two adjacent chars are equal; pop condition = EQUALITY not comparison</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#fff3cd,#ffe69c);padding:.55rem .8rem;font-weight:600;text-align:center">⚡ — — — CLIFF WARNING — — — Layer 3 → Layer 4. The next set of problems require you to DERIVE the monotone structure from scratch — the problem statement contains no keywords like "greater," "stack," or "window." You must recognise that the answer structure implies a dominance relationship and construct the correct stack variant. The hard part is not the implementation but identifying WHAT to push and WHAT eviction means.</td></tr>
                        <tr><td class="num-cell">21</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/count-submatrices-with-all-ones/" target="_blank">1504 – Count Submatrices With All Ones ✅</a></td><td><span class="diff-m">Medium</span></td><td>✅</td><td class="variant-cell">2D: count rectangles (not max area) using histogram heights</td><td>For each row: build heights; for each cell, count rectangles ending at that cell using increasing stack of consecutive heights</td><td class="insight">Adds COUNT (not max) objective to the histogram stack; each popped entry contributes a count based on min-height of the rectangle</td></tr>
                        <tr><td class="num-cell">22</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximum-width-ramp/" target="_blank">962 – Maximum Width Ramp</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Two-pass: decreasing stack left-to-right; scan right-to-left</td><td>Build decreasing stack (potential left endpoints); scan right-to-left; binary-search or two-pointer against stack to find max j − i</td><td class="insight">Stage 4: "ramp" hides a "pair with i ≤ j and a[i] ≤ a[j]" — the decreasing stack prunes dominated left candidates; second scan from right</td></tr>
                        <tr><td class="num-cell">23</td><td><span class="l4">4</span></td><td>4</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/maximum-score-of-a-good-subarray/" target="_blank">1793 – Maximum Score of a Good Subarray ✅</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Two-pointer from middle k; expanding while min ≥ score</td><td>Start at index k; expand left or right choosing whichever maintains larger min; track running min × (right − left + 1)</td><td class="insight">Hard: identical structure to histogram but with FIXED midpoint constraint; WHY hard: recognising the "expand from k" variant as a monotone-stack-equivalent argument</td></tr>
                        <tr><td class="num-cell">24</td><td><span class="l4">4</span></td><td>5</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/shortest-subarray-with-sum-at-least-k/" target="_blank">862 – Shortest Subarray with Sum ≥ K</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Increasing deque on PREFIX SUMS</td><td>Compute prefix sums P; increasing deque of indices; for each i, pop front while P[i] − P[front] ≥ K (found valid subarray); pop back while P[i] ≤ P[back]</td><td class="insight">Hard: deque applied to PREFIX SUMS not raw array; two different eviction rules for front and back serve different purposes; WHY hard: deque front pops give answers, deque back pops maintain monotonicity — two separate logical roles</td></tr>
                        <tr><td class="num-cell">25</td><td><span class="l4">4</span></td><td>5</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/max-value-of-equation/" target="_blank">1499 – Max Value of Equation</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Decreasing deque on (yi − xi) values; sliding window with constraint xj − xi ≤ k</td><td>Deque stores (yi − xi, xi); for each j, pop front while xj − xi &gt; k; answer = yj + xj + deque.front()[0]</td><td class="insight">Hard: transform yi + yj + (xj − xi) = (yi − xi) + (yj + xj); maintain deque of yi − xi in decreasing order; sliding window by x-coordinate distance; WHY hard: algebraic transformation that reveals the window maximum structure</td></tr>
                        <tr><td class="num-cell">26</td><td><span class="l4">4</span></td><td>5</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/jump-game-vi/" target="_blank">1696 – Jump Game VI</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Decreasing deque on DP VALUES; window = last k indices</td><td>dp[i] = a[i] + max(dp[i−k]..dp[i−1]); decreasing deque maintains max dp in window; front = best predecessor</td><td class="insight">DP optimisation: deque on DP VALUES (not input values); window = [i−k, i−1]; O(n) replaces O(nk) naive DP</td></tr>
                        <tr><td class="num-cell">27</td><td><span class="l4">4</span></td><td>5</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/minimum-number-of-coins-for-fruits/" target="_blank">2944 – Minimum Number of Coins for Fruits</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">Increasing deque on DP cost values; window constraint from fruit bonus</td><td>dp[i] = price[i] + min(dp[i−1]..dp[i-1+i]); deque tracks min DP in window of size i (variable window per position)</td><td class="insight">ONE change from S.No 26: window SIZE changes per position (not fixed k); deque handles variable-window min DP</td></tr>
                        <tr><td class="num-cell">28</td><td><span class="l4">4</span></td><td>5</td><td>LeetCode</td><td class="prob-name"><a class="lc-link" href="https://leetcode.com/problems/constrained-subsequence-sum/" target="_blank">1425 – Constrained Subsequence Sum</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Decreasing deque on DP values; window = k; max DP in window</td><td>dp[i] = nums[i] + max(0, max(dp[i−k..i−1])); decreasing deque; front = max dp in window</td><td class="insight">Hard: DP state is the subsequence sum; deque replaces O(nk) inner max scan; WHY hard: deciding whether to extend or restart subsequence (max with 0) combined with window constraint</td></tr>
                        <tr><td class="num-cell">29</td><td><span class="l4">4</span></td><td>5</td><td>AtCoder</td><td class="prob-name"><a class="lc-link" href="https://atcoder.jp/contests/abc236/tasks/abc236_f" target="_blank">ABC 236F – Spices</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Monotone stack + offline query processing</td><td>Sort queries and elements; offline sweepline with monotone stack answers "largest element ≤ query threshold in range"</td><td class="insight">Hard: offline transformation + monotone stack on non-standard "range" query; combines Stage 4 reduction with Stage 5 data structure</td></tr>
                        <tr><td class="num-cell">30</td><td><span class="l4">4</span></td><td>5</td><td>Codeforces</td><td class="prob-name"><a class="lc-link" href="https://codeforces.com/problemset/problem/1788/E" target="_blank">CF 1788E – Hemose on the Tree</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">Monotone stack for parity pairing on DFS order</td><td>DFS order linearises tree; monotone stack pairs heavy/light nodes to minimise XOR-sum; greedy pairing via stack</td><td class="insight">Hard: tree problem reduced to array problem via DFS order; monotone stack provides greedy pairing; WHY hard: the tree-to-array reduction is the Stage 4 component; stack pairing is Stage 5</td></tr>
                        <tr><td colspan="10" style="background:linear-gradient(90deg,#ffe6e6,#ffd0d0);padding:.55rem .8rem;font-weight:600;text-align:center">⚠️ TRAP ZONE — Problems that LOOK like monotone stack but require a completely different technique.</td></tr>
                        <tr><td class="num-cell">31</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>LeetCode</td><td class="prob-name trap-name"><a class="lc-link" href="https://leetcode.com/problems/min-stack/" target="_blank">155 – Min Stack ⚠️</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">⚠️ TRAP — auxiliary min stack, NOT monotone stack</td><td>Maintain a separate min-tracking stack alongside the main stack; min stack is NOT monotone (it allows duplicates with different conditions)</td><td class="insight">NOT a monotone stack problem: the auxiliary min stack has a different invariant; applying monotone eviction gives wrong answers on sequences with duplicates</td></tr>
                        <tr><td class="num-cell">32</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>LeetCode</td><td class="prob-name trap-name"><a class="lc-link" href="https://leetcode.com/problems/longest-valid-parentheses/" target="_blank">32 – Longest Valid Parentheses ⚠️</a></td><td><span class="diff-h">Hard</span></td><td></td><td class="variant-cell">⚠️ TRAP — stack of INDICES of unmatched brackets, not monotone</td><td>Stack holds indices of unmatched (; length = i − stack.top() when ) matches; stack invariant = remaining unmatched positions, NOT monotone by value</td><td class="insight">NOT a monotone stack: the stack holds structural bracket positions; no dominance/comparison relationship; eviction on match not on value comparison</td></tr>
                        <tr><td class="num-cell">33</td><td><span class="l5">⚠️Trap</span></td><td>—</td><td>LeetCode</td><td class="prob-name trap-name"><a class="lc-link" href="https://leetcode.com/problems/merge-intervals/" target="_blank">56 – Merge Intervals ⚠️</a></td><td><span class="diff-m">Medium</span></td><td></td><td class="variant-cell">⚠️ TRAP — sort + greedy merge, NOT a stack</td><td>Sort by start time; merge overlapping intervals with a running cur_end; no dominance relationship</td><td class="insight">NOT a monotone stack: no element "dominates" another by value; interval merging = sort + linear scan; applying stack gives same complexity but reveals wrong mental model</td></tr>
                        </tbody></table></div>'''

# ── CUSTOM PROBLEM STATEMENT ──────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Custom Problem Statement</div>
                    <div class="info-box">
                        <strong>🔧 CUSTOM — S.No 6: Previous Smaller Element Array</strong><br><br>
                        <strong>Problem Statement:</strong> Given an integer array <code>nums</code> of length n (1 ≤ n ≤ 10⁵, −10⁹ ≤ nums[i] ≤ 10⁹), for each index i, find the index of the nearest element to the LEFT of i that is STRICTLY SMALLER than nums[i]. If no such element exists, output −1 for that index.<br><br>
                        <strong>Input:</strong> Single line: n, then n integers. &nbsp;<strong>Output:</strong> n integers — the PSE index for each position.<br>
                        <strong>Example:</strong> Input: <code>5 &nbsp;2 1 3 0 5</code> → Output: <code>-1 -1 1 -1 3</code><br><br>
                        <strong>Intended solution (Stage 1):</strong> Maintain an increasing stack of indices. For each index i, pop the stack while nums[stack.top()] ≥ nums[i]. After popping (or if stack is empty), pse[i] = stack.top() (or −1 if empty). Then push i. Each index pushed/popped once → O(n).<br>
                        <em>Stage: Stage 1 (introduces PREVIOUS direction and answer-on-push).</em>
                    </div>'''

# ── PATTERN RECOGNITION TRIGGERS ─────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Pattern Recognition Triggers</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>Linguistic Triggers:</strong><br>
                        • "find the next/previous greater/smaller element" → Stage 1 monotone stack immediately; choose decreasing (for greater) or increasing (for smaller); direction determines scan order<br>
                        • "sliding window maximum / minimum" → Stage 3 monotone deque; decreasing deque for max; increasing deque for min; front = answer; two eviction directions (back = dominated, front = expired)<br>
                        • "largest rectangle / area / maximal substructure" → Stage 3 histogram variant; increasing stack; area = height × computed_width at eviction time<br>
                        • "span / days until / how many consecutive" → Stage 1/2 span variant; answer = eviction DISTANCE (i − j) not value; stack stores indices<br>
                        • "sum of subarray minimums / maximums / contribution of each element" → Stage 3 contribution counting; contribution = val × left_span × right_span; needs both PSE and NSE<br><br>
                        <strong>Structural Triggers:</strong><br>
                        • Input is a single array and the answer for each position depends on the nearest "dominating" element → monotone stack; O(n) because each element enters/leaves the stack exactly once<br>
                        • Answer involves a PRODUCT of a value and a WIDTH/SPAN → histogram-style; stack stores index so width can be computed at eviction<br>
                        • Query involves a sliding window and you need running max or min without re-scanning the entire window → monotone deque; O(n) total<br><br>
                        <strong>Constraint Triggers:</strong><br>
                        • n ≤ 10⁶ and brute-force O(n²) TLEs → monotone stack/deque is the intended O(n) solution; constant factor of 2n operations<br>
                        • DP transition dp[i] = f(a[i], max(dp[i−k..i−1])) with a fixed or variable window → Stage 5 deque-optimised DP; deque tracks max DP in the window; O(n) replaces O(nk)<br><br>
                        <strong>Anti-Triggers (do NOT use monotone stack):</strong><br>
                        • "find the K-th greatest element in a sliding window" → NOT monotone stack/deque (deque only gives top-1) → Use a sorted multiset or segment tree for top-K<br>
                        • "find the nearest element with value within range [lo, hi]" → NOT monotone stack (range query, not dominance) → Use a sorted set with binary search or segment tree<br>
                        • "find the longest increasing subsequence" → NOT monotone stack (patience sort / DP + binary search) → Use a tails array with binary search; LIS has no local dominance structure that a monotone stack can exploit
                    </div>'''

# ── DECISION FRAMEWORK ────────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Decision Framework</div>
                    <div class="info-box">
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code>Q1: Does the problem ask about each element's relationship with
    the NEAREST element that is greater/smaller (left or right)?
  → YES: Monotone stack. Continue to Q2.
  → NO:  Continue to Q3.

Q2: Is the direction LEFT (previous) or RIGHT (next)?
  → NEXT (right): scan left-to-right; answer recorded at EVICTION (pop).
  → PREVIOUS (left): scan left-to-right; answer recorded at PUSH
                     (current stack top = previous dominator).
  → BOTH (span/contribution): run two passes or use a single stack
    tracking both left_span and right_span.
  → If you reach this node → Stage 1. O(n). Stack of indices.

Q3: Does the problem involve a SLIDING WINDOW and you need the
    running maximum or minimum inside the window?
  → YES: Monotone DEQUE. Front = window max/min. Two eviction rules:
         back pop = new element dominates old (will never be max/min again).
         front pop = element has left the window (index out of range).
  → If you reach this node → Stage 3. O(n). Deque of indices.
  → NO: Continue to Q4.

Q4: Does the problem involve SPAN COMPUTATION
    (area = height × width, or contribution = value × span)?
  → YES: Increasing stack (for minimums as height boundaries).
         Width = i − previous_stack_top − 1 at eviction.
         Area = height[popped] × width.
  → If you reach this node → Stage 3. O(n). Stack of (index, value) or just index.
  → NO: Continue to Q5.

Q5: Does the problem LOOK UNRELATED to stacks but involve:
    - lexicographically smallest result after K deletions?
    - collision/dominance chain resolution?
    - DP with window-max/min inner transition?
  → Lex smallest after deletions → increasing stack; pop when top &gt; current AND budget &gt; 0.
                                  → Stage 4. O(n).
  → Collision chain → stack-based simulation; pop while top is dominated.
                    → Stage 4. O(n).
  → DP window transition → deque on DP values; window = [i−k, i−1].
                         → Stage 5. O(n).
  → NO: This problem may not be a monotone stack problem.
        Check: prefix sums, segment tree, two-pointer.

Q6: Is the naive DP or brute force O(n²) or O(nk)?
  → YES: Look for a monotone deque to collapse the inner O(n) or O(k) scan.
         The DP transition must have the form:
         dp[i] = f(a[i], optimal(dp[j] for j in [i−k, i−1])).
  → If you reach this node → Stage 5. O(n).
     If your solution is O(n log n) with a segment tree, ask:
     "Is the window a contiguous range? If so, deque suffices."

──────────────────────────────────────────────────────
Summary:
  "Next/prev greater/smaller" → Stage 1.  O(n). Stack.
  "Circular or span"          → Stage 2.  O(n). Stack.
  "Histogram / contribution"  → Stage 3.  O(n). Stack + width formula.
  "Sliding window max/min"    → Stage 3.  O(n). Deque.
  "Hidden dominance"          → Stage 4.  O(n). Stack or deque.
  "DP with window optimal"    → Stage 5.  O(n). Deque on DP values.
──────────────────────────────────────────────────────</code></pre>
                    </div>'''

# ── WHEN THIS TECHNIQUE BREAKS ────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">When This Technique BREAKS</div>
                    <div class="warn-box"><strong>[Stage 1] Applying monotone stack when elements can have equal values and "non-strict" comparisons are needed:</strong> A strict decreasing stack pops elements equal to the current value, which can double-count contributions in Sum of Subarray Minimums. Fix: use strict comparison on ONE side (left: strictly smaller; right: smaller or equal) to avoid double-counting subarrays. This is a subtle bug, not a technique failure.</div>
                    <div class="warn-box"><strong>[Stage 2] Applying a single monotone stack to a circular array without handling the "never-popped" elements:</strong> Elements that are the global maximum are never popped in the circular pass. If the answer for unpopped elements is "no next greater element," you must explicitly output −1 for them. Fix: after the 2n pass, any index still in the stack has no NGE; assign −1.</div>
                    <div class="warn-box"><strong>[Stage 3] Using a monotone STACK instead of a DEQUE for sliding window problems:</strong> A monotone stack evicts from the top only; it has no mechanism to expire elements that have left the window. A deque is required because it supports both back-eviction (dominated) and front-expiry (out of window). Fix: sliding window max/min always requires a deque, never a stack.</div>
                    <div class="warn-box"><strong>[Stage 3] Counting subarray contributions with WRONG strict/non-strict boundaries:</strong> In Sum of Subarray Minimums, if you use ≤ on both PSE and NSE, subarrays with equal minimum values are double-counted. Standard fix: PSE uses strict &lt; (previous strictly smaller), NSE uses non-strict ≤ (next smaller or equal) — or vice versa consistently. Fix: always document which side uses strict comparison and why.</div>
                    <div class="warn-box"><strong>[Stage 4] Missing the algebraic transformation that reveals a window-max structure:</strong> In problems like Max Value of Equation (S.No 25), the expression yi + yj + xj − xi must be rewritten as (yi − xi) + (yj + xj) to isolate the window-max component. Without this algebra step, no stack or deque solution is visible. Fix: for problems involving pairs (i, j) with a distance constraint, always try decomposing the expression into f(i) + g(j) where f(i) is the window-max component.</div>
                    <div class="warn-box"><strong>[Stage 5] Using a segment tree when a deque suffices:</strong> For DP transitions of the form dp[i] = a[i] + max(dp[i−k..i−1]), a segment tree gives O(n log n) but a deque gives O(n). The deque works because the window advances monotonically — old minimums expire in order. Fix: check if the window moves left-to-right without jumping → deque is sufficient and faster.</div>
                    <div class="warn-box"><strong>[Stage 5] Applying monotone deque to non-contiguous windows:</strong> The deque's front-expiry mechanism assumes the window is a contiguous range advancing one step at a time. If the DP transition allows non-contiguous lookback (e.g., "choose any j ≤ i"), the deque's front expiry gives wrong answers. Fix: non-contiguous window → segment tree or sparse table.</div>'''

# ── PROOF OF CORRECTNESS SKELETON ────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Proof of Correctness Skeleton</div>
                    <div class="core-box">
                        <strong>Stage 1 — Next Greater Element (NGE): Invariant Maintenance</strong><br>
                        <em>Claim:</em> When index j is popped from the decreasing stack by element at index i, a[i] is the FIRST element to the right of j with value &gt; a[j].<br>
                        <em>Proof:</em> Suppose some index k with j &lt; k &lt; i satisfies a[k] &gt; a[j]. Then when we processed k, we would have popped j from the stack (since a[k] &gt; a[j] violates the decreasing stack invariant). But j is still in the stack when we process i — contradiction. Therefore no such k exists. a[i] is the first element to the right of j that exceeds a[j]. ✓<br>
                        <em>Amortised O(n):</em> Each index enters the stack exactly once (on its turn) and exits at most once (when beaten). Total operations ≤ 2n. □<br><br>
                        <strong>Stage 3 — Largest Rectangle in Histogram: Width Correctness</strong><br>
                        <em>Claim:</em> When index j is popped by element i (with height[i] &lt; height[j]), the maximum rectangle with height height[j] has width = i − new_stack_top − 1 (where new_stack_top = index now at top after j is popped).<br>
                        <em>Proof:</em> All elements between new_stack_top + 1 and i − 1 (inclusive) have height ≥ height[j] — otherwise one of them would have caused j to be popped earlier. ✓ The element at new_stack_top has height &lt; height[j] (that's why it wasn't popped — it was the first element smaller than j when j was pushed). ✓ The element at i has height &lt; height[j] (that's why i is popping j now). ✓ Therefore the maximal rectangle of height height[j] can extend exactly from new_stack_top + 1 to i − 1. Width = i − new_stack_top − 1. Area = height[j] × (i − new_stack_top − 1). □<br><br>
                        <strong>Stage 5 — Deque-Optimised DP (Constrained Subsequence Sum): Correctness</strong><br>
                        <em>Claim:</em> The decreasing deque on DP values correctly maintains max(dp[i−k..i−1]) as the deque front for each i.<br>
                        <em>Proof:</em> Monotone invariant: when dp[i] ≥ dp[deque.back()], the back is evicted because it can never be the future window maximum (i is both larger in value AND more recent in position). ✓ Front expiry: when deque.front() &lt; i − k, the front has exited the window — pop it; new front = maximum dp in [i−k, i−1]. ✓ At each step i, deque.front() = argmax of dp values in [i−k, i−1] — exactly the optimal predecessor for dp[i]. ✓ O(n): each index enters/leaves deque at most once → ≤ 2n ops. □
                    </div>'''

# ── IMPLEMENTATION PITFALLS ───────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Implementation Pitfalls (Code-Level)</div>
                    <div class="warn-box"><strong>Bug 1 — Using value instead of index in stack (prevents span computation) [Stage 1–2]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: storing values makes it impossible to compute width/distance
stack = []
for val in heights:
    while stack and stack[-1] &gt; val:
        stack.pop()
    stack.append(val)   # BUG: stored value, not index

# FIX: always store INDICES; access value via heights[idx]
for i, val in enumerate(heights):
    while stack and heights[stack[-1]] &gt; val:
        stack.pop()
    stack.append(i)   # FIX: store index</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 2 — Off-by-one in histogram width formula [Stage 1–2]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: width computed before popping; stack top is still j (not the left boundary)
while stack and heights[stack[-1]] &gt;= heights[i]:
    j = stack.pop()
    left = stack[-1] if stack else -1
    width = i - j   # BUG: should be i - left - 1
    # FIX:
    width = i - left - 1   # correct: from left+1 to i-1, inclusive</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 3 — Circular NGE: initialising result array incorrectly [Stage 1–2]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: result initialised to 0; elements with no NGE get 0 not -1
result = [0] * n   # BUG
for i in range(2 * n):
    while stack and nums[stack[-1]] &lt; nums[i % n]:
        result[stack.pop()] = nums[i % n]
# FIX: initialise to -1; unpopped stack elements keep -1
result = [-1] * n</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 4 — NGE: comparing values but pushing values (can't find original index) [Stage 1–2]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: stack has values, but you need the original index for result assignment
stack = [nums[0]]
for i in range(1, n):
    while stack and stack[-1] &lt; nums[i]:
        result[???] = nums[i]   # BUG: can't get original index
        stack.pop()
# FIX: stack holds INDICES
stack = [0]
for i in range(1, n):
    while stack and nums[stack[-1]] &lt; nums[i]:
        result[stack.pop()] = nums[i]
    stack.append(i)</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 5 — Stock Span: not including the current span in the accumulated span [Stage 1–2]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: accumulated span misses the current day's own span of 1
while stack and stack[-1][0] &lt;= price:
    span += stack.pop()[1]
stack.append((price, span))   # BUG: span starts at 0; misses the day itself
# FIX: initialise span = 1 before the while loop
span = 1
while stack and stack[-1][0] &lt;= price:
    span += stack.pop()[1]
stack.append((price, span))</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 6 — Sum of Subarray Minimums: double-counting equal elements [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: both PSE and NSE use strict comparison; equal-element subarrays counted twice
# left: strictly smaller (pop while &gt;=), right: strictly smaller (pop while &gt;=) -- BUG
# FIX: use ASYMMETRIC comparisons
# left boundary: pop while heights[stack[-1]] &gt;= heights[i]  (strictly smaller PSE)
# right boundary: pop while heights[stack[-1]] &gt;  heights[i]  (smaller-or-equal NSE)
# This assigns each subarray with equal minimums to exactly one "representative"</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 7 — Sliding window deque: using wrong eviction condition for front vs. back [Stage 3]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: expiring from back (out-of-window check) and dominating from front
deque = []
for i in range(n):
    while deque and deque[0] &lt;= i - k:    # BUG: should check FRONT for expiry
        deque.pop()                        # BUG: should popleft() for front
    while deque and nums[deque[-1]] &lt;= nums[i]:
        deque.pop()
    deque.append(i)
# FIX: expire from FRONT (popleft), evict dominated from BACK (pop)
from collections import deque as Deque
dq = Deque()
for i in range(n):
    while dq and dq[0] &lt;= i - k:          # expire out-of-window from FRONT
        dq.popleft()
    while dq and nums[dq[-1]] &lt;= nums[i]: # evict dominated from BACK
        dq.pop()
    dq.append(i)
    if i &gt;= k - 1:
        result.append(nums[dq[0]])</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 8 — Remove K Digits: not stripping leading zeros from result [Stage 4]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: result may start with '0' after removals
stack = []
for d in num:
    while k and stack and stack[-1] &gt; d:
        stack.pop(); k -= 1
    stack.append(d)
return ''.join(stack[:len(stack)-k])   # BUG: may return "0123"
# FIX: strip leading zeros, handle empty case
result = ''.join(stack[:len(stack)-k]).lstrip('0')
return result or '0'</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 9 — 132 Pattern: not correctly tracking the "second" (k2) candidate [Stage 4]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: updating third BEFORE popping all dominated elements
while stack and stack[-1] &lt; nums[i]:
    third = nums[i]   # BUG: third should be the POPPED value not nums[i]
    stack.pop()
# FIX: third = stack.pop() (the popped value IS the k2 candidate)
third = float('-inf')
stack = []
for i in range(n - 1, -1, -1):
    if nums[i] &lt; third:
        return True
    while stack and stack[-1] &lt; nums[i]:
        third = stack.pop()   # FIX: popped value is the k2 candidate
    stack.append(nums[i])</code></pre>
                    </div>
                    <div class="warn-box"><strong>Bug 10 — Deque-optimised DP: not pruning the front before reading max [Stage 5]:</strong>
                        <pre style="white-space:pre-wrap;margin:.4rem 0"><code># BUG: reading deque.front() without first checking if it's out of the window
for i in range(n):
    while dq and dp[dq[-1]] &lt; dp[i - 1]:  # back eviction
        dq.pop()
    if i &gt; 0:
        dq.append(i - 1)
    dp[i] = nums[i] + (dp[dq[0]] if dq else 0)  # BUG: dq[0] may be out of window
# FIX: prune expired front BEFORE accessing it
for i in range(n):
    while dq and dq[0] &lt; i - k:   # expire front FIRST
        dq.popleft()
    dp[i] = nums[i] + max(0, dp[dq[0]] if dq else 0)
    while dq and dp[dq[-1]] &lt;= dp[i]:  # then evict dominated back
        dq.pop()
    dq.append(i)</code></pre>
                    </div>'''

# ── RED FLAGS / COMMON MISTAKES ───────────────────────────────────────────
NEW += '''
                    <div class="sec-title">Red Flags / Common Mistakes</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>[Stage 1] Storing VALUES in the stack instead of INDICES:</strong> Candidates who push values directly cannot compute spans, distances, or indices. Every monotone stack problem requires computing either i − j (distance) or i − stack.top() − 1 (width). Correct mental model: the stack always stores INDICES; values are looked up via a[stack[-1]] when needed for comparison.<br>
                        <strong>[Stage 2] Forgetting to handle "never-popped" elements after the main loop:</strong> Elements that are the global maximum are never evicted in a decreasing stack. If the problem requires output for every position, these elements need explicit handling after the loop. Correct model: after the loop, any index remaining in the stack has no NGE (or NSE); explicitly assign their answer (usually −1 or 0).<br>
                        <strong>[Stage 3] Confusing monotone STACK with monotone DEQUE:</strong> A stack only has one open end; it cannot expire elements that have left a sliding window. Correct model: if the problem has a window that advances (elements expire), you MUST use a deque — the front-pop mechanism for expiry has no stack equivalent.<br>
                        <strong>[Stage 3] Wrong strict/non-strict comparison in Sum of Subarray Minimums:</strong> Using strict &lt; on both sides causes subarrays with equal elements to be counted by both boundary elements, doubling contributions. Correct model: use asymmetric comparisons — one side strict (&lt;), other side non-strict (≤) — so every subarray is assigned to exactly ONE element as its minimum.<br>
                        <strong>[Stage 4] Failing to recognise the algebraic transformation in "pair-with-distance-constraint" problems:</strong> Problems like LeetCode 1499 require rewriting f(i, j) as g(i) + h(j) to separate the window-max component. Correct model: when the problem asks for the maximum of f(i) + g(j) over j in a window, f(i) is the window-max component; store and maximise it via deque.<br>
                        <strong>[Stage 5] Using a segment tree instead of a deque for window-DP transitions:</strong> For DP transitions with a SLIDING window advancing monotonically, a deque achieves O(n). Correct model: if the window is contiguous and advances one step at a time (never jumps), a deque is always sufficient and faster than a segment tree.<br>
                        <strong>[Stage 4] Applying monotone stack to EQUAL elements without careful tie-breaking:</strong> In problems with many duplicate values, a naive decreasing stack either never pops or always pops, giving the wrong answer. Correct model: always define the comparison explicitly (strict vs. non-strict) before coding; draw a small example with duplicates and verify before submitting.
                    </div>'''

# ── INTERVIEWER FOLLOW-UP QUESTIONS ──────────────────────────────────────
NEW += '''
                    <div class="sec-title">Interviewer Follow-Up Questions</div>
                    <div class="tbl-wrap"><table>
                        <thead><tr><th>#</th><th>Stage</th><th>Question</th><th>Intended Answer Direction</th></tr></thead>
                        <tbody>
                        <tr><td>1</td><td>2</td><td>"What if the array is circular? How does your NGE solution change?"</td><td>Process 2n elements with i mod n; don't push elements whose NGE is already found in first pass; elements never popped in 2n iterations have no NGE (assign −1)</td></tr>
                        <tr><td>2</td><td>2</td><td>"What if we want PREVIOUS greater instead of next greater?"</td><td>Scan left-to-right; answer recorded at PUSH time (current stack top = previous dominator); same decreasing stack; eviction rule unchanged</td></tr>
                        <tr><td>3</td><td>3</td><td>"Extend your histogram solution to a binary matrix. Find the maximal rectangle."</td><td>Build prefix height array per row; apply histogram solution row-by-row; O(n×m) time; the 2D structure reduces to repeated 1D calls</td></tr>
                        <tr><td>4</td><td>3</td><td>"How would you compute the SUM of areas of ALL subarray minimums × subarray length?"</td><td>Contribution counting: for each element, compute PSE distance (left span) and NSE distance (right span); contribution = val × left × right; sum all contributions; O(n) two-pass or single-pass with stack</td></tr>
                        <tr><td>5</td><td>4</td><td>"How does the monotone deque work? Why is it O(n) and not O(n log n)?"</td><td>Each element enters and exits the deque at most once (amortised); total operations ≤ 2n; dominated elements are evicted BEFORE they could ever be the window maximum, so evicting them early is safe and does not require re-processing</td></tr>
                        <tr><td>6</td><td>4</td><td>"The problem says 'find the shortest subarray with sum ≥ K where K can be negative.' How does your approach change?"</td><td>Negative K means prefix sums may be non-monotone; the standard two-pointer fails; need the monotone deque on prefix sums (LC 862); deque maintains increasing prefix sums; for each i, pop front while P[i] − P[front] ≥ K (answer candidate)</td></tr>
                        <tr><td>7</td><td>5</td><td>"You have a DP: dp[i] = a[i] + max(dp[i−k..i−1]). How do you optimise it from O(nk) to O(n)?"</td><td>Maintain a decreasing deque of (dp_value, index) pairs; for each i: (1) expire front if index &lt; i−k; (2) dp[i] = a[i] + deque.front().dp_value; (3) evict back while dp[back] ≤ dp[i]; (4) push i. Total O(n).</td></tr>
                        <tr><td>8</td><td>5</td><td>"What if the window in the DP transition is not fixed (size varies per position)?"</td><td>Variable window: the front-expiry condition changes per i (e.g., deque.front() &lt; lower_bound(i) where lower_bound is position-dependent); same deque structure; just update the expiry condition per step (LC 2944 pattern)</td></tr>
                        <tr><td>9</td><td>Beyond</td><td>"In a distributed system, elements arrive out-of-order and you need the sliding window maximum. How do you handle it?"</td><td>Assign each element a timestamp; use a priority queue (heap) per window ordered by timestamp; when an element arrives late, check if it falls within the current window; for exact answers, buffer elements up to max latency before committing window results; for approximate, use count-min sketch</td></tr>
                        <tr><td>10</td><td>Beyond</td><td>"You need the K-th largest in every sliding window of size W. Monotone deque only gives top-1. What do you do?"</td><td>For arbitrary K: maintain a sorted data structure (SortedList in Python, multiset in C++) with O(log n) insert/delete; for small K: maintain K separate deques (one per rank); for offline queries: segment tree with merge sort tree or wavelet tree gives O(n log² n)</td></tr>
                        </tbody></table></div>'''

# ── 3-PHASE MASTERY PLAN ──────────────────────────────────────────────────
NEW += '''
                    <div class="sec-title">3-Phase Mastery Plan</div>
                    <div class="info-box" style="line-height:1.8">
                        <strong>Phase 1 — Solve (strictly by Stage across all sub-variants):</strong><br>
                        <em>Stage 1 — Establish the eviction = answer invariant:</em><br>
                        S.No 1 (NGE linear) → S.No 2 (Daily Temperatures, distance) → S.No 3 (Stock Span, accumulated span) → S.No 6 (PSE custom, answer on push)<br>
                        After these four: write any monotone stack from scratch in under 5 minutes given a new dominance criterion; state the invariant before touching code<br><br>
                        <em>Stage 2 — Add circular and directional constraints:</em><br>
                        S.No 4 (NGE circular) → S.No 5 (132 Pattern, right-to-left)<br>
                        Drill: for each, explicitly state "scan direction" and "when answer is recorded (push vs. pop)" before coding<br><br>
                        <em>Stage 3 — Span computation and deque:</em><br>
                        S.No 7 (Histogram) → S.No 8 (Maximal Rectangle) → S.No 9 (Sum Subarray Mins) → S.No 10 (Sum Subarray Ranges) → S.No 11 (Sliding Window Max) → S.No 12 (Two deques)<br>
                        Critical drill: for each histogram/contribution problem, derive the width formula on paper before coding; label PSE and NSE explicitly<br><br>
                        <em>Stage 4 — Hidden dominance (no stack keywords):</em><br>
                        S.No 13 (Remove K Digits) → S.No 14 (Remove Duplicate Letters) → S.No 15 (Trapping Rain Water) → S.No 19 (Asteroid Collision) → S.No 22 (Max Width Ramp) → S.No 24 (Shortest Subarray Sum ≥ K)<br>
                        For each: state the dominance relationship in one sentence BEFORE looking at any solution<br><br>
                        <em>Stage 5 — DP optimisation by deque:</em><br>
                        S.No 26 (Jump Game VI) → S.No 27 (Min Coins Fruits) → S.No 28 (Constrained Subsequence Sum) → S.No 25 (Max Value of Equation)<br>
                        For each: write the naive O(nk) DP first; then identify the window-max component; then replace with deque<br><br>
                        <strong>Phase 2 — Drill (speed and pattern recognition):</strong><br>
                        • 10-minute drill (Stage 1): NGE, PGE, NSE, PSE — solve all four variants on a fresh array in under 10 minutes total; no reference<br>
                        • Recognition drill: Cover problem titles; state Stage (1–5), stack type (increasing/decreasing), scan direction, answer-on-push vs. answer-on-pop in 15 seconds each<br>
                        • Width formula drill: Given any histogram-style problem, derive width = i − stack.top() − 1 from scratch with a 5-element example before coding<br>
                        • Deque drill: Implement sliding window max and sliding window min back-to-back in under 15 minutes; explicitly label front-expiry and back-eviction code comments<br>
                        • Comparator drill: Given a new problem, identify strict (&lt;) vs. non-strict (≤) comparison in under 30 seconds by checking if duplicates should be treated as separate or merged<br><br>
                        <strong>Phase 3 — Validate (unseen problem sources):</strong><br>
                        • Stage 1–2: Codeforces Div. 2 B/C problems tagged "stack" from recent rounds not in this guide (search CF tag "stack" + difficulty 1400–1800)<br>
                        • Stage 2–3: USACO Silver problems involving "span" computation on arrays of animal heights, fence posts, etc.<br>
                        • Stage 4–5: AtCoder ABC D/E problems tagged "stack" or "monotone stack" from recent rounds not in this guide
                    </div>
                </div>
            </div>'''

# ── REPLACEMENT ───────────────────────────────────────────────────────────
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

start = content.find('<div class="topic-card" id="tp16">')
end_marker = '<div class="topic-card" id="tp17">'
end = content.find(end_marker, start)

print('start:', start, 'end:', end, 'old_len:', end - start)

new_content = content[:start] + NEW + '\n            ' + content[end:]
print('new_file_len:', len(new_content))

with open(path, 'w', encoding='utf-8') as f:
    f.write(new_content)

print('Done.')
