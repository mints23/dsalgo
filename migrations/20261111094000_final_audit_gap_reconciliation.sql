-- Final reconciliation of the LeetCode dump audit against the live curriculum.
-- Add only net-new value: LC 1960 as a required Manacher composition and
-- LC 3515 as an optional Euler-tour/Fenwick transfer reference.
-- LC 489 and LC 1982 were already present from Pass 6; LC 3352 overlaps the
-- existing binary digit-DP / popcount-budget coverage and is intentionally excluded.
begin;

-- Topic 46: Manacher radii combined with boundary sweeps and split maxima.
update public.topic_content
set
  sub_variants = case
    when sub_variants @> '["Manacher radii + boundary sweeps + prefix/suffix maxima for disjoint odd palindromes"]'::jsonb
      then sub_variants
    else sub_variants || '["Manacher radii + boundary sweeps + prefix/suffix maxima for disjoint odd palindromes"]'::jsonb
  end,
  pattern_triggers = case
    when pattern_triggers @> '[{"trigger":"Maximise the product of two non-overlapping odd-length palindromic substrings"}]'::jsonb
      then pattern_triggers
    else pattern_triggers || jsonb_build_array(jsonb_build_object(
      'trigger','Maximise the product of two non-overlapping odd-length palindromic substrings',
      'breaks_when','The objective permits even-length palindromes only, or requires more than two disjoint intervals with a different global optimisation state',
      'sub_variant','Run Manacher for odd radii, sweep each centre contribution toward its left/right boundary, build best palindrome lengths for every prefix and suffix, then evaluate every split'
    ))
  end,
  core_idea = case
    when position('Manacher with non-overlapping prefix/suffix optimisation' in core_idea) > 0 then core_idea
    else core_idea || E'\n\nManacher with non-overlapping prefix/suffix optimisation (LC 1960): Manacher computes the maximum odd-palindrome radius at every centre in O(n). Every pair of disjoint palindromes is separated by a cut. Convert centre radii into the longest palindrome available at each boundary using inward boundary sweeps (a palindrome can shrink by two characters as its boundary moves one position toward its centre), then take prefix maxima and suffix maxima. Evaluate max(leftBest[i] * rightBest[i+1]) over every split. This avoids enumerating O(n^2) palindromic intervals and runs in O(n) time and O(n) space.'
  end
where topic_id = 46;

-- Topic 38: dynamic root-to-node distances under edge-weight updates.
update public.topic_content
set
  sub_variants = case
    when sub_variants @> '["Euler-tour subtree range-add + Fenwick point-query for dynamic root distances"]'::jsonb
      then sub_variants
    else sub_variants || '["Euler-tour subtree range-add + Fenwick point-query for dynamic root distances"]'::jsonb
  end,
  pattern_triggers = case
    when pattern_triggers @> '[{"trigger":"Edge weights in a rooted tree change online and queries ask for the current distance from the root to a node"}]'::jsonb
      then pattern_triggers
    else pattern_triggers || jsonb_build_array(jsonb_build_object(
      'trigger','Edge weights in a rooted tree change online and queries ask for the current distance from the root to a node',
      'breaks_when','Queries ask arbitrary node-to-node paths or topology changes; use LCA/HLD or a dynamic-tree structure as appropriate',
      'sub_variant','Root the tree and Euler-tour it. An edge update changes every root distance in the child subtree by delta, so range-add [tin[child], tout[child]) and point-query tin[x] with a Fenwick difference tree'
    ))
  end,
  core_idea = case
    when position('Dynamic root-distance queries with Euler-tour Fenwick updates' in core_idea) > 0 then core_idea
    else core_idea || E'\n\nDynamic root-distance queries with Euler-tour Fenwick updates (LC 3515): root the tree once, compute tin/tout and each node’s initial root distance. For an updated parent-child edge, let delta = newWeight − oldWeight. Every node in the child subtree has its root distance changed by delta, so perform a range add on [tin[child], tout[child]) using a Fenwick difference array. A query for node x is initialDistance[x] plus the Fenwick point query at tin[x]. Preprocessing is O(n); each update and query is O(log n). This technique relies on fixed tree topology and root-to-node queries; arbitrary u-to-v path queries require an LCA/HLD-style extension.'
  end
where topic_id = 38;

-- LC 1960 is a required advanced-string composition after the custom Manacher foundation.
insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
select
  46,11,'Hard','1960',
  'https://leetcode.com/problems/maximum-product-of-the-length-of-two-palindromic-substrings/',
  'Maximum Product of the Length of Two Palindromic Substrings','Hard',false,
  'Manacher radii + boundary sweeps + prefix/suffix maxima for disjoint odd palindromes',
  'Manacher computes the maximum odd-palindrome radius at every centre. Sweep those radii toward each boundary to derive the best palindrome available in every prefix and suffix, then evaluate every split: max(leftBest[i] × rightBest[i+1]). The boundary sweep propagates shrinking odd palindromes without enumerating all O(n²) intervals, yielding O(n) time and O(n) space.',
  true,'combination','Palindrome radii and linear-time structure',4,2
where not exists (select 1 from public.problems where lc_number = '1960');

-- LC 3515 is useful transfer practice, but the underlying Fenwick/Euler-tour
-- primitives already exist, so it remains optional rather than a new core path.
insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
select
  38,36,'Hard','3515',
  'https://leetcode.com/problems/shortest-path-in-a-weighted-tree/',
  'Shortest Path in a Weighted Tree','Hard',false,
  'Euler-tour subtree range-add + Fenwick point-query for dynamic root distances',
  'Root the tree and compute Euler tin/tout plus initial root distances. Updating a parent-child edge by delta changes every root distance in the child subtree, so range-add delta over [tin[child], tout[child]) in a Fenwick difference tree. A root-to-node query returns initialDistance[x] plus the point query at tin[x]. O(log n) per update/query after O(n) preprocessing.',
  false,'optional_reference',null,null,null
where not exists (select 1 from public.problems where lc_number = '3515');

update public.topics
set summary_meta = '36 problems · 5 stages · DFS return states, rerooting, tree knapsack, centroid/DSU-on-tree, virtual trees and dynamic root-distance queries'
where id = 38;

update public.topics
set summary_meta = '11 problems · rolling hash, suffix arrays, LCP, suffix automata, Manacher, weighted segmentation, hash-DP, cyclic rotations and disjoint-palindrome sweeps'
where id = 46;

do $$
declare seq_name text;
begin
  seq_name := pg_get_serial_sequence('public.problems','id');
  if seq_name is not null then
    perform setval(seq_name, greatest((select coalesce(max(id),1) from public.problems), 1), true);
  end if;
end $$;

commit;
