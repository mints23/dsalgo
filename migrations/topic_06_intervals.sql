-- Migration: Rename "Merge Intervals" → "Intervals" and revamp all content
-- Topic id: 6  (display_number '06', navSection 'Algorithms')
-- Run in Supabase SQL Editor with the postgres / service-role key.
-- Safe to re-run: topic_content uses ON CONFLICT, problems DELETE+INSERT is idempotent.

-- ── 1. topics table ──────────────────────────────────────────────────────────
update public.topics
set
  nav_label    = 'Intervals',
  title        = 'Intervals',
  type_label   = 'Technique',
  summary_meta = '43 problems · merge · insert · scheduling · sweep line · difference array · weighted DP · dynamic interval set · 20 sub-variants',
  topbar_meta  = 'Algorithms · Intervals · Technique'
where id = 6;

-- ── 2. topic_content table ───────────────────────────────────────────────────
insert into public.topic_content (
  topic_id,
  why_it_matters,
  core_idea,
  sub_variants,
  pattern_triggers,
  coverage_problems,
  red_flags
) values (
  6,

  -- why_it_matters
  'Interval problems form a canonical category in top-tier interviews because they test your ability to reason about ranges on a number line — a deceptively simple structure that hides rich complexity. The core invariant is always about overlap detection and resolution: two intervals [a,b] and [c,d] overlap if and only if a ≤ d AND c ≤ b. From this single predicate an entire universe of problems is born — merging, inserting, scheduling, covering, partitioning, and counting. Google, Meta, and Amazon use interval problems as a proxy for a candidate''s ability to handle continuous ranges, think in sorted order, and manage edge cases around boundary conditions. Mastery requires knowing not just how to sort intervals but which endpoint to sort by and why, when a greedy sweep works, when you need a heap, and when the problem is secretly a graph or DP in disguise.',

  -- core_idea
  'Two intervals [a,b] and [c,d] overlap iff a ≤ d AND c ≤ b. From this single predicate everything follows: merge (sort by start, greedily extend end), activity selection (sort by end, keep earliest-ending), peak overlap (two-pointer on sorted starts+ends, or min-heap), interval cover (greedy max-reach jump), weighted scheduling (DP + binary search for last non-conflicting job), and dynamic interval sets (TreeMap / sorted structure). The sort key determines everything — sort by start for merge/insert, sort by end for activity selection / non-overlapping.',

  -- sub_variants
  '[
    "Merge overlapping intervals",
    "Insert interval into sorted list",
    "Minimum intervals to remove (max non-overlapping / activity selection)",
    "Minimum rooms / resources (peak overlap count)",
    "Meeting scheduler / find free slots",
    "Interval covering — minimum intervals to cover a range",
    "Interval partitioning into minimum groups",
    "Weighted interval scheduling (maximize total weight with no overlap)",
    "Interval DP (dp on subintervals — burst balloons, matrix chain)",
    "Sweep line with start/end events",
    "Difference array / range update + point query",
    "Segment tree / BIT on intervals (range queries + updates)",
    "Skyline problem (envelope of overlapping rectangles)",
    "Count intervals containing a point (offline sweep or segment tree)",
    "Interval intersection of two sorted lists (two-pointer)",
    "Minimum interval to include each query (offline + min-heap)",
    "Stabbing queries — for each point find all containing intervals",
    "Calendar / booking problems (k-booking, triple-booking detection)",
    "Merge intervals on a circular range (wrap-around edge cases)",
    "Intervals on a 2D plane (rectangle area unions — sweep line + segment tree)"
  ]'::jsonb,

  -- pattern_triggers
  '[
    {
      "trigger": "Merge overlapping intervals",
      "sub_variant": "Merge",
      "breaks_when": "Sort by start; greedy extend end = max(end, cur.end) when overlap detected"
    },
    {
      "trigger": "Minimum number of meeting rooms / resources / machines",
      "sub_variant": "Min Rooms (Peak Overlap)",
      "breaks_when": "Sort starts+ends separately; two-pointer sweep counting simultaneous meetings. Alt: min-heap on end times."
    },
    {
      "trigger": "Maximum number of non-overlapping intervals",
      "sub_variant": "Activity Selection",
      "breaks_when": "Sort by end; greedily keep earliest-ending interval — exchange argument proves optimality"
    },
    {
      "trigger": "Minimum intervals to cover [0, T] (or any range)",
      "sub_variant": "Interval Cover",
      "breaks_when": "Sort by start; greedy max-reach jump. Same as Jump Game II in disguise."
    },
    {
      "trigger": "For each query point, find the smallest / best interval containing it",
      "sub_variant": "Min Interval per Query",
      "breaks_when": "Sort queries offline + min-heap by interval length; add all intervals starting ≤ query, evict expired"
    },
    {
      "trigger": "Add / remove intervals dynamically, query how many integers are covered",
      "sub_variant": "Dynamic Interval Set",
      "breaks_when": "TreeMap of disjoint intervals; on insert merge left and right neighbors; on remove split the overlapping interval"
    },
    {
      "trigger": "Range add, point query",
      "sub_variant": "Difference Array",
      "breaks_when": "diff[l]++; diff[r+1]--; prefix sum answers point queries in O(n). Fails on range-range queries."
    },
    {
      "trigger": "Range add, range query",
      "sub_variant": "Range Update + Range Query",
      "breaks_when": "Two difference arrays (for sum and count) or BIT / segment tree with lazy propagation"
    },
    {
      "trigger": "Each element can extend ±k; find longest subsequence of equal values",
      "sub_variant": "Range Overlap Count via Difference Array",
      "breaks_when": "Each element becomes interval [x−k, x+k]; max frequency = max overlap = max prefix sum of difference array"
    },
    {
      "trigger": "Partition intervals into groups so no two in the same group overlap",
      "sub_variant": "Interval Partitioning (Coloring)",
      "breaks_when": "Identical to Min Meeting Rooms — min groups = max simultaneous overlap"
    },
    {
      "trigger": "Find free time between a set of busy intervals",
      "sub_variant": "Free Slots (Complement of Union)",
      "breaks_when": "Merge ALL intervals globally first, then take gaps. Do NOT process per-person — cross-worker overlaps matter."
    },
    {
      "trigger": "Each job has start, end, profit — maximize profit with no overlapping jobs",
      "sub_variant": "Weighted Interval DP",
      "breaks_when": "Sort by end; dp[i] = max profit using first i jobs; binary search for last non-conflicting job. Greedy is wrong."
    },
    {
      "trigger": "How many intervals are contained inside each interval",
      "sub_variant": "Containment Count",
      "breaks_when": "Sort by start asc, end desc; use BIT to count how many previous ends are ≥ current end"
    },
    {
      "trigger": "Rectangle area union (2D intervals)",
      "sub_variant": "2D Sweep Line + Segment Tree",
      "breaks_when": "Coordinate compress x-axis; sweep line top-to-bottom; segment tree on compressed x tracks active width at each y-level"
    }
  ]'::jsonb,

  -- coverage_problems (Phase-1 solve order = 80% pattern coverage)
  '["LC 56","LC 57","LC 986","LC 435","LC 452","LC 253","LC 1024","LC 729","LC 731","LC 1235"]'::jsonb,

  -- red_flags
  '[
    "<strong>Sorting by start when you should sort by end (or vice versa).</strong> Merge intervals → sort by start. Activity selection (max non-overlapping) → sort by end. Confusing these is the single most common interval bug.",
    "<strong>Wrong overlap predicate.</strong> Correct test: a ≤ d && c ≤ b. A common wrong version is a < d && c < b, which misses touching intervals like [1,3] and [3,5]. Always clarify closed vs. half-open intervals before coding.",
    "<strong>Forgetting to sort before greedy.</strong> All interval greedy algorithms assume sorted order. Applying the loop to unsorted input silently produces wrong answers.",
    "<strong>Using greedy for weighted interval scheduling.</strong> When intervals have weights or profits, sort-by-end greedy is wrong. You need DP with binary search for the last non-conflicting interval.",
    "<strong>Off-by-one in difference array.</strong> For a closed interval [l, r], update is diff[l]++; diff[r+1]--. Writing diff[r]-- is the canonical off-by-one that passes most test cases but fails on boundary inputs.",
    "<strong>TreeMap predecessor / successor confusion during dynamic merge.</strong> When inserting [l, r] into a TreeMap of disjoint intervals, check both the floor entry (start ≤ l) AND the ceiling entry (start > l) for overlap. Checking only one direction silently corrupts the interval set.",
    "<strong>Tie-breaking in sweep line events.</strong> In the Skyline problem and similar, when a rectangle starts and another ends at the same x-coordinate, end events must be processed before start events (or vice versa, depending on open/closed endpoints). Wrong tie-breaking produces spurious zero-length output intervals."
  ]'::jsonb
)
on conflict (topic_id) do update set
  why_it_matters    = excluded.why_it_matters,
  core_idea         = excluded.core_idea,
  sub_variants      = excluded.sub_variants,
  pattern_triggers  = excluded.pattern_triggers,
  coverage_problems = excluded.coverage_problems,
  red_flags         = excluded.red_flags;


-- ── 3. problems table ────────────────────────────────────────────────────────
delete from public.problems where topic_id = 6;

insert into public.problems
  (topic_id, order_num, layer, lc_number, lc_url, title, difficulty, is_premium, sub_variant, key_insight)
values

-- ── Layer 1: Foundation ───────────────────────────────────────────────────────
(6,  1, 'Foundation', '56',
  'https://leetcode.com/problems/merge-intervals/',
  'Merge Intervals',
  'Med', false,
  'Merge overlapping',
  'Sort by start; greedily extend end = max(end, cur.end) when overlap detected'),

(6,  2, 'Foundation', '57',
  'https://leetcode.com/problems/insert-interval/',
  'Insert Interval',
  'Med', false,
  'Insert into sorted list',
  'Binary-search / linear scan; everything with newEnd < cur.start is left, newStart > cur.end is right, rest merge'),

(6,  3, 'Foundation', '986',
  'https://leetcode.com/problems/interval-list-intersections/',
  'Interval List Intersections',
  'Med', false,
  'Interval intersection (two lists)',
  'Two pointers; advance whichever interval ends first; intersection is [max(a,c), min(b,d)] when it exists'),

(6,  4, 'Foundation', '1851',
  'https://leetcode.com/problems/minimum-interval-to-include-each-query/',
  'Minimum Interval to Include Each Query',
  'Hard', false,
  'Min interval per query',
  'Sort queries offline + min-heap by interval length; add all intervals starting ≤ query, evict expired — Hard because combining offline sorting of queries with a live heap requires careful index remapping'),

-- ── Layer 2: Variants ─────────────────────────────────────────────────────────
(6,  5, 'Variants', '435',
  'https://leetcode.com/problems/non-overlapping-intervals/',
  'Non-overlapping Intervals',
  'Med', false,
  'Max non-overlapping / min removals',
  'Sort by end; greedily keep earliest-ending interval — classic activity selection'),

(6,  6, 'Variants', '452',
  'https://leetcode.com/problems/minimum-number-of-arrows-to-burst-balloons/',
  'Minimum Number of Arrows to Burst Balloons',
  'Med', false,
  'Interval stabbing / covering points',
  'Same greedy as #435 but removal count ≠ arrow count; one arrow can burst multiple balloons'),

(6,  7, 'Variants', '253',
  'https://leetcode.com/problems/meeting-rooms-ii/',
  'Meeting Rooms II',
  'Med', true,
  'Min rooms / peak overlap',
  'Sort starts and ends separately; two-pointer sweep counts simultaneous meetings'),

(6,  8, 'Variants', '252',
  'https://leetcode.com/problems/meeting-rooms/',
  'Meeting Rooms',
  'Med', true,
  'Overlap detection (boolean)',
  'Sort by start; check if any intervals[i].start < intervals[i-1].end'),

(6,  9, 'Variants', '1288',
  'https://leetcode.com/problems/remove-covered-intervals/',
  'Remove Covered Intervals',
  'Med', false,
  'Covered intervals',
  'Sort by start asc, end desc; a later interval is covered if its end ≤ current max end'),

(6, 10, 'Variants', '1360',
  'https://leetcode.com/problems/number-of-days-between-two-dates/',
  'Number of Days Between Two Dates',
  'Med', false,
  '⚠️ Not an interval problem — pure date arithmetic',
  'Trap: do not reach for interval techniques — this is Gregorian calendar arithmetic; no overlap or merge involved'),

(6, 11, 'Variants', '759',
  'https://leetcode.com/problems/employee-free-time/',
  'Employee Free Time',
  'Hard', true,
  'Free slots / complement of union',
  'Merge all employee intervals globally; gaps between merged intervals are free time — Hard because input is a list-of-lists requiring flattening before merge'),

(6, 12, 'Variants', '1326',
  'https://leetcode.com/problems/minimum-number-of-taps-to-open-to-water-a-garden/',
  'Minimum Number of Taps to Water a Garden',
  'Med', false,
  'Min intervals to cover a range',
  'Convert taps to intervals; greedy jump-game style cover'),

(6, 13, 'Variants', '45',
  'https://leetcode.com/problems/jump-game-ii/',
  'Jump Game II',
  'Med', false,
  '⚠️ Interval cover disguise',
  'Reframe each position as interval [i, i+nums[i]]; greedy BFS-layer cover — train recognition that jump games are interval covering in disguise'),

(6, 14, 'Variants', '1024',
  'https://leetcode.com/problems/video-stitching/',
  'Video Stitching',
  'Med', false,
  'Min intervals to cover [0,T]',
  'Sort by start; greedy: among all intervals starting ≤ current reach, pick the one with max end'),

(6, 15, 'Variants', '732',
  'https://leetcode.com/problems/my-calendar-iii/',
  'My Calendar III',
  'Hard', false,
  'k-booking / max overlap count',
  'Difference array or segment tree; at any point, overlap = prefix sum of +1/−1 events — Hard because requires dynamic range-update structure, not just sorting'),

(6, 16, 'Variants', '729',
  'https://leetcode.com/problems/my-calendar-i/',
  'My Calendar I',
  'Med', false,
  'Calendar / booking (no overlap)',
  'Sorted set + binary search for predecessor/successor to check conflict'),

(6, 17, 'Variants', '731',
  'https://leetcode.com/problems/my-calendar-ii/',
  'My Calendar II',
  'Med', false,
  'Double booking detection',
  'Track single bookings and overlaps separately; a triple book occurs when the new interval intersects the overlaps set'),

(6, 18, 'Variants', '218',
  'https://leetcode.com/problems/the-skyline-problem/',
  'The Skyline Problem',
  'Hard', false,
  'Skyline / rectangle envelope',
  'Sweep line; use a max-heap (or sorted multiset) of active heights — Hard because simultaneous start/end events at the same x require careful tie-breaking (ends before starts)'),

-- ── Layer 3: Combo ────────────────────────────────────────────────────────────
(6, 19, 'Combo', '715',
  'https://leetcode.com/problems/range-module/',
  'Range Module',
  'Hard', false,
  'Dynamic interval set with range queries',
  'Maintain sorted set of disjoint intervals; TreeMap for O(log n) add/remove/query — Hard because intervals must be dynamically merged and split during updates'),

(6, 20, 'Combo', '352',
  'https://leetcode.com/problems/data-stream-as-disjoint-intervals/',
  'Data Stream as Disjoint Intervals',
  'Hard', false,
  'Dynamic merge into sorted interval set',
  'TreeMap keyed by start; on insert, merge with left and right neighbors — Hard because live-stream merging requires correct predecessor/successor lookup and multi-interval coalescence in one pass'),

(6, 21, 'Combo', '2276',
  'https://leetcode.com/problems/count-integers-in-intervals/',
  'Count Integers in Intervals',
  'Hard', false,
  'Count covered integers dynamically',
  'Same TreeMap approach as #352 but maintain a running total of covered length — Hard because updating the covered count during overlapping merges requires careful arithmetic with predecessor/successor'),

(6, 22, 'Combo', '850',
  'https://leetcode.com/problems/rectangle-area-ii/',
  'Rectangle Area II',
  'Hard', false,
  '2D interval union area',
  'Coordinate compress x-axis; sweep line top-to-bottom; segment tree on compressed x tracks active width — Hard because the 2D generalization requires a segment tree with lazy propagation'),

(6, 23, 'Combo', '2406',
  'https://leetcode.com/problems/divide-intervals-into-minimum-number-of-groups/',
  'Divide Intervals Into Minimum Number of Groups',
  'Med', false,
  'Interval partitioning / coloring',
  'Same as Meeting Rooms II; min groups = max simultaneous overlap; difference array or two-pointer'),

(6, 24, 'Combo', '2779',
  'https://leetcode.com/problems/maximum-beauty-of-an-array-after-applying-operation/',
  'Maximum Beauty of an Array After Applying Operation',
  'Med', false,
  'Range overlap count via difference array',
  'Each element becomes interval [nums[i]−k, nums[i]+k]; max frequency = max overlap = max prefix sum of difference array'),

(6, 25, 'Combo', '1943',
  'https://leetcode.com/problems/describe-the-painting/',
  'Describe the Painting',
  'Med', false,
  'Sweep line + difference-array on segments',
  'Events at interval boundaries split the line into atomic segments; accumulate color sets per segment'),

(6, 26, 'Combo', '2237',
  'https://leetcode.com/problems/count-positions-on-street-with-required-brightness/',
  'Count Positions on Street With Required Brightness',
  'Med', true,
  'Difference array for range updates',
  'Accumulate light contributions via difference array; scan for positions meeting the brightness threshold'),

(6, 27, 'Combo', '2158',
  'https://leetcode.com/problems/amount-of-new-area-painted-each-day/',
  'Amount of New Area Painted Each Day',
  'Hard', true,
  'Interval union with incremental area tracking',
  'Use a sorted map to skip already-painted segments in O(n log n) total — Hard because naively painting is O(n²); the key insight is a jump-pointer to skip covered ranges'),

(6, 28, 'Combo', '1589',
  'https://leetcode.com/problems/maximum-sum-obtained-of-any-permutation/',
  'Maximum Sum Obtained of Any Permutation',
  'Med', false,
  'Difference array for range frequency counting',
  'Increment frequency of positions in each requested range via difference array; sort and greedily assign largest numbers to most-requested positions'),

-- ── Layer 4: Hard ─────────────────────────────────────────────────────────────
(6, 29, 'Hard', '630',
  'https://leetcode.com/problems/course-schedule-iii/',
  'Course Schedule III',
  'Hard', false,
  'Weighted interval scheduling (greedy + heap)',
  'Sort by deadline; greedily add each course; if total duration exceeds deadline, evict the longest course seen — Hard because evicting the longest rather than the current course is non-obvious'),

(6, 30, 'Hard', '1235',
  'https://leetcode.com/problems/maximum-profit-in-job-scheduling/',
  'Maximum Profit in Job Scheduling',
  'Hard', false,
  'Weighted interval scheduling (DP + binary search)',
  'Sort by end; dp[i] = max profit using first i jobs; for job i, binary search for last non-conflicting job — Hard because recognizing this as DP-on-intervals (not greedy) and setting up the binary search transition correctly'),

(6, 31, 'Hard', '2054',
  'https://leetcode.com/problems/two-best-non-overlapping-events/',
  'Two Best Non-Overlapping Events',
  'Med', false,
  'Weighted interval scheduling (k=2, DP)',
  'Sort by end; suffix max of values; for each event, binary search for last non-overlapping event before it'),

(6, 32, 'Hard', '2008',
  'https://leetcode.com/problems/maximum-earnings-from-taxi/',
  'Maximum Earnings From Taxi',
  'Med', false,
  'Weighted interval scheduling disguised as taxi rides',
  'Same DP as #1235; recognize rides as weighted intervals with start, end, tip'),

(6, 33, 'Hard', null,
  null,
  'Offline Stabbing Queries (Custom)',
  null, false,
  'Offline stabbing queries',
  'Sort events: interval starts as +1, ends as −1, queries interleaved by coordinate. Sweep left to right maintaining a running count — this is the canonical offline stabbing pattern and the building block of all sweep-line problems.'),

(6, 34, 'Hard', '2213',
  'https://leetcode.com/problems/longest-substring-of-one-repeating-character/',
  'Longest Substring of One Repeating Character',
  'Hard', false,
  'Segment tree on intervals of same characters',
  'Updates split/merge intervals of identical characters in a segment tree — Hard because it is not obvious that character-run intervals can be maintained in a segment tree with merge operations'),

(6, 35, 'Hard', null,
  null,
  'CF 981E / Count Good Numbers (Digit DP disguise)',
  'Hard', false,
  '⚠️ Interval framing trap',
  'Trap: "count integers in a range" looks like a sweep or interval cover but is digit DP — recognize the digit-structure before reaching for interval techniques'),

(6, 36, 'Hard', '228',
  'https://leetcode.com/problems/summary-ranges/',
  'Summary Ranges',
  'Med', false,
  'Consecutive range compression',
  'Compress a sorted array into [a,b] intervals; deceptively simple but tests clean interval construction and edge cases'),

(6, 37, 'Hard', '763',
  'https://leetcode.com/problems/partition-labels/',
  'Partition Labels',
  'Med', false,
  'Implicit interval from last occurrence',
  'Last occurrence of each character defines its interval; merge these intervals — the insight is building the intervals from character positions, not receiving them as input'),

(6, 38, 'Hard', '2015',
  'https://leetcode.com/problems/average-height-of-buildings-in-each-segment/',
  'Average Height of Buildings in Each Segment',
  'Med', true,
  'Sweep line output as interval list',
  'Events compress consecutive equal-average segments into output intervals'),

-- ── Layer 5: Trap ─────────────────────────────────────────────────────────────
(6, 39, 'Trap', null,
  null,
  'Merge Intervals on Circular Range',
  null, false,
  '⚠️ Standard merge fails at wrap-around',
  'Standard sort-by-start merge fails at the wrap point (e.g., [350°, 10°]). Fix: split at 0/MAX boundary, apply standard merge on each half, then handle the junction separately.'),

(6, 40, 'Trap', '1353',
  'https://leetcode.com/problems/maximum-number-of-events-that-can-be-attended/',
  'Maximum Number of Events That Can Be Attended',
  'Med', false,
  '⚠️ Looks like activity selection, is greedy + heap',
  'Sorting by end and greedy-keeping breaks because you can attend partial days; need a min-heap of end days processed day-by-day to always attend the earliest-ending available event'),

(6, 41, 'Trap', '2402',
  'https://leetcode.com/problems/meeting-rooms-iii/',
  'Meeting Rooms III',
  'Hard', false,
  '⚠️ Looks like Meeting Rooms II, is a simulation',
  'Peak overlap count does not answer which room is used most; need two heaps (free rooms + occupied rooms) — Hard because simulating room assignment order requires careful priority between earliest-ending and lowest-index rooms'),

(6, 42, 'Trap', '1272',
  'https://leetcode.com/problems/remove-interval/',
  'Remove Interval',
  'Med', false,
  '⚠️ Remove (not merge) an interval from a set',
  'Three cases: left remainder, right remainder, complete removal. Easy to miss partial-overlap cases and produce wrong output intervals.'),

(6, 43, 'Trap', '759',
  'https://leetcode.com/problems/employee-free-time/',
  'Employee Free Time (Trap Variant)',
  'Hard', true,
  '⚠️ Free time ≠ complement of one interval',
  'Must merge all employee intervals globally first, not per-employee. Per-employee merge silently misses overlaps across workers and produces incorrect free-time windows.');
