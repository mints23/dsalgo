/**
 * Login page preview only — do not import from `index.astro`, `TopicCard`, or main app scripts.
 * Keeps the main bundle and runtime independent of this marketing-style preview.
 *
 * Regenerate nav rows: `node tools/dump-login-sneak-topics.mjs` and paste into LOGIN_SNEAK_NAV.
 */
export type LoginSneakNavRow = {
  displayNumber: string;
  navSection: string;
  navLabel: string;
  navTierDotColor: string;
};

export const LOGIN_SNEAK_NAV: LoginSneakNavRow[] = [
  { displayNumber: '01', navSection: 'Algorithms', navLabel: 'Two Pointer', navTierDotColor: '#01696f' },
  { displayNumber: '02', navSection: 'Algorithms', navLabel: 'HashMap', navTierDotColor: '#01696f' },
  { displayNumber: '03', navSection: 'Algorithms', navLabel: 'Binary Search', navTierDotColor: '#01696f' },
  { displayNumber: '04', navSection: 'Algorithms', navLabel: 'Sliding Window', navTierDotColor: '#01696f' },
  { displayNumber: '05', navSection: 'Algorithms', navLabel: "Kadane's Algorithm", navTierDotColor: '#01696f' },
  { displayNumber: '06', navSection: 'Algorithms', navLabel: 'Merge Intervals', navTierDotColor: '#01696f' },
  { displayNumber: '07', navSection: 'Algorithms', navLabel: 'Prefix Sums', navTierDotColor: '#01696f' },
  { displayNumber: '08', navSection: 'Algorithms', navLabel: 'Backtracking', navTierDotColor: '#01696f' },
  { displayNumber: '09', navSection: 'Algorithms', navLabel: 'Greedy', navTierDotColor: '#01696f' },
  { displayNumber: '10', navSection: 'Data Structures', navLabel: 'Top K Elements', navTierDotColor: '#7a39bb' },
  { displayNumber: '11', navSection: 'Data Structures', navLabel: 'Monotonic Stack/Queue', navTierDotColor: '#7a39bb' },
  { displayNumber: '12', navSection: 'Data Structures', navLabel: 'Trees', navTierDotColor: '#7a39bb' },
  { displayNumber: '13', navSection: 'Data Structures', navLabel: 'Trie', navTierDotColor: '#7a39bb' },
  { displayNumber: '14', navSection: 'Dynamic Programming', navLabel: '1D Linear DP', navTierDotColor: '#006494' },
  { displayNumber: '15', navSection: 'Dynamic Programming', navLabel: '2D Grid DP', navTierDotColor: '#006494' },
  { displayNumber: '16', navSection: 'Dynamic Programming', navLabel: 'The Knapsack Family', navTierDotColor: '#006494' },
  { displayNumber: '17', navSection: 'Dynamic Programming', navLabel: 'Strings & Subsequences', navTierDotColor: '#006494' },
  { displayNumber: '18', navSection: 'Dynamic Programming', navLabel: 'State Machine DP', navTierDotColor: '#006494' },
  { displayNumber: '19', navSection: 'Dynamic Programming', navLabel: 'Interval DP', navTierDotColor: '#006494' },
  { displayNumber: '20', navSection: 'Dynamic Programming', navLabel: 'Partition DP', navTierDotColor: '#006494' },
  { displayNumber: '21', navSection: 'Dynamic Programming', navLabel: 'Game Theory & Minimax', navTierDotColor: '#006494' },
  { displayNumber: '22', navSection: 'Dynamic Programming', navLabel: 'Tree DP', navTierDotColor: '#006494' },
  { displayNumber: '23', navSection: 'Dynamic Programming', navLabel: 'Digit DP', navTierDotColor: '#006494' },
  { displayNumber: '24', navSection: 'Dynamic Programming', navLabel: 'Data Structure Optimized DP', navTierDotColor: '#006494' },
  { displayNumber: '25', navSection: 'Dynamic Programming', navLabel: 'Profile / Broken Profile DP', navTierDotColor: '#006494' },
  { displayNumber: '26', navSection: 'Graphs', navLabel: 'Graph Fundamentals', navTierDotColor: '#da7101' },
  { displayNumber: '27', navSection: 'Graphs', navLabel: 'BFS', navTierDotColor: '#da7101' },
  { displayNumber: '28', navSection: 'Graphs', navLabel: 'DFS', navTierDotColor: '#da7101' },
  { displayNumber: '29', navSection: 'Graphs', navLabel: 'Multi-Source BFS', navTierDotColor: '#da7101' },
  { displayNumber: '30', navSection: 'Graphs', navLabel: 'Bipartite Graph', navTierDotColor: '#da7101' },
  { displayNumber: '31', navSection: 'Graphs', navLabel: 'Topological Sort', navTierDotColor: '#da7101' },
  { displayNumber: '32', navSection: 'Graphs', navLabel: "Dijkstra's Algorithm", navTierDotColor: '#a13544' },
  { displayNumber: '33', navSection: 'Graphs', navLabel: 'Floyd Warshall', navTierDotColor: '#a13544' },
  { displayNumber: '34', navSection: 'Graphs', navLabel: 'Bellman Ford', navTierDotColor: '#a13544' },
  { displayNumber: '35', navSection: 'Graphs', navLabel: 'Union Find', navTierDotColor: '#a13544' },
  { displayNumber: '36', navSection: 'Graphs', navLabel: 'Advanced Graphs', navTierDotColor: '#a13544' },
  { displayNumber: '37', navSection: 'Advanced Techniques', navLabel: 'Sieve of Eratosthenes', navTierDotColor: '#da7101' },
  { displayNumber: '38', navSection: 'Advanced Techniques', navLabel: 'Fenwick Tree / BIT', navTierDotColor: '#da7101' },
  { displayNumber: '39', navSection: 'Advanced Techniques', navLabel: 'Segment Tree', navTierDotColor: '#da7101' },
  { displayNumber: '40', navSection: 'Advanced Techniques', navLabel: 'KMP Pattern Matching', navTierDotColor: '#da7101' },
  { displayNumber: '41', navSection: 'Advanced Techniques', navLabel: 'LIS O(N log N)', navTierDotColor: '#da7101' },
];

export const LOGIN_SNEAK_SAMPLE_TOPIC = {
  title: 'Two Pointers',
  summaryMeta: '58 problems · sorted array, linked list, string, in-place dedup, greedy opposite-end',
} as const;

export type LoginSneakProblem = {
  num: string;
  layer: string;
  layerCls: string;
  lc: string;
  href: string;
  name: string;
  diff: string;
  diffCls: string;
  insight: string;
};

export const LOGIN_SNEAK_SAMPLE_ROWS: LoginSneakProblem[] = [
  {
    num: '1',
    layer: 'Foundation',
    layerCls: 'l1',
    lc: '167',
    href: 'https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/',
    name: 'Two Sum II',
    diff: 'Med',
    diffCls: 'diff-m',
    insight: 'lo+hi pointers; move lo up if sum too small, hi down if too large',
  },
  {
    num: '2',
    layer: 'Foundation',
    layerCls: 'l1',
    lc: '15',
    href: 'https://leetcode.com/problems/3sum/',
    name: '3Sum',
    diff: 'Med',
    diffCls: 'diff-m',
    insight: 'Sort; fix i, run opposite-end on [i+1,n-1]; skip duplicates',
  },
  {
    num: '3',
    layer: 'Foundation',
    layerCls: 'l1',
    lc: '11',
    href: 'https://leetcode.com/problems/container-with-most-water/',
    name: 'Container With Most Water',
    diff: 'Med',
    diffCls: 'diff-m',
    insight: 'Move the shorter side — width shrinks; only shorter can improve',
  },
  {
    num: '4',
    layer: 'Foundation',
    layerCls: 'l1',
    lc: '125',
    href: 'https://leetcode.com/problems/valid-palindrome/',
    name: 'Valid Palindrome',
    diff: 'Easy',
    diffCls: 'diff-e',
    insight: 'Skip non-alphanumeric; compare case-insensitive from both ends',
  },
  {
    num: '5',
    layer: 'Foundation',
    layerCls: 'l1',
    lc: '141',
    href: 'https://leetcode.com/problems/linked-list-cycle/',
    name: 'Linked List Cycle',
    diff: 'Easy',
    diffCls: 'diff-e',
    insight: "Floyd's tortoise & hare — meet means cycle",
  },
];
