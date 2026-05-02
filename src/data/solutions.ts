import type { Solution } from './solution-model';
import { solutionsFromDb } from './solutions.db.generated';

export type { Step, Solution } from './solution-model';

/** Hand-written overlays; same LC key wins over DB-generated stubs. */
const manualSolutions: Record<string, Solution> = {

  // ── Two Pointers ───────────────────────────────────────────────
  '167': {
    approach: 'Two Pointers', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Place pointers at both ends', code: ['left, right = 0, len(numbers) - 1'], note: 'Array is sorted — start wide, squeeze inward.' },
      { title: 'Compute current sum', code: ['curr = numbers[left] + numbers[right]'], note: 'Sum of the two candidates.' },
      { title: 'Move pointer based on comparison', code: ['if curr == target:', '    return [left+1, right+1]', 'elif curr < target:', '    left += 1   # need larger sum', 'else:', '    right -= 1  # need smaller sum'], note: 'One guaranteed answer exists — no need for extra checks.' },
    ],
  },

  '11': {
    approach: 'Two Pointers', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Start at widest container', code: ['left, right = 0, len(height) - 1', 'max_water = 0'], note: 'Widest width is the best starting point.' },
      { title: 'Compute water at current window', code: ['water = min(height[left], height[right]) * (right - left)', 'max_water = max(max_water, water)'], note: 'Height is limited by the shorter wall.' },
      { title: 'Move the shorter wall inward', code: ['if height[left] < height[right]:', '    left += 1', 'else:', '    right -= 1'], note: 'Only moving the shorter wall can possibly increase area.' },
    ],
  },

  '15': {
    approach: 'Sort + Two Pointers', time: 'O(n²)', space: 'O(1)',
    steps: [
      { title: 'Sort the array', code: ['nums.sort()'], note: 'Sorting enables the two-pointer inner loop.' },
      { title: 'Fix first element, run two pointers', code: ['for i in range(len(nums) - 2):', '    if i > 0 and nums[i] == nums[i-1]:', '        continue  # skip duplicate'], note: 'Skip duplicate starting values to avoid repeat triplets.' },
      { title: 'Inner two-pointer loop', code: ['    left, right = i+1, len(nums)-1', '    while left < right:', '        s = nums[i]+nums[left]+nums[right]', '        if s == 0: res.append([...])', '        if s <= 0: left += 1', '        else: right -= 1'], note: 'Exactly like Two Sum II but nested.' },
    ],
  },

  '125': {
    approach: 'Two Pointers', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Set up pointers at both ends', code: ['left, right = 0, len(s) - 1'], note: 'Compare characters from outside in.' },
      { title: 'Skip non-alphanumeric characters', code: ['while left < right:', '    while left < right and not s[left].isalnum():', '        left += 1', '    while left < right and not s[right].isalnum():', '        right -= 1'], note: 'Ignore spaces, punctuation.' },
      { title: 'Compare and advance', code: ['    if s[left].lower() != s[right].lower():', '        return False', '    left += 1', '    right -= 1', 'return True'], note: 'Mismatch → not a palindrome.' },
    ],
  },

  '283': {
    approach: 'Two Pointers (Write Pointer)', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Use a slow write pointer', code: ['write = 0'], note: 'write marks the next position to fill with a non-zero.' },
      { title: 'Copy non-zeros to the front', code: ['for val in nums:', '    if val != 0:', '        nums[write] = val', '        write += 1'], note: 'Every non-zero slides left, preserving order.' },
      { title: 'Fill remaining positions with zeros', code: ['while write < len(nums):', '    nums[write] = 0', '    write += 1'], note: 'Everything after write was a zero.' },
    ],
  },

  // ── Sliding Window ─────────────────────────────────────────────
  '3': {
    approach: 'Sliding Window + Hash Set', time: 'O(n)', space: 'O(min(n,m))',
    steps: [
      { title: 'Initialize window', code: ['char_set = set()', 'left = 0', 'best = 0'], note: 'Set tracks characters in the current window.' },
      { title: 'Expand right, shrink if duplicate', code: ['for right in range(len(s)):', '    while s[right] in char_set:', '        char_set.remove(s[left])', '        left += 1', '    char_set.add(s[right])'], note: 'Shrink from left until the duplicate is evicted.' },
      { title: 'Update best answer', code: ['    best = max(best, right - left + 1)', 'return best'], note: 'Window is valid — record its size.' },
    ],
  },

  '76': {
    approach: 'Sliding Window + Frequency Map', time: 'O(n+m)', space: 'O(m)',
    steps: [
      { title: 'Build target frequency map', code: ['need = Counter(t)', 'have, formed = 0, 0', 'l, res = 0, [-1,0,0]'], note: 'need[c] = how many of c are still required.' },
      { title: 'Expand right', code: ['for r, c in enumerate(s):', '    window[c] += 1', '    if c in need and window[c] == need[c]:', '        formed += 1'], note: 'formed counts how many characters are fully satisfied.' },
      { title: 'Contract left while window is valid', code: ['    while formed == len(need):', '        if res[0]==-1 or r-l+1 < res[0]:', '            res = [r-l+1, l, r]', '        window[s[l]] -= 1', '        if s[l] in need and window[s[l]] < need[s[l]]:', '            formed -= 1', '        l += 1'], note: 'Greedily shrink to find the minimum valid window.' },
    ],
  },

  '424': {
    approach: 'Sliding Window + Max Frequency', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Track max frequency in window', code: ['freq = {}, max_freq = 0', 'left = 0'], note: 'We only care about the most common character.' },
      { title: 'Expand and update max_freq', code: ['for right in range(len(s)):', '    freq[s[right]] = freq.get(s[right], 0) + 1', '    max_freq = max(max_freq, freq[s[right]])'], note: 'max_freq tracks the dominant character count.' },
      { title: 'Shrink if window is invalid', code: ['    if (right - left + 1) - max_freq > k:', '        freq[s[left]] -= 1', '        left += 1'], note: 'Window - max_freq = replacements needed. If > k, slide left.' },
    ],
  },

  // ── Binary Search ──────────────────────────────────────────────
  '704': {
    approach: 'Binary Search', time: 'O(log n)', space: 'O(1)',
    steps: [
      { title: 'Define search boundaries', code: ['left, right = 0, len(nums) - 1'], note: 'Search space is [left, right] inclusive.' },
      { title: 'Compute midpoint', code: ['while left <= right:', '    mid = (left + right) // 2'], note: 'Integer division avoids overflow.' },
      { title: 'Eliminate half the search space', code: ['    if nums[mid] == target: return mid', '    elif nums[mid] < target: left = mid + 1', '    else: right = mid - 1', 'return -1'], note: 'Comparison tells us which half to discard.' },
    ],
  },

  '153': {
    approach: 'Binary Search on Rotation', time: 'O(log n)', space: 'O(1)',
    steps: [
      { title: 'Binary search — check sorted half', code: ['left, right = 0, len(nums) - 1'], note: 'At least one half is always sorted.' },
      { title: 'Identify which half is sorted', code: ['while left < right:', '    mid = (left + right) // 2', '    if nums[mid] > nums[right]:', '        left = mid + 1  # min in right half', '    else:', '        right = mid   # min in left half (mid included)'], note: 'nums[mid] > nums[right] means rotation pivot is in right half.' },
      { title: 'Return the minimum', code: ['return nums[left]'], note: 'left converges to the minimum element.' },
    ],
  },

  '33': {
    approach: 'Binary Search on Rotation', time: 'O(log n)', space: 'O(1)',
    steps: [
      { title: 'Find mid, determine sorted side', code: ['left, right = 0, len(nums) - 1', 'while left <= right:', '    mid = (left + right) // 2', '    if nums[mid] == target: return mid'], note: 'One half is always sorted — use that to decide direction.' },
      { title: 'Left half is sorted', code: ['    if nums[left] <= nums[mid]:', '        if nums[left] <= target < nums[mid]:', '            right = mid - 1', '        else:', '            left = mid + 1'], note: 'Target in sorted range → go left. Otherwise → right.' },
      { title: 'Right half is sorted', code: ['    else:', '        if nums[mid] < target <= nums[right]:', '            left = mid + 1', '        else:', '            right = mid - 1'], note: 'Mirror logic for the right half.' },
    ],
  },

  // ── Stack ──────────────────────────────────────────────────────
  '20': {
    approach: 'Stack (Matching Brackets)', time: 'O(n)', space: 'O(n)',
    steps: [
      { title: 'Define bracket pairs', code: ['pairs = {")":"(", "}":"{", "]":"["}', 'stack = []'], note: 'Map each closing bracket to its opener.' },
      { title: 'Process each character', code: ['for c in s:', '    if c in "({[":', '        stack.append(c)', '    else:', '        if not stack or stack[-1] != pairs[c]:', '            return False', '        stack.pop()'], note: 'Open → push. Close → must match top of stack.' },
      { title: 'Stack must be empty at end', code: ['return len(stack) == 0'], note: 'Unmatched openers remain on the stack.' },
    ],
  },

  '739': {
    approach: 'Monotonic Stack (Decreasing)', time: 'O(n)', space: 'O(n)',
    steps: [
      { title: 'Initialize result and stack', code: ['res = [0] * len(temperatures)', 'stack = []  # stores indices'], note: 'Stack holds indices of temperatures waiting for a warmer day.' },
      { title: 'Process each day', code: ['for i, t in enumerate(temperatures):', '    while stack and temperatures[stack[-1]] < t:', '        j = stack.pop()', '        res[j] = i - j', '    stack.append(i)'], note: 'Pop when current temp is warmer — answer found for that index.' },
      { title: 'Return results', code: ['return res'], note: 'Remaining stack items got 0 (no warmer day found).' },
    ],
  },

  // ── Linked List ────────────────────────────────────────────────
  '206': {
    approach: 'Iterative Reversal', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Initialize prev pointer', code: ['prev = None', 'curr = head'], note: 'prev will become the new tail (None).' },
      { title: 'Reverse each link', code: ['while curr:', '    next_node = curr.next  # save next', '    curr.next = prev       # reverse link', '    prev = curr            # advance prev', '    curr = next_node      # advance curr'], note: 'Three-pointer dance: save → flip → advance.' },
      { title: 'Return new head', code: ['return prev'], note: 'prev points to the last node, now the new head.' },
    ],
  },

  '141': {
    approach: 'Fast & Slow Pointers', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Two pointers at different speeds', code: ['slow = fast = head'], note: 'Slow moves 1 step, fast moves 2 steps.' },
      { title: 'Advance and check for cycle', code: ['while fast and fast.next:', '    slow = slow.next', '    fast = fast.next.next', '    if slow == fast:', '        return True  # met inside cycle'], note: 'If a cycle exists, fast will lap slow and they will meet.' },
      { title: 'No cycle found', code: ['return False'], note: 'fast reached None — list has a proper tail.' },
    ],
  },

  // ── Hash Map ───────────────────────────────────────────────────
  '1': {
    approach: 'Hash Map (One Pass)', time: 'O(n)', space: 'O(n)',
    steps: [
      { title: 'Initialize complement map', code: ['seen = {}  # val → index'], note: 'Stores values we\'ve seen and their indices.' },
      { title: 'Check complement at each step', code: ['for i, num in enumerate(nums):', '    complement = target - num', '    if complement in seen:', '        return [seen[complement], i]'], note: 'If the complement exists, we\'re done instantly.' },
      { title: 'Store current value', code: ['    seen[num] = i', 'return []'], note: 'Future numbers can look us up as their complement.' },
    ],
  },

  '242': {
    approach: 'Frequency Count', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Early exit on length mismatch', code: ['if len(s) != len(t): return False'], note: 'Anagrams must have same length.' },
      { title: 'Count character frequencies', code: ['count = [0] * 26', 'for c in s: count[ord(c) - ord("a")] += 1', 'for c in t: count[ord(c) - ord("a")] -= 1'], note: 'Increment for s, decrement for t.' },
      { title: 'All counts must be zero', code: ['return all(x == 0 for x in count)'], note: 'Any non-zero means a character count mismatch.' },
    ],
  },

  // ── Dynamic Programming ────────────────────────────────────────
  '70': {
    approach: 'DP (Fibonacci-style)', time: 'O(n)', space: 'O(1)',
    steps: [
      { title: 'Base cases', code: ['if n <= 2: return n'], note: '1 step → 1 way. 2 steps → 2 ways.' },
      { title: 'Build up with rolling variables', code: ['a, b = 1, 2', 'for _ in range(3, n + 1):', '    a, b = b, a + b'], note: 'ways[i] = ways[i-1] + ways[i-2]' },
      { title: 'Return answer', code: ['return b'], note: 'b holds ways to reach step n.' },
    ],
  },

  '322': {
    approach: 'DP (Bottom-up)', time: 'O(n·m)', space: 'O(n)',
    steps: [
      { title: 'Initialize DP table', code: ['dp = [float("inf")] * (amount + 1)', 'dp[0] = 0'], note: 'dp[i] = min coins to make amount i. Base: 0 coins for amount 0.' },
      { title: 'Fill DP for each amount', code: ['for amt in range(1, amount + 1):', '    for coin in coins:', '        if coin <= amt:', '            dp[amt] = min(dp[amt], dp[amt - coin] + 1)'], note: 'Try every coin — pick the one giving minimum count.' },
      { title: 'Return result', code: ['return dp[amount] if dp[amount] != float("inf") else -1'], note: 'Infinity means amount is unreachable.' },
    ],
  },

  // ── Trees ──────────────────────────────────────────────────────
  '104': {
    approach: 'DFS (Recursive)', time: 'O(n)', space: 'O(h)',
    steps: [
      { title: 'Base case: empty node', code: ['if not root: return 0'], note: 'Null node contributes depth 0.' },
      { title: 'Recurse on both children', code: ['left  = maxDepth(root.left)', 'right = maxDepth(root.right)'], note: 'Get depth of each subtree.' },
      { title: 'Return deeper side + 1', code: ['return max(left, right) + 1'], note: '+1 for the current node itself.' },
    ],
  },

  '226': {
    approach: 'DFS (Recursive)', time: 'O(n)', space: 'O(h)',
    steps: [
      { title: 'Base case', code: ['if not root: return None'], note: 'Empty tree — nothing to invert.' },
      { title: 'Swap children', code: ['root.left, root.right = root.right, root.left'], note: 'Swap at every node.' },
      { title: 'Recurse into both subtrees', code: ['invertTree(root.left)', 'invertTree(root.right)', 'return root'], note: 'Process all nodes in the tree.' },
    ],
  },

  // ── Graph ──────────────────────────────────────────────────────
  '200': {
    approach: 'DFS / Flood Fill', time: 'O(m·n)', space: 'O(m·n)',
    steps: [
      { title: 'DFS to sink an island', code: ['def dfs(r, c):', '    if r<0 or r>=rows or c<0 or c>=cols:', '        return', '    if grid[r][c] != "1": return', '    grid[r][c] = "0"  # mark visited', '    for dr,dc in [(-1,0),(1,0),(0,-1),(0,1)]:', '        dfs(r+dr, c+dc)'], note: 'Flood fill: mark all connected land as visited water.' },
      { title: 'Count islands', code: ['count = 0', 'for r in range(rows):', '    for c in range(cols):', '        if grid[r][c] == "1":', '            dfs(r, c)', '            count += 1'], note: 'Each DFS call processes one complete island.' },
      { title: 'Return count', code: ['return count'], note: 'count = number of separate DFS launches.' },
    ],
  },

};

export const solutions: Record<string, Solution> = {
  ...solutionsFromDb,
  ...manualSolutions,
};
