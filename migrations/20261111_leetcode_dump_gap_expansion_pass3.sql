-- Third focused gap pass: orthogonal empty rectangles and cross-pattern integrations.
begin;

update public.topic_content
set sub_variants = sub_variants || '["Paired-character trie: encode simultaneous prefix and suffix characters on each edge"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Count prior words that are simultaneously a prefix and suffix of the current word","breaks_when":"The alphabet/paired edge encoding is too large or only one prefix/suffix query is required","sub_variant":"At depth j, use edge key (word[j], word[len−1−j]); a path exists exactly while both prefix and suffix characters match"}]'::jsonb,
core_idea = core_idea || E'\n\nPaired-character trie: to index words that are both a prefix and suffix of a query word, consume the query from both ends simultaneously. At depth j, the trie edge is the ordered pair (s[j], s[n−1−j]); each node counts previously inserted words whose paired prefix reaches that depth. This encodes two constraints in one trie path and avoids separately matching every prefix against every suffix.'
where topic_id=18
and not (sub_variants @> '["Paired-character trie: encode simultaneous prefix and suffix characters on each edge"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '["Cyclic-string rotation counting via KMP/Z occurrence detection and a two-class transition recurrence"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"One operation rotates a string by a non-zero suffix shift; count operation sequences of exactly k steps that reach a target","breaks_when":"The operation permits only a restricted set of shifts or the state graph is not rotation-symmetric","sub_variant":"Use KMP/Z on s+s to count target rotation offsets; symmetry groups offsets into target and non-target classes, yielding a small transition recurrence that can be exponentiated"}]'::jsonb,
core_idea = core_idea || E'\n\nCyclic rotation counting: first use KMP/Z on s+s to count the offsets at which t is a rotation of s. Then exploit translation symmetry of the cyclic group: from any offset, every non-zero shift is available, so states can be grouped by whether they are one of the target offsets or not. Count transitions between these two classes and exponentiate the resulting 2×2 recurrence for large k. This combines string matching with a small state-transition DP; it is not a general dense matrix over all n rotations.'
where topic_id=46
and not (sub_variants @> '["Cyclic-string rotation counting via KMP/Z occurrence detection and a two-class transition recurrence"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '["Prefix balance plus modular length class: equal-count substrings whose common count satisfies a square-divisibility condition"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Count substrings with equal counts of two symbol classes and a product/divisibility condition on the common count","breaks_when":"The allowed common counts are not a set of multiples or cannot be enumerated compactly from the modulus","sub_variant":"Find the least m with k dividing m²; valid common counts are multiples of m. Pair equal prefix balances whose index difference is 0 modulo 2m"}]'::jsonb,
core_idea = core_idea || E'\n\nBalanced substring with a square-divisibility length constraint: equal vowel and consonant counts mean a substring of length 2x with x occurrences of each class. The product condition k | x² implies x must be a multiple of m=∏p^{ceil(e_p/2)} when k=∏p^{e_p}. Thus valid substring lengths are multiples of 2m. Track prefix balance (vowels−consonants) and index modulo 2m; two prefixes with equal balance and equal index residue define a valid substring. This combines factorisation with a prefix-state hash map.'
where topic_id=7
and not (sub_variants @> '["Prefix balance plus modular length class: equal-count substrings whose common count satisfies a square-divisibility condition"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '["Independent infection fronts in line segments: binomial interleavings and powers-of-two internal choices"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Infection spreads one position per step from already infected neighbours, and count all possible infection orders","breaks_when":"Infection can jump, propagation speed differs, or the graph is not a path/independent segment structure","sub_variant":"Decompose healthy gaps between initial sources; interleave gap completion sequences with binomial coefficients, and account for the two possible fronts inside each internal gap"}]'::jsonb,
core_idea = core_idea || E'\n\nInfection-order counting on a line: initial infected positions split the healthy cells into independent gaps. Each gap contributes a fixed number of internal orders; an internal gap can be filled from either end, giving a 2^{gap−1} factor, while the orders from different gaps can be interleaved with multinomial/binomial coefficients. Multiply local gap factors and global interleaving counts modulo p.'
where topic_id=41
and not (sub_variants @> '["Independent infection fronts in line segments: binomial interleavings and powers-of-two internal choices"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '["Maximum empty axis-aligned rectangle with point-set exclusion via sweep line and orthogonal range queries"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"Choose four input points as axis-aligned rectangle corners, maximise area, and require no other point on or inside the rectangle","breaks_when":"Point count is small enough for direct enumeration or boundary-touching semantics differ","sub_variant":"Sort by x and maintain ordered y-boundary pairs; use a range structure to find the nearest compatible later x and verify no forbidden point lies in the rectangle"}]'::jsonb,
core_idea = core_idea || E'\n\nEmpty rectangle search over point sets: the challenge is not computing width×height but proving that no other point lies on or inside the candidate rectangle. Sort points by x; a candidate is determined by two y-boundaries that are consecutive among points at a relevant x. Maintain the nearest future x that can support the same y-interval using a segment/Fenwick-style range structure. This is an orthogonal range-exclusion problem and differs from union-area sweep lines.'
where topic_id=48
and not (sub_variants @> '["Maximum empty axis-aligned rectangle with point-set exclusion via sweep line and orthogonal range queries"]'::jsonb);

insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(48,19,'Hard','3382','https://leetcode.com/problems/maximum-area-rectangle-with-point-constraints-ii/','Maximum Area Rectangle With Point Constraints II','Hard',false,'Maximum empty rectangle via orthogonal range queries','Sort points by x. For each x, consider consecutive y-pairs that can form horizontal sides; use a range structure to find the nearest future x supporting the same pair while proving there are no points on or inside the candidate rectangle. The key invariant is the nearest valid right boundary, not simply detecting four corners. This is a constrained empty-rectangle sweep and is distinct from rectangle union area.',true,'combination','Empty rectangles and orthogonal range queries',7,1),
(18,26,'Variants','3045','https://leetcode.com/problems/count-prefix-and-suffix-pairs-ii/','Count Prefix and Suffix Pairs II','Hard',false,'Paired-character trie','Insert each word from both ends simultaneously: at depth j, follow an edge keyed by the pair (word[j], word[len−1−j]). Each trie node counts previously inserted words with that paired prefix; when the current word ends, add the terminal count. This makes the prefix and suffix conditions hold at the same lengths and avoids pairwise string comparisons.',false,'optional_reference',null,null,null),
(46,10,'Hard','2851','https://leetcode.com/problems/string-transformation/','String Transformation','Hard',false,'KMP rotation matches plus two-class transition DP','Use KMP/Z on s+s to count the rotation offsets matching t. Since each operation applies any non-zero cyclic shift, all target offsets are symmetric and all non-target offsets are symmetric. Derive a 2-state recurrence for counts in the target/non-target classes and exponentiate it for k operations. The symmetry reduction is what prevents an O(n²) transition matrix.',false,'optional_reference',null,null,null),
(7,31,'Hard','2949','https://leetcode.com/problems/count-beautiful-substrings-ii/','Count Beautiful Substrings II','Hard',false,'Prefix balance plus modular length class','Equal vowels and consonants imply length 2x. The product condition requires k|x², so factor k and compute m=∏p^ceil(e/2); x must be a multiple of m. Count pairs of prefixes with equal vowel-minus-consonant balance and equal index modulo 2m. This combines a number-theory reduction with a prefix-state map.',false,'optional_reference',null,null,null),
(41,21,'Hard','2954','https://leetcode.com/problems/count-the-number-of-infection-sequences/','Count the Number of Infection Sequences','Hard',false,'Combinatorial interleaving of independent infection gaps','Initially infected positions split the healthy positions into gaps. Each gap contributes an internal ordering; an internal gap can be filled from either end, giving 2^(gap−1) possibilities. Interleave the infection orders of the gaps using binomial/multinomial coefficients. The proof separates independent local growth from global interleavings.',false,'optional_reference',null,null,null)
on conflict (topic_id,order_num) do nothing;

update public.topics set summary_meta='26 problems · standard, XOR, wildcard, trie+DP, Aho–Corasick, persistent and paired-character tries' where id=18;
update public.topics set summary_meta='10 problems · rolling hash, suffix arrays, LCP, suffix automata, Manacher, weighted segmentation, hash-DP and cyclic rotations' where id=46;
update public.topics set summary_meta='31 problems · range aggregates, difference arrays, prefix-state counting, 2D methods and modular-length prefix classes' where id=7;
update public.topics set summary_meta='21 problems · counting DP mod p, nCr, Stirling, Catalan, inclusion-exclusion, stars and bars, ranking and infection gaps' where id=41;
update public.topics set summary_meta='19 problems · predicates, polygons, hulls, closest pair, sweeps, circles, Manhattan transforms and empty rectangles' where id=48;

commit;
