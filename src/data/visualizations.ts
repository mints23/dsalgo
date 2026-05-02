// Frame-by-frame visualization data for the Key Insight overlay.
// Each cell: v=value, s=state (color), p=pointer label shown below.
// Cell states: n=normal, l=left-ptr(blue), r=right-ptr(amber), m=mid(purple),
//              w=window(teal), ok=found(green), x=excluded(dim)

export type CellState = 'n' | 'l' | 'r' | 'm' | 'w' | 'ok' | 'x';

export interface VizCell {
  v: string | number;
  s?: CellState;
  p?: string;          // pointer label shown below this cell
}

export interface VizVar {
  k: string;           // variable name
  v: string | number;  // value
  hi?: boolean;        // highlight (changed this step)
}

export interface VizFrame {
  title: string;
  note: string;
  cells: VizCell[];
  vars?: VizVar[];
}

export interface Viz {
  frames: VizFrame[];
}

export const visualizations: Record<string, Viz> = {

  // ── LC 167 · Two Sum II — Two Pointers ─────────────────────────────
  '167': {
    frames: [
      {
        title: 'Place pointers at both ends',
        note: 'Array is already sorted ascending. left starts at 0, right at n−1. We squeeze inward.',
        cells: [
          { v: 2,  s: 'l', p: '↑ left'  },
          { v: 7  },
          { v: 11 },
          { v: 15, s: 'r', p: '↑ right' },
        ],
        vars: [
          { k: 'left',   v: 0 },
          { k: 'right',  v: 3 },
          { k: 'target', v: 9 },
        ],
      },
      {
        title: 'Compute sum = numbers[left] + numbers[right]',
        note: 'sum = 2 + 15 = 17. Compare against target to decide which pointer to move.',
        cells: [
          { v: 2,  s: 'l', p: '↑ left'  },
          { v: 7  },
          { v: 11 },
          { v: 15, s: 'r', p: '↑ right' },
        ],
        vars: [
          { k: 'left',   v: 0 },
          { k: 'right',  v: 3 },
          { k: 'sum',    v: 17, hi: true },
          { k: 'target', v: 9  },
        ],
      },
      {
        title: 'sum (17) > target (9) → move right pointer left',
        note: 'Sum is too large. Moving right inward reduces it (smaller values to the left).',
        cells: [
          { v: 2,  s: 'l', p: '↑ left'  },
          { v: 7  },
          { v: 11, s: 'r', p: '↑ right' },
          { v: 15, s: 'x' },
        ],
        vars: [
          { k: 'left',   v: 0 },
          { k: 'right',  v: 2, hi: true },
          { k: 'sum',    v: 13, hi: true },
          { k: 'target', v: 9 },
        ],
      },
      {
        title: 'sum (13) > target (9) → move right pointer left again',
        note: 'Still too large. Shrink again.',
        cells: [
          { v: 2,  s: 'l', p: '↑ left'  },
          { v: 7,  s: 'r', p: '↑ right' },
          { v: 11, s: 'x' },
          { v: 15, s: 'x' },
        ],
        vars: [
          { k: 'left',   v: 0 },
          { k: 'right',  v: 1, hi: true },
          { k: 'sum',    v: 9,  hi: true },
          { k: 'target', v: 9  },
        ],
      },
      {
        title: 'sum (9) = target (9) — Answer found!',
        note: 'Return 1-indexed positions: [left+1, right+1] = [1, 2]. The two numbers are 2 and 7.',
        cells: [
          { v: 2,  s: 'ok', p: '↑ ans[0]' },
          { v: 7,  s: 'ok', p: '↑ ans[1]' },
          { v: 11, s: 'x'  },
          { v: 15, s: 'x'  },
        ],
        vars: [
          { k: 'left',   v: 0 },
          { k: 'right',  v: 1 },
          { k: 'sum',    v: 9 },
          { k: 'return', v: '[1, 2]', hi: true },
        ],
      },
    ],
  },

  // ── LC 704 · Binary Search ──────────────────────────────────────────
  '704': {
    frames: [
      {
        title: 'Initialize — lo=0, hi=n−1',
        note: 'Target = 9. Search the full sorted array by halving the range each step.',
        cells: [
          { v: -1, p: '↑ lo' },
          { v: 0  },
          { v: 3  },
          { v: 5  },
          { v: 9  },
          { v: 12, p: '↑ hi' },
        ],
        vars: [
          { k: 'lo',     v: 0 },
          { k: 'hi',     v: 5 },
          { k: 'target', v: 9 },
        ],
      },
      {
        title: 'mid = (0+5)//2 = 2 · nums[2] = 3',
        note: '3 < target(9) → answer is in the right half. Discard everything left of mid.',
        cells: [
          { v: -1, s: 'x' },
          { v: 0,  s: 'x' },
          { v: 3,  s: 'm', p: '↑ mid' },
          { v: 5  },
          { v: 9  },
          { v: 12, p: '↑ hi' },
        ],
        vars: [
          { k: 'lo',       v: 0 },
          { k: 'hi',       v: 5 },
          { k: 'mid',      v: 2, hi: true },
          { k: 'nums[mid]',v: 3 },
          { k: 'target',   v: 9 },
        ],
      },
      {
        title: '3 < 9 → lo = mid+1 = 3 · new mid = 4',
        note: 'Search space shrinks to [3..5]. mid=(3+5)//2=4. nums[4]=9 — that\'s our target!',
        cells: [
          { v: -1, s: 'x' },
          { v: 0,  s: 'x' },
          { v: 3,  s: 'x' },
          { v: 5,  p: '↑ lo' },
          { v: 9,  s: 'm', p: '↑ mid' },
          { v: 12, p: '↑ hi' },
        ],
        vars: [
          { k: 'lo',       v: 3, hi: true },
          { k: 'hi',       v: 5 },
          { k: 'mid',      v: 4, hi: true },
          { k: 'nums[mid]',v: 9, hi: true },
          { k: 'target',   v: 9 },
        ],
      },
      {
        title: 'nums[mid] = 9 = target — Found at index 4!',
        note: 'Return mid = 4. Binary search halved the space twice — only 2 comparisons needed.',
        cells: [
          { v: -1, s: 'x' },
          { v: 0,  s: 'x' },
          { v: 3,  s: 'x' },
          { v: 5,  s: 'x' },
          { v: 9,  s: 'ok', p: '↑ found' },
          { v: 12, s: 'x'  },
        ],
        vars: [
          { k: 'mid',    v: 4 },
          { k: 'return', v: 4, hi: true },
        ],
      },
    ],
  },

  // ── LC 3 · Longest Substring Without Repeating Characters ──────────
  '3': {
    frames: [
      {
        title: 'Initialize — empty window',
        note: 'Expand right to grow the window. When a duplicate enters, shrink left to evict it.',
        cells: [
          { v: 'a' }, { v: 'b' }, { v: 'c' },
          { v: 'a' }, { v: 'b' }, { v: 'c' },
          { v: 'b' }, { v: 'b' },
        ],
        vars: [
          { k: 'left',   v: 0  },
          { k: 'right',  v: -1 },
          { k: 'maxLen', v: 0  },
          { k: 'window', v: '""' },
        ],
      },
      {
        title: 'Expand right: add "a", "b", "c" — all unique',
        note: 'No duplicates in s[0..2]. Window = "abc". maxLen updated to 3.',
        cells: [
          { v: 'a', s: 'w', p: '↑ left'  },
          { v: 'b', s: 'w' },
          { v: 'c', s: 'w', p: '↑ right' },
          { v: 'a' }, { v: 'b' }, { v: 'c' },
          { v: 'b' }, { v: 'b' },
        ],
        vars: [
          { k: 'left',   v: 0 },
          { k: 'right',  v: 2, hi: true },
          { k: 'maxLen', v: 3, hi: true },
          { k: 'window', v: '"abc"', hi: true },
        ],
      },
      {
        title: 's[3]="a" already in window → shrink left to 1',
        note: '"a" is at index 0 in the window. Move left past it. Window = "bca".',
        cells: [
          { v: 'a', s: 'x' },
          { v: 'b', s: 'w', p: '↑ left'  },
          { v: 'c', s: 'w' },
          { v: 'a', s: 'w', p: '↑ right' },
          { v: 'b' }, { v: 'c' },
          { v: 'b' }, { v: 'b' },
        ],
        vars: [
          { k: 'left',   v: 1, hi: true },
          { k: 'right',  v: 3, hi: true },
          { k: 'maxLen', v: 3 },
          { k: 'window', v: '"bca"', hi: true },
        ],
      },
      {
        title: 's[4]="b" already in window → shrink left to 2',
        note: '"b" is at index 1 in the window. Advance left to 2. Window = "cab".',
        cells: [
          { v: 'a', s: 'x' },
          { v: 'b', s: 'x' },
          { v: 'c', s: 'w', p: '↑ left'  },
          { v: 'a', s: 'w' },
          { v: 'b', s: 'w', p: '↑ right' },
          { v: 'c' }, { v: 'b' }, { v: 'b' },
        ],
        vars: [
          { k: 'left',   v: 2, hi: true },
          { k: 'right',  v: 4, hi: true },
          { k: 'maxLen', v: 3 },
          { k: 'window', v: '"cab"', hi: true },
        ],
      },
      {
        title: 'Window keeps sliding — maxLen stays at 3',
        note: '"c" and "b" duplicates force left to advance each time. No longer window found.',
        cells: [
          { v: 'a', s: 'x' },
          { v: 'b', s: 'x' },
          { v: 'c', s: 'x' },
          { v: 'a', s: 'x' },
          { v: 'b', s: 'x' },
          { v: 'c', s: 'w', p: '↑ left'  },
          { v: 'b', s: 'w' },
          { v: 'b', s: 'w', p: '↑ right' },
        ],
        vars: [
          { k: 'left',   v: 5, hi: true },
          { k: 'right',  v: 7, hi: true },
          { k: 'maxLen', v: 3 },
          { k: 'window', v: '"cbb"→shrinks', hi: true },
        ],
      },
      {
        title: 'End of string — return maxLen = 3',
        note: 'Longest unique substring is "abc" (or "bca" / "cab" — all length 3). Answer: 3.',
        cells: [
          { v: 'a', s: 'ok' },
          { v: 'b', s: 'ok' },
          { v: 'c', s: 'ok' },
          { v: 'a', s: 'x' },
          { v: 'b', s: 'x' },
          { v: 'c', s: 'x' },
          { v: 'b', s: 'x' },
          { v: 'b', s: 'x' },
        ],
        vars: [
          { k: 'maxLen', v: 3  },
          { k: 'return', v: 3, hi: true },
        ],
      },
    ],
  },

  // ── LC 11 · Container With Most Water — Two Pointers ───────────────
  '11': {
    frames: [
      {
        title: 'Start with widest container — left=0, right=8',
        note: 'Area = min(height[left], height[right]) × width. Width is largest here — good start.',
        cells: [
          { v: 1, s: 'l', p: '↑ left'  },
          { v: 8 }, { v: 6 }, { v: 2 },
          { v: 5 }, { v: 4 }, { v: 8 },
          { v: 3 },
          { v: 7, s: 'r', p: '↑ right' },
        ],
        vars: [
          { k: 'left',    v: 0 },
          { k: 'right',   v: 8 },
          { k: 'area',    v: 'min(1,7)×8 = 8', hi: true },
          { k: 'maxWater',v: 8, hi: true },
        ],
      },
      {
        title: 'height[left]=1 < height[right]=7 → move left inward',
        note: 'The shorter wall limits us. Moving it is the only way to possibly find more water.',
        cells: [
          { v: 1, s: 'x'  },
          { v: 8, s: 'l', p: '↑ left'  },
          { v: 6 }, { v: 2 }, { v: 5 },
          { v: 4 }, { v: 8 }, { v: 3 },
          { v: 7, s: 'r', p: '↑ right' },
        ],
        vars: [
          { k: 'left',    v: 1, hi: true },
          { k: 'right',   v: 8 },
          { k: 'area',    v: 'min(8,7)×7 = 49', hi: true },
          { k: 'maxWater',v: 49, hi: true },
        ],
      },
      {
        title: 'height[right]=7 < height[left]=8 → move right inward',
        note: 'area=49 beats maxWater=8. Update maxWater=49. Now move the shorter wall (right).',
        cells: [
          { v: 1, s: 'x'  },
          { v: 8, s: 'l', p: '↑ left'  },
          { v: 6 }, { v: 2 }, { v: 5 }, { v: 4 }, { v: 8 },
          { v: 3, s: 'r', p: '↑ right' },
          { v: 7, s: 'x'  },
        ],
        vars: [
          { k: 'left',    v: 1 },
          { k: 'right',   v: 7, hi: true },
          { k: 'area',    v: 'min(8,3)×6 = 18' },
          { k: 'maxWater',v: 49 },
        ],
      },
      {
        title: 'Continue squeezing — no better area found',
        note: 'All remaining windows produce area < 49. Answer = 49 (walls at index 1 and 8).',
        cells: [
          { v: 1, s: 'x'  },
          { v: 8, s: 'ok', p: '↑ wall 1' },
          { v: 6, s: 'x'  }, { v: 2, s: 'x'  }, { v: 5, s: 'x'  },
          { v: 4, s: 'x'  }, { v: 8, s: 'x'  }, { v: 3, s: 'x'  },
          { v: 7, s: 'ok', p: '↑ wall 2' },
        ],
        vars: [
          { k: 'maxWater', v: 49 },
          { k: 'return',   v: 49, hi: true },
        ],
      },
    ],
  },

  // ── LC 125 · Valid Palindrome — Two Pointers + skip ─────────────────
  // Trace: "a,b,a" → commas ignored; outward-in compare.
  '125': {
    frames: [
      {
        title: 'Place pointers at both ends',
        note: 'Only alphanumeric characters count; case-insensitive match.',
        cells: [
          { v: 'a', s: 'l', p: '↑ left' },
          { v: ',' },
          { v: 'b' },
          { v: ',' },
          { v: 'a', s: 'r', p: '↑ right' },
        ],
        vars: [
          { k: 'left', v: 0 },
          { k: 'right', v: 4 },
        ],
      },
      {
        title: 'a equals a — advance inward',
        note: 'Match; shrink the window.',
        cells: [
          { v: 'a', s: 'ok' },
          { v: ',', s: 'x' },
          { v: 'b' },
          { v: ',' },
          { v: 'a', s: 'ok' },
        ],
        vars: [
          { k: 'left', v: 1, hi: true },
          { k: 'right', v: 3, hi: true },
        ],
      },
      {
        title: 'Skip punctuation at left and right',
        note: 'Commas are not alphanumeric — slide until both land on letters.',
        cells: [
          { v: 'a', s: 'x' },
          { v: ',', s: 'x', p: '↑ skip' },
          { v: 'b', s: 'm', p: '↑ meet' },
          { v: ',', s: 'x' },
          { v: 'a', s: 'x' },
        ],
        vars: [
          { k: 'left', v: 2, hi: true },
          { k: 'right', v: 2, hi: true },
        ],
      },
      {
        title: 'Same index — middle letter; still valid',
        note: 'Compared b with b; advance pointers past each other.',
        cells: [
          { v: 'a', s: 'x' },
          { v: ',', s: 'x' },
          { v: 'b', s: 'ok' },
          { v: ',', s: 'x' },
          { v: 'a', s: 'x' },
        ],
        vars: [
          { k: 'left', v: 3, hi: true },
          { k: 'right', v: 1, hi: true },
        ],
      },
      {
        title: 'left ≥ right — exhausted successfully',
        note: 'Every symmetric pair matched → palindrome.',
        cells: [
          { v: 'a', s: 'ok' },
          { v: ',' },
          { v: 'b', s: 'ok' },
          { v: ',' },
          { v: 'a', s: 'ok' },
        ],
        vars: [
          { k: 'return', v: true, hi: true },
        ],
      },
    ],
  },

  // ── LC 283 · Move Zeroes — Two Pointers (swap) ─────────────────────
  '283': {
    frames: [
      {
        title: 'Initialize — write=0 tracks next non-zero position',
        note: 'Scan with read. When a non-zero is found, swap it to the write position.',
        cells: [
          { v: 0, p: '↑ write\n   read' },
          { v: 1 }, { v: 0 },
          { v: 3 }, { v: 12 },
        ],
        vars: [
          { k: 'write', v: 0 },
          { k: 'read',  v: 0 },
        ],
      },
      {
        title: 'read=0: nums[0]=0 → skip · read=1: nums[1]=1 ≠ 0 → swap',
        note: 'Zero at index 0 is skipped. Non-zero 1 swaps with nums[write=0]. write advances to 1.',
        cells: [
          { v: 1, s: 'ok', p: '↑ write' },
          { v: 0, s: 'x'  },
          { v: 0, p: '↑ read' },
          { v: 3 }, { v: 12 },
        ],
        vars: [
          { k: 'write', v: 1, hi: true },
          { k: 'read',  v: 2, hi: true },
          { k: 'array', v: '[1,0,0,3,12]', hi: true },
        ],
      },
      {
        title: 'read=2: skip · read=3: nums[3]=3 ≠ 0 → swap with write=1',
        note: 'Zero at index 2 is skipped. 3 swaps to index 1. write=2.',
        cells: [
          { v: 1, s: 'ok' },
          { v: 3, s: 'ok', p: '↑ write' },
          { v: 0, s: 'x'  },
          { v: 0, s: 'x'  },
          { v: 12, p: '↑ read' },
        ],
        vars: [
          { k: 'write', v: 2, hi: true },
          { k: 'read',  v: 4, hi: true },
          { k: 'array', v: '[1,3,0,0,12]', hi: true },
        ],
      },
      {
        title: 'read=4: nums[4]=12 ≠ 0 → swap with write=2',
        note: '12 swaps to index 2. write=3. All non-zeros are now at the front.',
        cells: [
          { v: 1,  s: 'ok' },
          { v: 3,  s: 'ok' },
          { v: 12, s: 'ok', p: '↑ write' },
          { v: 0,  s: 'x'  },
          { v: 0,  s: 'x'  },
        ],
        vars: [
          { k: 'write',  v: 3, hi: true },
          { k: 'result', v: '[1,3,12,0,0]', hi: true },
        ],
      },
    ],
  },

  // ── LC 76 · Minimum Window Substring ───────────────────────────────
  '76': {
    frames: [
      {
        title: 'Initialize — expand right to find a valid window',
        note: 'Need all chars of t="ABC" in a window of s. Start with empty window.',
        cells: [
          { v: 'A' }, { v: 'D' }, { v: 'O' },
          { v: 'B' }, { v: 'E' }, { v: 'C' },
          { v: 'O' }, { v: 'D' }, { v: 'E' },
          { v: 'B' }, { v: 'A' }, { v: 'N' },
          { v: 'C' },
        ],
        vars: [
          { k: 'left',  v: 0  },
          { k: 'right', v: -1 },
          { k: 'need',  v: '{A:1,B:1,C:1}' },
          { k: 'have',  v: 0  },
          { k: 'minLen',v: '∞' },
        ],
      },
      {
        title: 'Expand to index 5 — window "ADOBEC" contains all of t',
        note: 'All required chars found (have=3). Valid window of length 6. Record it.',
        cells: [
          { v: 'A', s: 'w', p: '↑ left' },
          { v: 'D', s: 'w' },
          { v: 'O', s: 'w' },
          { v: 'B', s: 'w' },
          { v: 'E', s: 'w' },
          { v: 'C', s: 'w', p: '↑ right' },
          { v: 'O' }, { v: 'D' }, { v: 'E' },
          { v: 'B' }, { v: 'A' }, { v: 'N' },
          { v: 'C' },
        ],
        vars: [
          { k: 'left',  v: 0 },
          { k: 'right', v: 5 },
          { k: 'have',  v: 3 },
          { k: 'window',v: '"ADOBEC"', hi: true },
          { k: 'minLen',v: 6, hi: true },
        ],
      },
      {
        title: 'Shrink left — try to tighten the window',
        note: 'Remove s[0]="A" from window. Now missing "A" — window is invalid. Stop shrinking.',
        cells: [
          { v: 'A', s: 'x'  },
          { v: 'D', s: 'w', p: '↑ left' },
          { v: 'O', s: 'w' },
          { v: 'B', s: 'w' },
          { v: 'E', s: 'w' },
          { v: 'C', s: 'w', p: '↑ right' },
          { v: 'O' }, { v: 'D' }, { v: 'E' },
          { v: 'B' }, { v: 'A' }, { v: 'N' },
          { v: 'C' },
        ],
        vars: [
          { k: 'left',  v: 1, hi: true },
          { k: 'right', v: 5 },
          { k: 'have',  v: 2, hi: true },
          { k: 'minLen',v: 6 },
        ],
      },
      {
        title: 'Expand right until valid again — found "BANC" at end',
        note: 'After more expansions, window s[10..12]="ANC"... best valid window is "BANC" (len 4).',
        cells: [
          { v: 'A', s: 'x' }, { v: 'D', s: 'x' }, { v: 'O', s: 'x' },
          { v: 'B', s: 'x' }, { v: 'E', s: 'x' }, { v: 'C', s: 'x' },
          { v: 'O', s: 'x' }, { v: 'D', s: 'x' }, { v: 'E', s: 'x' },
          { v: 'B', s: 'ok', p: '↑ left' },
          { v: 'A', s: 'ok' },
          { v: 'N', s: 'ok' },
          { v: 'C', s: 'ok', p: '↑ right' },
        ],
        vars: [
          { k: 'minLen', v: 4  },
          { k: 'return', v: '"BANC"', hi: true },
        ],
      },
    ],
  },

  // ── LC 33 · Search in Rotated Sorted Array ──────────────────────────
  '33': {
    frames: [
      {
        title: 'Initialize — lo=0, hi=6',
        note: 'Array is sorted but rotated. Binary search still works — one half is always sorted.',
        cells: [
          { v: 4,  p: '↑ lo' },
          { v: 5  }, { v: 6  }, { v: 7  },
          { v: 0  }, { v: 1  },
          { v: 2,  p: '↑ hi' },
        ],
        vars: [
          { k: 'lo',     v: 0 },
          { k: 'hi',     v: 6 },
          { k: 'target', v: 0 },
        ],
      },
      {
        title: 'mid=3, nums[3]=7 — left half [4..7] is sorted',
        note: 'Left half [4,5,6,7] is sorted. target(0) NOT in [4..7] → search right half.',
        cells: [
          { v: 4, s: 'x' }, { v: 5, s: 'x' }, { v: 6, s: 'x' },
          { v: 7, s: 'm', p: '↑ mid' },
          { v: 0 }, { v: 1 },
          { v: 2, p: '↑ hi' },
        ],
        vars: [
          { k: 'lo',       v: 0 },
          { k: 'hi',       v: 6 },
          { k: 'mid',      v: 3, hi: true },
          { k: 'nums[mid]',v: 7 },
          { k: 'target',   v: 0 },
        ],
      },
      {
        title: 'lo = mid+1 = 4 · mid=5, nums[5]=1 — right half sorted',
        note: 'Right half [0,1,2] is sorted. target(0) IS in [0..1] → search left of mid.',
        cells: [
          { v: 4, s: 'x' }, { v: 5, s: 'x' }, { v: 6, s: 'x' }, { v: 7, s: 'x' },
          { v: 0, p: '↑ lo' },
          { v: 1, s: 'm', p: '↑ mid' },
          { v: 2, p: '↑ hi' },
        ],
        vars: [
          { k: 'lo',       v: 4, hi: true },
          { k: 'hi',       v: 6 },
          { k: 'mid',      v: 5, hi: true },
          { k: 'nums[mid]',v: 1 },
          { k: 'target',   v: 0 },
        ],
      },
      {
        title: 'hi = mid−1 = 4 · nums[4]=0 = target — Found!',
        note: 'lo=hi=4. mid=4. nums[4]=0 = target. Return index 4.',
        cells: [
          { v: 4, s: 'x' }, { v: 5, s: 'x' }, { v: 6, s: 'x' }, { v: 7, s: 'x' },
          { v: 0, s: 'ok', p: '↑ found' },
          { v: 1, s: 'x' }, { v: 2, s: 'x' },
        ],
        vars: [
          { k: 'mid',    v: 4 },
          { k: 'return', v: 4, hi: true },
        ],
      },
    ],
  },

  // ── LC 206 · Reverse Linked List ────────────────────────────────────
  '206': {
    frames: [
      {
        title: 'Initial list — prev=null, curr=head',
        note: 'We reverse by re-pointing each node\'s "next" backward while stepping forward.',
        cells: [
          { v: '∅', s: 'x', p: '↑ prev' },
          { v: 1,   s: 'l', p: '↑ curr' },
          { v: 2   }, { v: 3 }, { v: 4 }, { v: 5 },
          { v: '∅', s: 'x' },
        ],
        vars: [
          { k: 'prev', v: 'null' },
          { k: 'curr', v: '1'   },
        ],
      },
      {
        title: 'Save next, flip curr.next → prev',
        note: 'next=curr.next=2. curr.next=prev(null). Now node 1 points backward.',
        cells: [
          { v: '∅', s: 'x' },
          { v: 1,   s: 'ok', p: '← flipped' },
          { v: 2,   s: 'l',  p: '↑ curr' },
          { v: 3 }, { v: 4 }, { v: 5 },
          { v: '∅', s: 'x' },
        ],
        vars: [
          { k: 'prev', v: '1', hi: true },
          { k: 'curr', v: '2', hi: true },
          { k: 'next', v: '3' },
        ],
      },
      {
        title: 'Advance — repeat for nodes 2, 3, 4',
        note: 'Each iteration flips one pointer. prev chases curr across the list.',
        cells: [
          { v: '∅', s: 'x' },
          { v: 1,  s: 'ok' },
          { v: 2,  s: 'ok' },
          { v: 3,  s: 'ok' },
          { v: 4,  s: 'ok', p: '← flipped' },
          { v: 5,  s: 'l',  p: '↑ curr' },
          { v: '∅', s: 'x' },
        ],
        vars: [
          { k: 'prev', v: '4', hi: true },
          { k: 'curr', v: '5' },
        ],
      },
      {
        title: 'Flip last node — curr becomes null → return prev',
        note: 'curr.next flipped to prev=4. curr advances to null. prev=5 is the new head.',
        cells: [
          { v: '∅', s: 'x' },
          { v: 1,  s: 'ok' },
          { v: 2,  s: 'ok' },
          { v: 3,  s: 'ok' },
          { v: 4,  s: 'ok' },
          { v: 5,  s: 'ok', p: '↑ newHead' },
          { v: '∅', s: 'x' },
        ],
        vars: [
          { k: 'prev',   v: '5', hi: true },
          { k: 'curr',   v: 'null' },
          { k: 'return', v: 'node(5)', hi: true },
        ],
      },
    ],
  },
};
