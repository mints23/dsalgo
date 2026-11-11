-- Offline query and square-root decomposition curriculum expansion.
-- Applied to production Supabase on 2026-11-11. Idempotent; preserves problem identities.
begin;

insert into public.topics
(id,display_number,show_in_sidebar,nav_section,nav_label,nav_tier_dot_color,title,tier_code,tier_label,type_label,summary_meta,topbar_meta,body_html,is_free)
values
(47,'47',true,'Advanced Techniques','Offline Queries & Sqrt Decomposition','#da7101','Offline Queries & Square-Root Decomposition','T4','Advanced','Mo''s Algorithm · Block Decomposition · Rollback · Parallel Binary Search','10 problems · Mo ordering, updates in time, tree queries, block summaries, rollback DSU and parallel binary search','Advanced Techniques · Offline Queries & Sqrt Decomposition','',false)
on conflict (id) do update set
 display_number=excluded.display_number,show_in_sidebar=excluded.show_in_sidebar,nav_section=excluded.nav_section,
 nav_label=excluded.nav_label,nav_tier_dot_color=excluded.nav_tier_dot_color,title=excluded.title,
 tier_code=excluded.tier_code,tier_label=excluded.tier_label,type_label=excluded.type_label,
 summary_meta=excluded.summary_meta,topbar_meta=excluded.topbar_meta,is_free=excluded.is_free;

insert into public.topic_content
(topic_id,why_it_matters,core_idea,sub_variants,pattern_triggers,coverage_problems,red_flags)
values
(47,
'Offline processing lets you reorder known queries for efficient state transitions. Mo''s algorithm moves a maintained interval; square-root decomposition trades work across blocks; rollback structures support divide-and-conquer over time; parallel binary search batches monotone answer searches.',
'If answers need not be online, sort or batch queries by a key that makes transitions cheap. Mo sorts [L,R] queries into blocks and moves a current interval with add/remove operations. With point updates, add a time coordinate. Square-root decomposition stores block summaries and lazy tags. For offline dynamic connectivity, place edge lifetimes on a segment tree over time and use rollback DSU. For parallel binary search, bucket queries by midpoint and sweep events with a monotone structure.',
'["Classic Mo''s algorithm for static range queries","Alternating right endpoint and Hilbert ordering","Mo with modifications / time dimension","Mo on trees after Euler-tour flattening","Square-root decomposition for range query and point update","Lazy block tags for range add and range sum","Block frequency tables and heavy-hitter verification","Per-block offsets for range movement operations","Rollback DSU with snapshots","Segment tree over time for offline dynamic connectivity","Parallel binary search over monotone answer predicates"]'::jsonb,
'[{"trigger":"All range queries are known and interval state supports add/remove","breaks_when":"Queries are online or transitions are expensive","sub_variant":"Mo''s algorithm with sqrt-sized blocks"},{"trigger":"Range queries include point modifications and can be reordered","breaks_when":"Updates depend on previous answers","sub_variant":"Three-dimensional Mo with time coordinate"},{"trigger":"Subtree/path queries can be represented by Euler intervals","breaks_when":"Path query needs an unhandled LCA correction","sub_variant":"Mo on tree Euler order with parity toggles when needed"},{"trigger":"Range queries and updates admit block summaries","breaks_when":"Fenwick/segment tree gives simpler online logarithmic operations","sub_variant":"Square-root blocks with lazy tags"},{"trigger":"Find a range majority/heavy hitter","breaks_when":"A direct exact frequency structure is feasible","sub_variant":"Boyer–Moore block candidates plus exact verification"},{"trigger":"Edges have active time intervals and connectivity is queried at times","breaks_when":"Only insertions occur online","sub_variant":"Segment tree over time plus rollback DSU"},{"trigger":"Find first threshold where a monotone condition becomes true","breaks_when":"Predicate is not monotone","sub_variant":"Parallel binary search and offline event sweep"}]'::jsonb,
'["CSES 1734 Distinct Values Queries","CF 86D Powerful Array","CF 617E XOR and Favorite Number","CF 940F Machine Learning","CF 455D Serega and Fun","CF 1514D Cut and Stick","Custom Mo on Tree Subtree Queries","Custom Parallel Binary Search for Connectivity Threshold","Custom Offline Dynamic Connectivity with Rollback DSU","Custom Range Add and Range Sum with Sqrt Blocks"]'::jsonb,
'["Derive Mo pointer movement and the cost of each add/remove.","For Mo with modifications, distinguish current time from interval endpoints and implement apply/rollback.","Rollback DSU must avoid path compression; use union by size and restore exact fields.","Segment tree over time stores each edge on nodes covering its active interval; snapshot before descent and rollback after.","Parallel binary search requires a monotone predicate and repeatable sweep state.","Block decomposition is a trade-off, not a universal replacement for Fenwick/segment trees."]'::jsonb)
on conflict (topic_id) do nothing;

insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(47,1,'Hard','CSES 1734','https://cses.fi/problemset/task/1734','Distinct Values Queries','Hard',false,'Classic Mo with frequency counts','Sort queries by left block and right endpoint. Maintain [L,R]; a value contributes one when its frequency crosses 0↔1. Derive pointer movement and compare alternating R order.',true,'core_pattern','Mo''s algorithm for static range queries',1,1),
(47,2,'Hard','CF 86D','https://codeforces.com/problemset/problem/86/D','Powerful Array','Hard',false,'Frequency-weighted aggregate','For answer Σ(x·freq[x]^2), adding x at frequency f changes answer by x(2f+1); removing is the inverse. Each pointer move is O(1); use long.',true,'variant','Mo''s algorithm for static range queries',1,2),
(47,3,'Hard','CF 617E','https://codeforces.com/problemset/problem/617/E','XOR and Favorite Number','Hard',false,'Mo over prefix-XOR indices','Convert [l,r] to prefix indices [l−1,r]. Maintain count[prefixXor]; adding x contributes count[x xor k] before incrementing count[x]. Handle k=0 and inclusive boundaries.',true,'combination','Mo''s algorithm for static range queries',1,3),
(47,4,'Hard','CF 940F','https://codeforces.com/problemset/problem/940/F','Machine Learning','Hard',false,'Three-dimensional Mo with point modifications','Represent queries as (L,R,time). Moving time applies/rolls back a point update; if its index is inside the interval, remove old and add new contribution. Coordinate-compress values and maintain the frequency statistic.',true,'combination','Mo with modifications and tree intervals',2,1),
(47,5,'Hard','CF 455D','https://codeforces.com/problemset/problem/455/D','Serega and Fun','Hard',false,'Square-root blocks with value summaries and lazy offsets','A range rotation shifts whole-block offsets lazily and explicitly moves boundary elements. Count queries sum block frequencies plus boundary scans. Rebuild/update summaries for touched blocks and map logical positions through offsets.',true,'core_pattern','Square-root block decomposition',3,1),
(47,6,'Hard','CF 1514D','https://codeforces.com/problemset/problem/1514/D','Cut and Stick','Hard',false,'Range majority candidate and exact verification','A strict majority is the only candidate that changes the answer from 1. Combine Boyer–Moore candidate/surplus summaries for full blocks, scan boundaries, then verify exact frequency with occurrence lists. If majority frequency f exists answer 2f−length.',true,'variant','Square-root block decomposition',3,2),
(47,7,'Hard',null,null,'Mo''s Algorithm on Tree Subtree Queries (Custom)','Hard',false,'Euler-tour flattening','Preorder Euler tour makes subtree(v) the interval [tin[v],tout[v]]. Process subtree queries with Mo and maintain the target statistic. For arbitrary paths use a doubled Euler tour, parity toggles and LCA correction.',true,'combination','Mo with modifications and tree intervals',2,2),
(47,8,'Hard',null,null,'Parallel Binary Search for First Connectivity Threshold (Custom)','Hard',false,'Batch monotone threshold searches with DSU sweep','For each query find the minimum edge weight threshold connecting u,v. Bucket unresolved queries by midpoint each round; sweep sorted edges with DSU, then shrink each answer interval. State no-solution sentinel and reset DSU each round.',true,'combination','Parallel binary search and offline event sweeps',4,1),
(47,9,'Hard',null,null,'Offline Dynamic Connectivity with Rollback DSU (Custom)','Hard',false,'Segment tree over time and rollback union-find','Convert edge lifetimes to intervals and add them to a segment tree over time. DFS the time tree with DSU snapshots, answer at leaves, and rollback. Use union by size without path compression; define duplicate-edge semantics.',true,'combination','Rollback data structures and dynamic connectivity',5,1),
(47,10,'Hard',null,null,'Range Add and Range Sum with Square-Root Blocks (Custom)','Hard',false,'Block sums plus lazy add tags','For range add, update boundary elements and lazy tags for full blocks. For range sum, scan boundaries and use blockSum+blockLength·lazy for full blocks. Derive O(sqrt(n)) and compare with lazy segment trees.',true,'variant','Square-root block decomposition',3,3)
on conflict (topic_id,order_num) do nothing;

do $$
declare seq_name text;
begin
  seq_name := pg_get_serial_sequence('public.topics','id');
  if seq_name is not null then
    perform setval(seq_name, greatest((select coalesce(max(id),1) from public.topics), 1), true);
  end if;
end $$;

commit;
