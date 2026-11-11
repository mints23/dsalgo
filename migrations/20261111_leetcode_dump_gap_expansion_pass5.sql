-- Fifth narrow decision pass: retain two valuable, distinct optional transfer exercises.
begin;

update public.topic_content
set sub_variants = sub_variants || '["Successor-pointer path compression for online forward-edge shortcuts"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"A directed path initially contains consecutive edges and each query adds a forward shortcut that removes the need to visit a contiguous interval of intermediate vertices","breaks_when":"Shortcut intervals can cross/nest arbitrarily in a way that reintroduces removed nodes or edges can point backwards","sub_variant":"Maintain next-unremoved pointers; when a shortcut skips vertices, link each skipped vertex to the next surviving vertex so every vertex is bypassed at most once"}]'::jsonb,
core_idea = core_idea || E'\n\nSuccessor-pointer path shortcutting: when forward shortcut queries bypass a contiguous run of vertices in an initially linear DAG, maintain the next still-relevant vertex after each position. Applying an edge u→v jumps directly to v and permanently bypasses the intermediate chain nodes; path-compress their successor pointers so later queries skip them in amortised near-constant time. The non-crossing/monotone query condition is essential: it guarantees a removed vertex never needs to become active again.'
where topic_id=20
and not (sub_variants @> '["Successor-pointer path compression for online forward-edge shortcuts"]'::jsonb);

update public.topic_content
set sub_variants = sub_variants || '["Orthogonal spiral self-intersection via bounded local configurations"]'::jsonb,
pattern_triggers = pattern_triggers || '[{"trigger":"An axis-aligned path turns 90 degrees in a fixed repeating order and segment lengths are given; determine whether the polyline crosses itself","breaks_when":"The path can reverse directions, turn angles vary, or the path is not constrained to a regular orthogonal spiral","sub_variant":"Only the current segment and a bounded number of previous segments can newly intersect; classify the immediate, one-gap and wrapped three-gap crossing configurations"}]'::jsonb,
core_idea = core_idea || E'\n\nOrthogonal spiral self-crossing: because directions rotate by 90 degrees after every segment, a new segment can only intersect a small set of recent segments. A constant-space scan checks three geometric configurations: crossing the segment two steps back; touching/crossing the segment three steps back after equality at the intervening edge; and the wrapped overlap/crossing involving the segment five steps back. The derivation depends on the fixed turn order; it is not a general segment-intersection algorithm.'
where topic_id=48
and not (sub_variants @> '["Orthogonal spiral self-intersection via bounded local configurations"]'::jsonb);

insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(20,41,'Hard','3244','https://leetcode.com/problems/shortest-distance-after-road-addition-queries-ii/','Shortest Distance After Road Addition Queries II','Hard',false,'Successor-pointer path compression for forward shortcuts','In an initially linear directed path, each added forward edge skips a contiguous chain of intermediate vertices. Maintain a successor pointer to the next vertex not yet bypassed; when a shortcut skips vertices, path-compress them to the destination. Under the non-crossing query guarantee, each vertex is removed from the active chain at most once, yielding near-linear total work. This is an optional transfer from successor-DSU interval pruning, not a new required BFS pattern.',false,'optional_reference',null,null,null),
(48,22,'Variants','335','https://leetcode.com/problems/self-crossing/','Self Crossing','Hard',false,'Orthogonal spiral self-intersection via three bounded local configurations','The path turns 90 degrees in a fixed repeating order, so a new segment can only create a new crossing with a bounded number of recent segments. Check the immediate two-back crossing, the three-back touch case, and the five-back wrapped overlap case. The three inequalities cover all possible first self-intersections in the spiral; O(n) time and O(1) space. This is a specialised geometry proof, so it remains optional.',false,'optional_reference',null,null,null);

update public.topics set summary_meta='41 problems · reachability, grid, implicit state, 0-1 BFS, successor-DSU pruning and shortcut path compression' where id=20;
update public.topics set summary_meta='21 problems · predicates, polygons, hulls, sweeps, circle barriers, enclosing disks, rotated rectangles and Manhattan transforms' where id=48;

commit;
