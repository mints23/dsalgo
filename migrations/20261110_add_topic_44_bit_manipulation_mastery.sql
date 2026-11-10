-- Applied to production Supabase on 2026-11-10.
-- Adds the first new mastery topic without changing existing problem identities/progress.
begin;

insert into public.topics
(id,display_number,show_in_sidebar,nav_section,nav_label,nav_tier_dot_color,title,tier_code,tier_label,type_label,summary_meta,topbar_meta,is_free,body_html)
values
(44,'42',true,'Advanced Techniques','Bit Manipulation & Bitmask','#a13544',
 'Bit Manipulation & Bitmask Techniques','T4','Advanced',
 'Bitwise Algebra · XOR · Subset Enumeration · Bitmask DP · SOS DP · Bitsets',
 '18 required problems · bitwise reasoning, subset states, SOS DP and bitset optimisation',
 'Advanced Techniques · Bit Manipulation',false,
 '<div class="info-box"><strong>Why It Matters:</strong> Bit operations provide compact, fast representations for sets and finite states. They are foundational for XOR reasoning, subset enumeration, bitmask DP and high-performance algorithms.</div>
 <div class="core-box"><strong>Core model</strong><br>Represent a subset of n elements by an n-bit integer. Learn bitwise algebra first, then subset iteration, then DP over masks and transforms over all subsets.</div>
 <div class="sec-title">Sub-Variants</div><div class="pill-grid"><span class="pill">Bitwise algebra</span><span class="pill">XOR invariants</span><span class="pill">Bit counting</span><span class="pill">Range AND</span><span class="pill">Subset enumeration</span><span class="pill">Submask enumeration</span><span class="pill">Gray code</span><span class="pill">Bitmask DP</span><span class="pill">SOS DP</span><span class="pill">Bitset acceleration</span></div>
 <div class="warn-box"><strong>Java pitfalls:</strong> use 1L &lt;&lt; bit for long masks; distinguish &gt;&gt; from &gt;&gt;&gt;; check mask width and signed-bit behaviour.</div>');

insert into public.topic_content(topic_id,why_it_matters,core_idea,sub_variants,pattern_triggers,coverage_problems,red_flags)
values (44,
'Bit operations provide compact, fast representations for sets and finite states. They are central to XOR problems, subset enumeration, exponential-state DP, graph-state search and subset-sum optimisation.',
'A bitmask is an integer whose bits encode membership or Boolean state. Correct solutions depend on algebraic identities, a precise universe size, and understanding signed machine-word semantics. Advanced techniques build on this representation: enumerate submasks, compress DP states, apply SOS transforms, and process many Boolean states using bitsets.',
'["Bitwise AND/OR/XOR/NOT and shifts","Set, clear, toggle and test a bit","XOR cancellation and prefix XOR","Population count and Brian Kernighan","Common-prefix range AND","Subset and submask enumeration","Gray-code ordering","Bitmask state compression and assignment DP","SOS DP / subset zeta transform","Bitset shift-OR subset sum","Java signed integer and long-mask semantics"]'::jsonb,
'["Each item is a feature in a small fixed universe","The state is a subset of at most roughly 20 elements","The operation is naturally XOR or bitwise aggregation","Need to enumerate all submasks of a mask","Need aggregate values over all submasks or supersets","A Boolean DP can be accelerated by machine-word parallelism"]'::jsonb,
'["LC 136 Single Number","LC 137 Single Number II","LC 260 Single Number III","LC 191 Number of 1 Bits","LC 338 Counting Bits","LC 201 Bitwise AND of Numbers Range","LC 231 Power of Two","LC 342 Power of Four","LC 421 Maximum XOR of Two Numbers in an Array","LC 898 Bitwise ORs of Subarrays","LC 1318 Minimum Flips to Make a OR b Equal to c","LC 1863 Sum of All Subset XOR Totals","LC 1879 Minimum XOR Sum of Two Arrays","LC 1125 Smallest Sufficient Team","LC 1681 Minimum Incompatibility","Custom SOS DP and bitset subset sum"]'::jsonb,
'["Using 1 << i when i may reach or exceed 31 in Java","Confusing signed right shift with unsigned right shift","Assuming XOR is interchangeable with OR","Enumerating all masks when only submasks are needed","Using bitmask DP when n is too large for O(2^n) memory/time","Ignoring duplicate values or sign extension in bit tricks"]'::jsonb);

insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(44,1,'Foundation','136','https://leetcode.com/problems/single-number/','Single Number','Easy',false,'XOR cancellation','a XOR a = 0 and a XOR 0 = a; XOR is associative and commutative, so paired values cancel independent of order.',true,'core_pattern','Bitwise foundations',1,1),
(44,2,'Foundation','191','https://leetcode.com/problems/number-of-1-bits/','Number of 1 Bits','Easy',false,'Brian Kernighan bit counting','n & (n - 1) removes the least significant set bit; the number of iterations equals popcount(n).',true,'core_pattern','Bitwise foundations',1,2),
(44,3,'Foundation','231','https://leetcode.com/problems/power-of-two/','Power of Two','Easy',false,'Single-set-bit invariant','A positive power of two has exactly one set bit, so n > 0 and (n & (n - 1)) == 0.',true,'variant','Bitwise foundations',1,3),
(44,4,'Foundation','338','https://leetcode.com/problems/counting-bits/','Counting Bits','Easy',false,'Popcount recurrence','popcount(i) = popcount(i >> 1) + (i & 1); alternatively dp[i] = dp[i & (i - 1)] + 1.',true,'variant','Bitwise foundations',1,4),
(44,5,'Variants','260','https://leetcode.com/problems/single-number-iii/','Single Number III','Medium',false,'Partition by lowest differing bit','XOR all values to obtain x XOR y; isolate one differing bit to partition the two unique values.',true,'variant','XOR and bit invariants',2,1),
(44,6,'Variants','137','https://leetcode.com/problems/single-number-ii/','Single Number II','Medium',false,'Bit counts modulo three','Count each bit across values modulo 3; the remaining bit vector is the unique value.',true,'variant','XOR and bit invariants',2,2),
(44,7,'Variants','201','https://leetcode.com/problems/bitwise-and-of-numbers-range/','Bitwise AND of Numbers Range','Medium',false,'Common-prefix range AND','The range AND retains only the common binary prefix of both bounds.',true,'variant','XOR and bit invariants',2,3),
(44,8,'Variants','342','https://leetcode.com/problems/power-of-four/','Power of Four','Easy',false,'Bit position constraint','A power of four has one set bit in an even zero-based position; combine a single-bit test with an alternating-bit mask.',true,'variant','XOR and bit invariants',2,4),
(44,9,'Variants','1318','https://leetcode.com/problems/minimum-flips-to-make-a-or-b-equal-to-c/','Minimum Flips to Make a OR b Equal to c','Medium',false,'Per-bit truth-table reasoning','When c has 0, clear every set input bit; when c has 1, at least one input bit must be set.',true,'variant','XOR and bit invariants',2,5),
(44,10,'Variants','898','https://leetcode.com/problems/bitwise-ors-of-subarrays/','Bitwise ORs of Subarrays','Medium',false,'Compressed suffix-state set','Extend distinct OR values of subarrays ending at the previous index; bits only change from 0 to 1, bounding the set size.',true,'combination','Subset and state techniques',3,1),
(44,11,'Variants','1863','https://leetcode.com/problems/sum-of-all-subset-xor-totals/','Sum of All Subset XOR Totals','Easy',false,'Per-bit subset contribution','Each bit present in any input contributes to exactly half of all subset XOR totals; derive the closed form.',true,'combination','Subset and state techniques',3,2),
(44,12,'Hard','421','https://leetcode.com/problems/maximum-xor-of-two-numbers-in-an-array/','Maximum XOR of Two Numbers in an Array','Medium',false,'Greedy bit construction / binary trie','Construct the answer from the most significant bit downward by testing whether two prefixes can differ at that bit.',true,'combination','Subset and state techniques',3,3),
(44,13,'Hard','1879','https://leetcode.com/problems/minimum-xor-sum-of-two-arrays/','Minimum XOR Sum of Two Arrays','Hard',false,'Assignment DP over used-index mask','Pair the next element with an unused index; the mask records assignments and gives O(n·2^n) transitions.',true,'combination','Subset and state techniques',3,4),
(44,14,'Hard','1125','https://leetcode.com/problems/smallest-sufficient-team/','Smallest Sufficient Team','Hard',false,'Set-cover bitmask DP','Encode required skills as bits and update the best team for each covered-skill mask.',true,'combination','Subset and state techniques',3,5),
(44,15,'Hard','1681','https://leetcode.com/problems/minimum-incompatibility/','Minimum Incompatibility','Hard',false,'Subset partition DP','Precompute valid size-k subsets, then partition the full mask while fixing one canonical element to avoid permutation duplicates.',true,'combination','Subset and state techniques',3,6),
(44,16,'Hard',null,null,'SOS DP — Subset Zeta Transform and Inversion','Hard',false,'Aggregate f[submask] for every mask','For each bit, propagate aggregates from masks without that bit to masks with it; prove O(n·2^n) and derive inverse Möbius transform.',true,'optimization','Subset transforms and bitset acceleration',4,1),
(44,17,'Hard',null,null,'Bitset Subset Sum — Shift-OR DP','Hard',false,'Machine-word parallel subset-sum transitions','Represent reachable sums as bits; reachable |= reachable << value processes many Boolean states per machine-word operation.',true,'optimization','Subset transforms and bitset acceleration',4,2),
(44,18,'Hard',null,null,'Submask Enumeration and Gray-Code Iteration','Hard',false,'Enumerate subsets with controlled transition cost','Use sub = (sub - 1) & mask for all submasks and Gray code for one-bit transitions; derive O(2^k) and O(3^n) bounds.',true,'mastery_assessment','Subset transforms and bitset acceleration',4,3);

commit;
