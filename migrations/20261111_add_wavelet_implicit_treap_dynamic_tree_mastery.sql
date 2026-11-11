-- Advanced static range structures and dynamic tree query exercises.
-- Applied to production Supabase on 2026-11-11. Idempotent; preserves existing problem identities.
begin;

insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(12,21,'Hard',null,null,'Wavelet Matrix — K-th Smallest and Frequency Queries in Static Ranges','Hard',false,'Stable partition by value bits','At each value bit, stably partition the sequence and record zero-prefix counts and the zero boundary. For [l,r), count zeros to decide whether k-th descends into zero/one partition, remapping interval each level. Supports k-th, count less-than and frequency in O(log σ) after O(n log σ) build. State indexing conventions and distinguish Wavelet Matrix from pointer-heavy Wavelet Tree.',true,'core_pattern','Advanced static range order statistics and sequence trees',6,1),
(12,22,'Hard',null,null,'Implicit Treap — Dynamic Sequence with Split, Merge and Lazy Reversal','Hard',false,'Randomized implicit-key BST','Each node stores subtree size and priority; in-order position is implicit. Split(root,k) returns first k elements and remainder; merge preserves heap priority. Isolate [l,r] with two splits, apply lazy reversal/aggregate, and merge back. Explain expected O(log n), push/pull invariants and priority randomness.',true,'combination','Advanced static range order statistics and sequence trees',6,2),
(17,50,'Hard',null,null,'Link-Cut Tree — Dynamic Forest Path Queries','Hard',false,'Splay-based preferred-path decomposition','Maintain auxiliary splay trees for preferred paths and represented-tree parent pointers. access(x) exposes root-to-x; makeroot(x) reverses it; link/cut modify represented edges. After makeroot(u), access(v), the splay at v represents path u→v and stores its aggregate. Explain path-parent versus splay-parent, lazy reversal and amortised O(log n).',true,'core_pattern','Dynamic forests and advanced path queries',8,1),
(17,51,'Hard',null,null,'K-th Smallest Value on a Tree Path — Persistent Roots + LCA','Hard',false,'Persistent root-to-node frequency trees','Coordinate-compress values. Build one persistent frequency root per vertex by copying its parent root and inserting the vertex value. For path u→v with w=LCA(u,v), combine root[u]+root[v]−root[w]−root[parent(w)]. Descend by left-count differences for k-th smallest in O(log σ); prove the multiset identity and handle root(w).',true,'combination','Dynamic forests and advanced path queries',8,2)
on conflict (topic_id,order_num) do nothing;

update public.topic_content
set sub_variants=sub_variants || '["Wavelet Tree / Wavelet Matrix for static range k-th, count-less-than and frequency queries","Implicit Treap for dynamic sequence split/merge, reversal and range aggregates"]'::jsonb,
 core_idea=core_idea || E'\n\nAdvanced range structures: A Wavelet Matrix stably partitions values by bits and remaps query intervals at each level for O(log σ) static order-statistic queries. An implicit treap is a randomized BST whose in-order sequence is the array; subtree sizes provide implicit indices, while split/merge and lazy tags support sequence edits in expected O(log n).',
 why_it_matters=why_it_matters || E'\n\nThe range-query path now includes static order statistics beyond merge-sort trees and persistent segment trees, plus implicit sequence trees for split/merge and lazy transformations.'
where topic_id=12 and not (sub_variants @> '["Wavelet Tree / Wavelet Matrix for static range k-th, count-less-than and frequency queries"]'::jsonb);

update public.topic_content
set sub_variants=sub_variants || '["Link-Cut Tree for dynamic forest link/cut and path aggregates","Persistent root-to-node frequency trees plus LCA inclusion-exclusion for path k-th queries"]'::jsonb,
 core_idea=core_idea || E'\n\nDynamic and order-statistic tree queries: Link-Cut Trees maintain a changing forest with amortised logarithmic link, cut and path operations using splay-based preferred paths. For static path k-th queries, persistent root-to-node frequency trees combine as root[u]+root[v]−root[lca]−root[parent(lca)], then descend by count differences.',
 why_it_matters=why_it_matters || E'\n\nThe tree path now includes dynamic topology (link/cut) and a persistent order-statistic construction for path queries, beyond static HLD and binary lifting.'
where topic_id=17 and not (sub_variants @> '["Link-Cut Tree for dynamic forest link/cut and path aggregates"]'::jsonb);

commit;
