/**
 * Algorithm-first playback: real pseudocode + worked traces for overlay typewriter.
 * Preferred over key-insight-only stubs from the DB sync.
 * Optional `dry` on each step drives the side-panel array / aux-structure snapshot.
 */
import type { Solution } from './solution-model';

export function looksLikeInsightOnlyStub(sol: Solution | null | undefined): boolean {
  if (!sol?.steps?.length) return true;
  for (const st of sol.steps) {
    const lines = st.code ?? [];
    if (lines.some((l) => !String(l).trimStart().startsWith('#'))) return false;
  }
  return true;
}

/** Match title + key insight to a curated walkthrough (used for complexity fallbacks too). */
export function inferFromKeywords(title: string, insight: string): Solution | null {
  const s = `${title} ${insight}`.toLowerCase();
  if (/two sum ii|sorted.*two sum/.test(s) || (/sorted/.test(s) && /target/.test(s) && /two pointer|left.*right|\blo\b.*\bhi\b/.test(s))) {
    return LC_COMPREHENSIVE['167'];
  }
  if (/most water|container with most water/.test(s)) {
    return LC_COMPREHENSIVE['11'];
  }
  if (/3sum|three sum|triplet/.test(s)) {
    return LC_COMPREHENSIVE['15'];
  }
  if (/valid palindrome/.test(s) || (/palindrome/.test(s) && /alnum|alphanumeric|non-alphanumeric/.test(s))) {
    return LC_COMPREHENSIVE['125'];
  }
  if (/move zeroes|move zeros|push.*zero/.test(s)) {
    return LC_COMPREHENSIVE['283'];
  }
  if (/longest substring without repeating/.test(s)) {
    return LC_COMPREHENSIVE['3'];
  }
  if (/minimum window substring|min window/.test(s)) {
    return LC_COMPREHENSIVE['76'];
  }
  if (/longest repeating character|replacement.*k|at most k/.test(s) && /substring|character/.test(s)) {
    return LC_COMPREHENSIVE['424'];
  }
  if (/binary search/.test(s) && !/rotat/.test(s) && !/peak|mountain/.test(s)) {
    return LC_COMPREHENSIVE['704'];
  }
  if (/search in rotated|rotated sorted array/.test(s) && /target/.test(s)) {
    return LC_COMPREHENSIVE['33'];
  }
  if (/find minimum in rotated|minimum in rotated/.test(s)) {
    return LC_COMPREHENSIVE['153'];
  }
  if (/valid parentheses|matching bracket/.test(s)) {
    return LC_COMPREHENSIVE['20'];
  }
  if (/daily temperatures|next warmer/.test(s)) {
    return LC_COMPREHENSIVE['739'];
  }
  if (/reverse linked list/.test(s)) {
    return LC_COMPREHENSIVE['206'];
  }
  if (/linked list cycle/.test(s) && !/cycle ii|detect cycle ii|entry/.test(s)) {
    return LC_COMPREHENSIVE['141'];
  }
  if (/two sum/.test(s) && !/two sum ii|sorted/.test(s) && (/hash|map|complement/.test(s) || /indices/.test(s))) {
    return LC_COMPREHENSIVE['1'];
  }
  if (/anagram/.test(s)) {
    return LC_COMPREHENSIVE['242'];
  }
  if (/climbing stair|70/.test(s)) {
    return LC_COMPREHENSIVE['70'];
  }
  if (/coin change|322/.test(s)) {
    return LC_COMPREHENSIVE['322'];
  }
  if (/max depth|104/.test(s) && /tree|binary/.test(s)) {
    return LC_COMPREHENSIVE['104'];
  }
  if (/invert binary tree|226/.test(s)) {
    return LC_COMPREHENSIVE['226'];
  }
  if (/number of islands|200/.test(s)) {
    return LC_COMPREHENSIVE['200'];
  }
  return null;
}

/** Prefer this over shorter manual entries when LC is known. */
export const LC_COMPREHENSIVE: Record<string, Solution> = {
  '167': {
    approach: 'Two pointers on sorted array',
    time: 'O(n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Problem & guarantee',
        code: [
          '# Given: numbers sorted ascending, exactly one solution exists.',
          '# Return 1-based indices (i+1, j+1) where numbers[i]+numbers[j]==target.',
          '# Brute force O(n²) — use two pointers O(n).',
        ],
        note: 'Sorted order is what makes the squeeze toward target safe.',
        dry: {
          caption: 'Input · sorted numbers[] + target',
          cells: [{ v: 2 }, { v: 7 }, { v: 11 }, { v: 15 }],
          vars: [{ k: 'target', v: 9 }],
        },
      },
      {
        title: 'Concrete example',
        code: [
          '# Example trace (LeetCode classic):',
          'numbers = [2, 7, 11, 15]',
          'target = 9',
          '# Need pair summing to 9 → 2 + 7.',
        ],
        note: 'We walk the same indices the code would visit.',
        dry: {
          caption: 'Same data — we will DRY-RUN indices',
          cells: [{ v: 2 }, { v: 7 }, { v: 11 }, { v: 15 }],
          vars: [
            { k: 'target', v: 9 },
            { k: 'want pair sums to', v: 9 },
          ],
        },
      },
      {
        title: 'Initialize pointers',
        code: ['left = 0                    # points to 2', 'right = len(numbers) - 1    # points to 15'],
        note: 'Start as wide as possible — smallest + largest candidate.',
        dry: {
          caption: 'Pointers · widest window',
          cells: [
            { v: 2, s: 'l', p: 'left=0' },
            { v: 7 },
            { v: 11 },
            { v: 15, s: 'r', p: 'right=3' },
          ],
          vars: [
            { k: 'left', v: 0 },
            { k: 'right', v: 3 },
            { k: 'target', v: 9 },
          ],
        },
      },
      {
        title: 'Iteration 1 — sum too large',
        code: [
          'curr = numbers[left] + numbers[right]',
          '         = 2 + 15 = 17',
          'target = 9',
          '17 > 9  →  shrink sum by moving right inward',
          'right -= 1   # now right points to 11',
        ],
        note: 'Only smaller values sit to the left of right; lowering right is the correct monotone move.',
        dry: {
          caption: 'Sum 2+15=17 > 9 → move right',
          cells: [
            { v: 2, s: 'l' },
            { v: 7 },
            { v: 11 },
            { v: 15, s: 'r' },
          ],
          vars: [
            { k: 'curr', v: 17, hi: true },
            { k: 'target', v: 9 },
            { k: 'action', v: 'right -= 1' },
          ],
        },
      },
      {
        title: 'Iteration 2 — still large',
        code: [
          'curr = 2 + 11 = 13  (> 9)',
          'right -= 1   # now right points to 7',
        ],
        note: 'Still above target — keep shrinking from the heavy side.',
        dry: {
          caption: 'Sum 2+11=13 > 9 → move right again',
          cells: [
            { v: 2, s: 'l' },
            { v: 7 },
            { v: 11, s: 'r' },
            { v: 15, s: 'x' },
          ],
          vars: [
            { k: 'curr', v: 13, hi: true },
            { k: 'right', v: 2, hi: true },
          ],
        },
      },
      {
        title: 'Iteration 3 — match',
        code: [
          'curr = 2 + 7 = 9',
          'curr == target  →  FOUND',
          'return [left + 1, right + 1]  # == [1, 2]',
        ],
        note: 'Return is 1-indexed as the problem requires.',
        dry: {
          caption: 'Sum hits target → answer indices',
          cells: [
            { v: 2, s: 'ok', p: 'idx 1' },
            { v: 7, s: 'ok', p: 'idx 2' },
            { v: 11, s: 'x' },
            { v: 15, s: 'x' },
          ],
          vars: [
            { k: 'curr', v: 9, hi: true },
            { k: 'return', v: '[1, 2]', hi: true },
          ],
        },
      },
      {
        title: 'Full algorithm (loop form)',
        code: [
          'def twoSum(numbers, target):',
          '    left, right = 0, len(numbers) - 1',
          '    while left < right:',
          '        curr = numbers[left] + numbers[right]',
          '        if curr == target:',
          '            return [left + 1, right + 1]',
          '        if curr < target:',
          '            left += 1',
          '        else:',
          '            right -= 1',
        ],
        note: 'curr < target → need bigger sum → move left up. curr > target → move right down.',
        dry: {
          caption: 'Final state (matches trace)',
          cells: [
            { v: 2, s: 'ok' },
            { v: 7, s: 'ok' },
            { v: 11, s: 'x' },
            { v: 15, s: 'x' },
          ],
          vars: [{ k: 'loop', v: 'until match' }],
        },
      },
      {
        title: 'Invariant (what you say in interview)',
        code: [
          '# Invariant: if answer uses indices i ≤ j, we never skip past them.',
          '# Because array is sorted, discarding the smaller end when sum < target',
          '# cannot remove the only pair that could still reach target — symmetric for sum > target.',
        ],
        note: 'This is the formal proof the greedy pointer moves are safe.',
        dry: {
          caption: 'Invariant · trust region',
          auxTitle: 'Between left & right',
          auxLines: [
            'Answer pair always stays inside',
            'while sum guides pointer moves.',
            '',
            'Sorted ⇒ moves are monotone;',
            'cannot skip the unique solution.',
          ],
        },
      },
    ],
  },

  '11': {
    approach: 'Two pointers · container area',
    time: 'O(n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Objective',
        code: [
          '# Maximize area = min(h[l], h[r]) * (r - l)',
          '# Classic heights (sample): [1,8,6,2,5,4,8,3,7]',
        ],
        note: 'Width times shorter bar — taller inner bars cannot compensate width loss unless min height grows.',
        dry: {
          caption: 'height[] · indices 0…8',
          cells: [
            { v: 1 }, { v: 8 }, { v: 6 }, { v: 2 }, { v: 5 },
            { v: 4 }, { v: 8 }, { v: 3 }, { v: 7 },
          ],
          vars: [{ k: 'goal', v: 'max area' }],
        },
      },
      {
        title: 'Start widest',
        code: ['l, r = 0, len(height) - 1', 'best = 0'],
        note: 'Width is maximal at the ends; we only improve by trading width for maybe taller min.',
        dry: {
          caption: 'Pointers at both ends',
          cells: [
            { v: 1, s: 'l', p: 'l=0' },
            { v: 8 }, { v: 6 }, { v: 2 }, { v: 5 },
            { v: 4 }, { v: 8 }, { v: 3 },
            { v: 7, s: 'r', p: 'r=8' },
          ],
          vars: [
            { k: 'width', v: '8' },
            { k: 'min-h', v: 'min(1,7)=1' },
          ],
        },
      },
      {
        title: 'Trace · step A',
        code: [
          'area = min(1, 7) * (8 - 0) = 1 * 8 = 8',
          'best = max(0, 8) = 8',
          'height[l]=1 < height[r]=7 → move l += 1  # shorter wall limits us',
        ],
        note: 'Moving the taller right wall would only shrink width with min still ≤ 7.',
        dry: {
          caption: 'Area = min side × width',
          cells: [
            { v: 1, s: 'l' },
            { v: 8 }, { v: 6 }, { v: 2 }, { v: 5 },
            { v: 4 }, { v: 8 }, { v: 3 },
            { v: 7, s: 'r' },
          ],
          vars: [
            { k: 'area', v: '8', hi: true },
            { k: 'move', v: 'l+=1' },
          ],
        },
      },
      {
        title: 'Greedy rule (proof sketch)',
        code: [
          '# If h[l] < h[r], any pair (l, k) with k < r has width ≤ r-l but min ≤ h[l].',
          '# So keeping l while moving r inward cannot beat moving l — discard l.',
          '# Symmetric when h[r] is shorter.',
        ],
        note: 'You always advance the index with the shorter bar.',
        dry: {
          caption: 'Why move the shorter wall',
          auxTitle: 'If h[l] < h[r]',
          auxLines: [
            'Keeping l fixes min ≤ h[l].',
            'Shrinking width cannot raise min past h[l].',
            'So discard l — try taller left wall.',
          ],
        },
      },
      {
        title: 'Loop skeleton',
        code: [
          'while l < r:',
          '    best = max(best, min(h[l], h[r]) * (r - l))',
          '    if h[l] < h[r]:',
          '        l += 1',
          '    else:',
          '        r -= 1',
          'return best',
        ],
        note: 'Tie h[l]==h[r]: either side is safe; conventionally pick one branch.',
        dry: {
          caption: 'Loop invariant',
          auxTitle: 'Each step',
          auxLines: [
            'best = best area seen so far',
            'advance shorter index',
            'until l meets r',
          ],
        },
      },
    ],
  },

  '15': {
    approach: 'Sort + fix i + two pointers',
    time: 'O(n²)',
    space: 'O(1) extra (sort in-place)',
    steps: [
      {
        title: 'Reduce 3Sum to many 2Sum',
        code: [
          '# Want distinct triplets with nums[a]+nums[b]+nums[c]=0.',
          '# Sort nums → for each i, find pairs in (i+1..end) summing to -nums[i].',
        ],
        note: 'Sorting enables the O(n) two-pointer inner pass per outer i.',
        dry: {
          caption: 'Pattern · anchor i + 2Sum on suffix',
          auxTitle: 'Structure',
          auxLines: ['sort nums → O(n²) with two pointers'],
        },
      },
      {
        title: 'Tiny example',
        code: [
          '# nums = [-1, 0, 1, 2, -1, -4] → sorted: [-4,-1,-1,0,1,2]',
          '# i at first -1: need two-sum to +1 from subarray [ -1, 0, 1, 2 ]',
        ],
        note: 'Duplicates must be skipped at each layer to avoid repeated triplets.',
        dry: {
          caption: 'Sorted example array',
          cells: [{ v: -4 }, { v: -1 }, { v: -1 }, { v: 0 }, { v: 1 }, { v: 2 }],
          vars: [{ k: 'sum target', v: '0' }],
        },
      },
      {
        title: 'Outer loop',
        code: [
          'nums.sort()',
          'res = []',
          'for i in range(len(nums) - 2):',
          '    if i > 0 and nums[i] == nums[i-1]:',
          '        continue   # skip duplicate anchor',
          '    need = -nums[i]',
          '    left, right = i + 1, len(nums) - 1',
        ],
        note: 'need is the Two Sum II target on the suffix.',
        dry: {
          caption: 'Anchor i · inner window',
          cells: [{ v: -4 }, { v: -1, s: 'm', p: 'i' }, { v: -1 }, { v: 0 }, { v: 1 }, { v: 2 }],
          vars: [
            { k: 'need', v: '-(-1)=1', hi: true },
            { k: 'left', v: 'i+1' },
          ],
        },
      },
      {
        title: 'Inner two-pointer pattern',
        code: [
          '    while left < right:',
          '        s = nums[left] + nums[right]',
          '        if s == need:',
          '            res.append([nums[i], nums[left], nums[right]])',
          '            left += 1; right -= 1',
          '            while left < right and nums[left]==nums[left-1]: left += 1',
          '            while left < right and nums[right]==nums[right+1]: right -= 1',
          '        elif s < need:',
          '            left += 1',
          '        else:',
          '            right -= 1',
        ],
        note: 'After recording a hit, squeeze both pointers past equal values.',
        dry: {
          caption: 'Inner pair squeezes toward need',
          auxTitle: 'Invariant',
          auxLines: ['left/right only move inward', 'skip dup triplets after each hit'],
        },
      },
    ],
  },

  '125': {
    approach: 'Two pointers + normalize',
    time: 'O(n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Rules',
        code: [
          '# Keep only alphanumeric; compare case-insensitive.',
          '# Example string (conceptual): "A man, a plan, a canal: Panama"',
        ],
        note: 'Spaces/punctuation are invisible to comparison.',
        dry: {
          caption: 'Characters vs ignored symbols',
          cells: [{ v: 'a' }, { v: ',' }, { v: 'b' }, { v: ',' }, { v: 'a' }],
          vars: [{ k: 'compare', v: 'only bold letters' }],
        },
      },
      {
        title: 'Algorithm',
        code: [
          'left, right = 0, len(s) - 1',
          'while left < right:',
          '    while left < right and not s[left].isalnum():',
          '        left += 1',
          '    while left < right and not s[right].isalnum():',
          '        right -= 1',
          '    if s[left].lower() != s[right].lower():',
          '        return False',
          '    left += 1; right -= 1',
          'return True',
        ],
        note: 'Inner whiles skip junk; outer loop compares the next real letters.',
        dry: {
          caption: 'Two indices scan inward',
          cells: [
            { v: 'a', s: 'l', p: 'left' },
            { v: ',' },
            { v: 'b', s: 'm' },
            { v: ',' },
            { v: 'a', s: 'r', p: 'right' },
          ],
          vars: [{ k: 'after skips', v: 'meet on b' }],
        },
      },
      {
        title: 'Mini trace',
        code: [
          '# "ab_a" style: after skips, compare symmetric letters.',
          '# Mismatch at first differing pair → immediate False.',
        ],
        note: 'Single middle character is automatically OK.',
        dry: {
          caption: 'Valid palindrome path',
          auxTitle: 'Outcome',
          auxLines: ['All symmetric pairs match → True', 'one bad pair → False'],
        },
      },
    ],
  },

  '283': {
    approach: 'Partition (stable via swap)',
    time: 'O(n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Goal',
        code: ['# Move all non-zeros to the front preserving order; fill tail with 0.'],
        note: 'Classic “slow writer / fast reader” pattern.',
        dry: {
          caption: 'Two roles',
          auxTitle: 'Pointers',
          auxLines: ['write → next slot to fill', 'read → scans entire array'],
        },
      },
      {
        title: 'Example',
        code: ['# nums = [0,1,0,3,12] → want [1,3,12,0,0]'],
        note: 'Watch write pointer claim slots as fast scans.',
        dry: {
          caption: 'Start state',
          cells: [{ v: 0 }, { v: 1 }, { v: 0 }, { v: 3 }, { v: 12 }],
          vars: [
            { k: 'write', v: 0 },
            { k: 'read', v: 0 },
          ],
        },
      },
      {
        title: 'Implementation',
        code: [
          'write = 0',
          'for read in range(len(nums)):',
          '    if nums[read] != 0:',
          '        nums[write], nums[read] = nums[read], nums[write]',
          '        write += 1',
        ],
        note: 'Swap pulls non-zero forward; zeros naturally drift right.',
        dry: {
          caption: 'After algorithm · conceptual end',
          cells: [{ v: 1 }, { v: 3 }, { v: 12 }, { v: 0 }, { v: 0 }],
          vars: [{ k: 'nonzeros', v: 'packed left' }],
        },
      },
    ],
  },

  '3': {
    approach: 'Sliding window + set',
    time: 'O(n)',
    space: 'O(min(n, |Σ|))',
    steps: [
      {
        title: 'Idea',
        code: [
          '# Longest substring without repeat = longest window with all unique chars.',
          '# s = "abcabcbb" → answer "abc" length 3.',
        ],
        note: 'Expand right; when duplicate appears, shrink left until duplicate evicted.',
        dry: {
          caption: 'Window on string',
          cells: [
            { v: 'a', s: 'l' },
            { v: 'b' },
            { v: 'c', s: 'r' },
          ],
          vars: [{ k: 'window', v: '"abc"' }],
        },
      },
      {
        title: 'Variables',
        code: ['seen = set()', 'left = 0', 'best = 0'],
        note: 'seen holds chars in the current [left, right] window.',
        dry: {
          caption: 'DS · character set',
          auxTitle: 'seen',
          auxLines: ['mutable set of chars', 'in current [left, right]'],
        },
      },
      {
        title: 'Main loop',
        code: [
          'for right in range(len(s)):',
          '    while s[right] in seen:',
          '        seen.remove(s[left])',
          '        left += 1',
          '    seen.add(s[right])',
          '    best = max(best, right - left + 1)',
          'return best',
        ],
        note: 'Each index enters/exits window at most once → amortized O(n).',
        dry: {
          caption: 'Shrink until window unique',
          auxTitle: 'Loop body',
          auxLines: ['advance right every iter', 'pop left while duplicate'],
        },
      },
    ],
  },

  '76': {
    approach: 'Sliding window + need/have counts',
    time: 'O(|s|+|t|)',
    space: 'O(|Σ|)',
    steps: [
      {
        title: 'Rephrase',
        code: [
          '# Cover all chars of t with enough multiplicity inside a window of s.',
          '# Minimize window length.',
        ],
        note: 'Track how many distinct required chars are “fully satisfied”.',
        dry: {
          caption: 'Sliding window over s',
          auxTitle: 'Goal',
          auxLines: ['cover multiset of t', 'shortest valid [l,r]'],
        },
      },
      {
        title: 'State machine',
        code: [
          'need = Counter(t)   # required multiplicities',
          'window = Counter()',
          'formed = 0          # how many unique chars hit their quota',
          'required = len(need)',
        ],
        note: 'When window[c] reaches need[c], increment formed once.',
        dry: {
          caption: 'Counters',
          auxTitle: 'Maps',
          auxLines: ['need[c] required count', 'window[c] in current slice', 'formed satisified keys'],
        },
      },
      {
        title: 'Expand / contract',
        code: [
          'for r, ch in enumerate(s):',
          '    window[ch] += 1',
          '    if ch in need and window[ch] == need[ch]:',
          '        formed += 1',
          '    while formed == required:',
          '        # record best window [l, r]',
          '        shrink from left updating formed/window',
        ],
        note: 'Contract while still valid to nail minimum length.',
        dry: {
          caption: 'Grow r · tighten l',
          auxTitle: 'Invariant',
          auxLines: ['formed == required ⇒ window valid', 'then minimize width'],
        },
      },
    ],
  },

  '424': {
    approach: 'Window where (len - maxFreq) ≤ k',
    time: 'O(n)',
    space: 'O(1) alphabet',
    steps: [
      {
        title: 'Rephrase longest repeating with k edits',
        code: [
          '# In a window, replacements needed = window_len - max_char_frequency.',
          '# Valid iff that quantity ≤ k.',
        ],
        note: 'You may replace any positions not aligned with the dominant char.',
        dry: {
          caption: 'Window validity',
          auxTitle: 'Formula',
          auxLines: ['replacements = len(window) - maxFreq', 'need replacements ≤ k'],
        },
      },
      {
        title: 'Loop',
        code: [
          'for right in range(len(s)):',
          '    update freq[s[right]]; max_freq = max(max_freq, freq[s[right]])',
          '    if (right - left + 1) - max_freq > k:',
          '        freq[s[left]] -= 1',
          '        left += 1',
          '    best = max(best, right - left + 1)',
        ],
        note: 'max_freq is historical max — window validity uses current len minus it.',
        dry: {
          caption: 'Shrink when invalid',
          auxTitle: 'freq map',
          auxLines: ['counts chars in window', 'slide left removes char'],
        },
      },
    ],
  },

  '704': {
    approach: 'Classic binary search',
    time: 'O(log n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Example array',
        code: ['nums = [-1,0,3,5,9,12]', 'target = 9', '# expect index 4'],
        note: 'Invariant: if target exists, it stays inside [left, right].',
        dry: {
          caption: 'Sorted nums[] · hunt target 9',
          cells: [{ v: -1 }, { v: 0 }, { v: 3 }, { v: 5 }, { v: 9 }, { v: 12 }],
          vars: [
            { k: 'target', v: 9 },
            { k: 'indices', v: '0…5' },
          ],
        },
      },
      {
        title: 'Iterations',
        code: [
          'lo, hi = 0, len(nums)-1',
          'mid=2 → nums[2]=3 < 9 → lo=3',
          'mid=4 → nums[4]=9 → return 4',
        ],
        note: 'Each comparison removes half the interval.',
        dry: {
          caption: 'After first mid · discard left half',
          cells: [
            { v: -1, s: 'x' },
            { v: 0, s: 'x' },
            { v: 3, s: 'm', p: 'mid=2' },
            { v: 5, s: 'n', p: '↑ lo=3' },
            { v: 9 },
            { v: 12, p: '↑ hi=5' },
          ],
          vars: [
            { k: 'nums[mid]', v: 3 },
            { k: '9 > 3', v: 'go right' },
          ],
        },
      },
      {
        title: 'Standard code',
        code: [
          'while lo <= hi:',
          '    mid = (lo + hi) // 2',
          '    if nums[mid] == target: return mid',
          '    if nums[mid] < target: lo = mid + 1',
          '    else: hi = mid - 1',
          'return -1',
        ],
        note: 'Use mid-1 / mid+1 carefully to avoid infinite loops.',
        dry: {
          caption: 'Hit · index 4',
          cells: [
            { v: -1, s: 'x' },
            { v: 0, s: 'x' },
            { v: 3, s: 'x' },
            { v: 5, s: 'x' },
            { v: 9, s: 'ok', p: 'found' },
            { v: 12, s: 'x' },
          ],
          vars: [{ k: 'return', v: '4', hi: true }],
        },
      },
    ],
  },

  '153': {
    approach: 'Binary search minimum in rotated sorted',
    time: 'O(log n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Observation',
        code: [
          '# nums has two monotone pieces; minimum is the only valley.',
          '# Example: [3,4,5,1,2] → min is 1 at index 3.',
        ],
        note: 'Compare mid with right edge to know which half contains min.',
        dry: {
          caption: 'Rotated sorted · find valley',
          cells: [{ v: 3 }, { v: 4 }, { v: 5 }, { v: 1 }, { v: 2 }],
          vars: [{ k: 'min', v: '1 @ idx 3' }],
        },
      },
      {
        title: 'Rule',
        code: [
          'while left < right:',
          '    mid = (left + right) // 2',
          '    if nums[mid] > nums[right]:',
          '        left = mid + 1   # min in right chunk',
          '    else:',
          '        right = mid      # min at mid or left',
          'return nums[left]',
        ],
        note: 'nums[mid] > nums[right] means breakpoint strictly to the right of mid.',
        dry: {
          caption: 'Binary search on answer',
          auxTitle: 'Compare',
          auxLines: ['nums[mid] vs nums[right]', 'chooses which half still has min'],
        },
      },
    ],
  },

  '33': {
    approach: 'Binary search with rotation',
    time: 'O(log n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Core test',
        code: [
          '# One side of mid is always normally sorted.',
          '# Use that side to test whether target lies in its numeric range.',
          '# nums = [4,5,6,7,0,1,2], target = 0',
        ],
        note: 'Discard half like standard BS once you identify the sorted side.',
        dry: {
          caption: 'Rotated array + target',
          cells: [{ v: 4 }, { v: 5 }, { v: 6 }, { v: 7 }, { v: 0 }, { v: 1 }, { v: 2 }],
          vars: [{ k: 'target', v: 0 }],
        },
      },
      {
        title: 'Skeleton',
        code: [
          'while lo <= hi:',
          '    mid = (lo + hi) // 2',
          '    if nums[mid] == target: return mid',
          '    if nums[lo] <= nums[mid]:  # left side sorted',
          '        if nums[lo] <= target < nums[mid]: hi = mid - 1',
          '        else: lo = mid + 1',
          '    else:  # right side sorted',
          '        if nums[mid] < target <= nums[hi]: lo = mid + 1',
          '        else: hi = mid - 1',
          'return -1',
        ],
        note: 'Careful with inclusive inequalities — match your chosen boundary convention.',
        dry: {
          caption: 'Pick sorted half',
          auxTitle: 'Rule of thumb',
          auxLines: ['if left half sorted', '  check if target in [nums[lo], nums[mid])', 'else check right sorted range'],
        },
      },
    ],
  },

  '20': {
    approach: 'Stack of open brackets',
    time: 'O(n)',
    space: 'O(n)',
    steps: [
      {
        title: 'Mapping',
        code: ['pairs = {")":"(", "}":"{", "]":"["}', 'stack = []'],
        note: 'Closing bracket must match most recent unmatched opener.',
        dry: {
          caption: 'Data structure · LIFO stack',
          auxTitle: 'stack (bottom → top)',
          auxLines: ['[ ]', 'push opens, pop on valid close'],
        },
      },
      {
        title: 'Trace on "()[]{}"',
        code: [
          '# ( → push',
          '# ) → pop match',
          '# repeat; stack empty → True',
        ],
        note: 'Early fail if stack empty on close or mismatch.',
        dry: {
          caption: 'DRY RUN · string scan',
          cells: [
            { v: '(', s: 'l', p: 'read' },
            { v: ')' },
            { v: '[' },
            { v: ']' },
            { v: '{' },
            { v: '}' },
          ],
          auxTitle: 'stack after "("',
          auxLines: ['('],
        },
      },
      {
        title: 'Code',
        code: [
          'for c in s:',
          '    if c in "({[": stack.append(c)',
          '    else:',
          '        if not stack or stack[-1] != pairs[c]: return False',
          '        stack.pop()',
          'return not stack',
        ],
        note: 'Order of checks matters for malformed strings.',
        dry: {
          caption: 'Valid finish · stack empty',
          auxTitle: 'stack',
          auxLines: ['[ ]  ← all matched'],
        },
      },
    ],
  },

  '739': {
    approach: 'Monotonic decreasing stack of indices',
    time: 'O(n)',
    space: 'O(n)',
    steps: [
      {
        title: 'Question',
        code: ['# For each day, how many days until a warmer temperature?', '# Output 0 if none.'],
        note: 'Stack stores candidates still waiting for their “next greater”.',
        dry: {
          caption: 'Next greater element · indices',
          auxTitle: 'Monotonic stack',
          auxLines: ['stores indices with decreasing T', 'warmer day resolves backlog'],
        },
      },
      {
        title: 'Example pulse',
        code: [
          'T = [73,74,75,71,69,72,76,73]',
          '# When 72 sees 76, resolve pops for days still colder.',
        ],
        note: 'While current T beats stack top index value, pop and fill answer.',
        dry: {
          caption: 'Temperature strip',
          cells: [{ v: 73 }, { v: 74 }, { v: 75 }, { v: 71 }, { v: 69 }, { v: 72 }, { v: 76 }],
          vars: [{ k: '76 resolves', v: 'cooler days before it' }],
        },
      },
      {
        title: 'Algorithm',
        code: [
          'ans = [0]*len(T); stack = []',
          'for i, t in enumerate(T):',
          '    while stack and T[stack[-1]] < t:',
          '        j = stack.pop()',
          '        ans[j] = i - j',
          '    stack.append(i)',
        ],
        note: 'Each index pushed once, popped once.',
        dry: {
          caption: 'Per-day processing',
          auxTitle: 'stack (indices)',
          auxLines: ['push i each step', 'pop while T[i] > T[stack.top]'],
        },
      },
    ],
  },

  '206': {
    approach: 'Iterative reversal',
    time: 'O(n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Picture',
        code: ['# 1 → 2 → 3 → ∅   becomes   ∅ ← 1 ← 2 ← 3'],
        note: 'Flip next pointers while marching forward.',
        dry: {
          caption: 'Linked list reversal',
          auxTitle: 'Before → After',
          auxLines: ['1→2→3→∅', '∅←1←2←3'],
        },
      },
      {
        title: 'Pointers',
        code: [
          'prev = None',
          'curr = head',
          'while curr:',
          '    nxt = curr.next',
          '    curr.next = prev',
          '    prev = curr',
          '    curr = nxt',
          'return prev',
        ],
        note: 'prev lands on new head when curr falls off end.',
        dry: {
          caption: 'Three-pointer dance',
          cells: [{ v: 1 }, { v: 2 }, { v: 3 }],
          vars: [
            { k: 'prev', v: 'lags' },
            { k: 'curr', v: 'visit', hi: true },
            { k: 'nxt', v: 'saved' },
          ],
          auxTitle: 'Each iteration',
          auxLines: ['save nxt', 'curr.next = prev', 'advance prev,curr'],
        },
      },
    ],
  },

  '141': {
    approach: 'Floyd cycle detection',
    time: 'O(n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Movement',
        code: ['slow moves 1 node/step', 'fast moves 2 nodes/step'],
        note: 'If list ends (None), no cycle. If cycle, fast eventually laps slow.',
        dry: {
          caption: 'Floyd’s idea',
          auxTitle: 'Pointers',
          auxLines: ['slow: +1 per tick', 'fast: +2 per tick', 'meet inside cycle ⇒ cycle'],
        },
      },
      {
        title: 'Code',
        code: [
          'slow = fast = head',
          'while fast and fast.next:',
          '    slow = slow.next',
          '    fast = fast.next.next',
          '    if slow is fast:',
          '        return True',
          'return False',
        ],
        note: 'Do not advance fast past None — guard fast.next.',
        dry: {
          caption: 'Termination',
          auxTitle: 'Cases',
          auxLines: ['fast hits None → acyclic', 'slow == fast → cyclic'],
        },
      },
    ],
  },

  '1': {
    approach: 'Hash map complement',
    time: 'O(n)',
    space: 'O(n)',
    steps: [
      {
        title: 'Example',
        code: ['nums = [2,7,11,15], target = 9', '# need indices (0,1) because 2+7=9'],
        note: 'Store value→index as you sweep once.',
        dry: {
          caption: 'nums[] · need pair → sum 9',
          cells: [{ v: 2 }, { v: 7 }, { v: 11 }, { v: 15 }],
          vars: [{ k: 'target', v: 9 }],
          auxTitle: 'hash map seen (value→idx)',
          auxLines: ['(empty before scan)'],
        },
      },
      {
        title: 'Algorithm',
        code: [
          'seen = {}',
          'for i, x in enumerate(nums):',
          '    y = target - x',
          '    if y in seen:',
          '        return [seen[y], i]',
          '    seen[x] = i',
        ],
        note: 'Check complement before inserting current to avoid using same element twice.',
        dry: {
          caption: 'At i=1 · found complement 2',
          cells: [
            { v: 2, s: 'ok', p: 'idx0' },
            { v: 7, s: 'l', p: 'i=1' },
            { v: 11 },
            { v: 15 },
          ],
          vars: [
            { k: 'need', v: '9-7=2', hi: true },
            { k: '2 in seen?', v: 'yes → [0,1]' },
          ],
          auxTitle: 'seen map',
          auxLines: ['2 → 0', '(7 not stored yet when hit)'],
        },
      },
    ],
  },

  '242': {
    approach: 'Frequency balance',
    time: 'O(n)',
    space: 'O(1) for lowercase English',
    steps: [
      {
        title: 'Principle',
        code: ['# Same multiset of letters ⇔ anagram.', '# Use length check + 26 counters (if lowercase).'],
        note: 'Sort also works O(n log n) but counting is linear.',
        dry: {
          caption: 'Multiset equality',
          auxTitle: 'Data',
          auxLines: ['count[s] must match count[t]', 'early exit if len differs'],
        },
      },
      {
        title: 'Implementation sketch',
        code: [
          'if len(s) != len(t): return False',
          'cnt = [0]*26',
          'for a,b in zip(s,t):',
          '    cnt[ord(a)-97] += 1',
          '    cnt[ord(b)-97] -= 1',
          'return all(x==0 for x in cnt)',
        ],
        note: 'Extend to Unicode with Counter dict.',
        dry: {
          caption: 'Parallel scan',
          cells: [{ v: 'a' }, { v: 'n' }, { v: 'a' }, { v: 'g' }],
          vars: [{ k: 'zip(s,t)', v: 'pair chars' }],
        },
      },
    ],
  },

  '70': {
    approach: 'Fibonacci recurrence',
    time: 'O(n)',
    space: 'O(1)',
    steps: [
      {
        title: 'Recurrence',
        code: ['ways[n] = ways[n-1] + ways[n-2]', '# Last hop either 1 or 2 steps.'],
        note: 'Base: ways[1]=1, ways[2]=2.',
        dry: {
          caption: 'DP state',
          auxTitle: 'Fibonacci-style',
          auxLines: ['f(n)=f(n-1)+f(n-2)', 'paths ending with step 1 or 2'],
        },
      },
      {
        title: 'Rolling DP',
        code: ['a, b = 1, 2', 'for _ in range(3, n+1):', '    a, b = b, a+b', 'return b'],
        note: 'Only previous two values matter.',
        dry: {
          caption: 'O(1) memory',
          cells: [{ v: '…' }, { v: 'a' }, { v: 'b' }],
          vars: [
            { k: 'a', v: 'ways[k-2]' },
            { k: 'b', v: 'ways[k-1]', hi: true },
          ],
          auxLines: ['roll forward each n'],
        },
      },
    ],
  },

  '322': {
    approach: 'Unbounded knapsack / coin DP',
    time: 'O(amount · |coins|)',
    space: 'O(amount)',
    steps: [
      {
        title: 'State',
        code: ['dp[x] = minimum coins to form sum x', 'dp[0] = 0', 'others start ∞'],
        note: 'Try every coin that fits — transition dp[x] = min(dp[x], dp[x-c]+1).',
        dry: {
          caption: '1D DP table',
          auxTitle: 'dp[i]',
          auxLines: ['min coins to amount i', 'base dp[0]=0'],
        },
      },
      {
        title: 'Example mental model',
        code: ['coins = [1,3,4], amount = 6', '# best: two 3-coin pieces → 2 coins'],
        note: 'Outer loop on amount ascending guarantees subproblems solved.',
        dry: {
          caption: 'Concrete coins',
          cells: [{ v: 1 }, { v: 3 }, { v: 4 }],
          vars: [{ k: 'amount', v: 6 }, { k: 'answer', v: '2 coins (3+3)' }],
        },
      },
      {
        title: 'Loops',
        code: [
          'for x in range(1, amount+1):',
          '    for c in coins:',
          '        if c <= x:',
          '            dp[x] = min(dp[x], dp[x-c] + 1)',
          'return dp[amount] if dp[amount] < inf else -1',
        ],
        note: 'Infinity means unreachable sum.',
        dry: {
          caption: 'Relax edges',
          auxTitle: 'Transition',
          auxLines: ['for each coin c ≤ x', 'dp[x] = min(dp[x], dp[x-c]+1)'],
        },
      },
    ],
  },

  '104': {
    approach: 'DFS depth',
    time: 'O(n)',
    space: 'O(h)',
    steps: [
      {
        title: 'Definition',
        code: ['# Depth = longest root-to-leaf path length in edges/nodes per problem statement.'],
        note: 'LeetCode: max depth = number of nodes along longest path.',
        dry: {
          caption: 'Tree recursion',
          auxTitle: 'Metric',
          auxLines: ['depth(root)=0 if null', 'else 1+max(child depths)'],
        },
      },
      {
        title: 'Recursion',
        code: [
          'def maxDepth(root):',
          '    if not root: return 0',
          '    return 1 + max(maxDepth(root.left), maxDepth(root.right))',
        ],
        note: 'Post-order: need children before combining.',
        dry: {
          caption: 'Call stack',
          auxTitle: 'DFS flow',
          auxLines: ['solve subtrees first', 'combine at root (+1)'],
        },
      },
    ],
  },

  '226': {
    approach: 'Swap children recursively / iteratively',
    time: 'O(n)',
    space: 'O(h)',
    steps: [
      {
        title: 'Operation',
        code: ['# Swap left/right child pointers at every node; recurse.'],
        note: 'Preorder: swap before diving.',
        dry: {
          caption: 'Local operation',
          auxTitle: 'Per node',
          auxLines: ['swap(left, right)', 'then recurse both children'],
        },
      },
      {
        title: 'Code',
        code: [
          'def invert(root):',
          '    if not root: return None',
          '    root.left, root.right = root.right, root.left',
          '    invert(root.left); invert(root.right)',
          '    return root',
        ],
        note: 'Iterative version uses queue/stack similarly.',
        dry: {
          caption: 'Preorder traversal',
          auxTitle: 'Order',
          auxLines: ['visit → swap → left → right'],
        },
      },
    ],
  },

  '200': {
    approach: 'DFS/BFS flood fill',
    time: 'O(m·n)',
    space: 'O(m·n) recursion/stack',
    steps: [
      {
        title: 'Idea',
        code: ['# Each "1" patch is an island; sink visited cells to avoid recounting.', '# Grid sample:', '1 1 0', '1 0 1', '0 1 0'],
        note: 'Count how many times you launch DFS from unseen land.',
        dry: {
          caption: 'Grid · islands',
          auxTitle: 'ASCII',
          auxLines: ['1 1 0', '1 0 1', '0 1 0', '', 'each DFS floods one island'],
        },
      },
      {
        title: 'DFS cell',
        code: [
          'def dfs(r,c):',
          '    if out_of_bounds or grid[r][c] != "1": return',
          '    grid[r][c] = "0"  # mark visited',
          '    dfs(r+1,c); dfs(r-1,c); dfs(r,c+1); dfs(r,c-1)',
        ],
        note: 'Mutating grid saves extra visited structure.',
        dry: {
          caption: '4-neighbour flood fill',
          auxTitle: 'Recursion',
          auxLines: ['visit (r,c)', 'sink to 0', 'explore NESW'],
        },
      },
      {
        title: 'Driver',
        code: [
          'count = 0',
          'for r,c in all_cells:',
          '    if grid[r][c] == "1":',
          '        dfs(r,c); count += 1',
        ],
        note: 'BFS queue works identically.',
        dry: {
          caption: 'Outer double loop',
          auxTitle: 'count + invariant',
          auxLines: [
            'count = DFS launches from unseen land',
            'each fresh "1" starts new island',
          ],
        },
      },
    ],
  },
};

export function resolvePlayback(
  lcNum: string,
  title: string,
  insight: string,
  existing: Solution | null | undefined
): Solution | null {
  if (lcNum && LC_COMPREHENSIVE[lcNum]) {
    return LC_COMPREHENSIVE[lcNum];
  }
  const inferred = inferFromKeywords(title, insight);
  if (!existing?.steps?.length) {
    return inferred;
  }
  if (looksLikeInsightOnlyStub(existing)) {
    return inferred ?? null;
  }
  return null;
}
