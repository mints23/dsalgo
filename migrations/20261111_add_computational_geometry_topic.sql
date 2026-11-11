-- Computational geometry and spatial algorithms curriculum expansion.
-- Applied to production Supabase on 2026-11-11. Idempotent; preserves stable identities.
begin;

insert into public.topics
(id,display_number,show_in_sidebar,nav_section,nav_label,nav_tier_dot_color,title,tier_code,tier_label,type_label,summary_meta,topbar_meta,body_html,is_free)
values
(48,'48',true,'Advanced Techniques','Computational Geometry','#da7101','Computational Geometry & Spatial Algorithms','T4','Advanced','Geometric Predicates · Polygons · Convex Hull · Sweep Line','10 problems · orientation, segment intersection, point-in-polygon, hulls, closest pair and rotating calipers','Advanced Techniques · Computational Geometry','',false)
on conflict (id) do update set
 display_number=excluded.display_number,show_in_sidebar=excluded.show_in_sidebar,nav_section=excluded.nav_section,
 nav_label=excluded.nav_label,nav_tier_dot_color=excluded.nav_tier_dot_color,title=excluded.title,
 tier_code=excluded.tier_code,tier_label=excluded.tier_label,type_label=excluded.type_label,
 summary_meta=excluded.summary_meta,topbar_meta=excluded.topbar_meta,is_free=excluded.is_free;

insert into public.topic_content
(topic_id,why_it_matters,core_idea,sub_variants,pattern_triggers,coverage_problems,red_flags)
values
(48,
'Computational geometry turns spatial relationships into exact algebraic predicates and ordered events. It is useful in maps, collision detection, CAD, graphics and spatial algorithms. Avoid floating-point guesswork: derive orientation, intersection and containment with cross products and explicit boundary rules.',
'The cross product (b−a)×(c−a) gives orientation. Use it for segment intersection and convex hull. The shoelace sum gives signed polygon area. Point-in-polygon uses ray crossing or winding number with a boundary test. Sweep lines sort events and maintain active structures; equal-coordinate tie order matters. Convex hull reduces a point set to its extreme boundary; rotating calipers find antipodal pairs. Closest pair uses divide-and-conquer or sweep-line packing bounds.',
'["Orientation and cross-product predicates","Point-on-segment and robust segment intersection","Signed polygon area via shoelace","Point-in-polygon via ray crossing and winding number","Monotonic-chain convex hull and collinear boundary policy","Closest pair in O(n log n)","Slope normalisation for collinearity","Angular sorting and circular windows","Rotating calipers for convex diameter","Sweep line for orthogonal segment intersections"]'::jsonb,
'[{"trigger":"Classify clockwise, counter-clockwise or collinear point triples","breaks_when":"Coordinate products exceed exact numeric type","sub_variant":"Cross-product orientation"},{"trigger":"Determine segment intersection including touching and overlap","breaks_when":"Curves are nonlinear or tolerance geometry is required","sub_variant":"Four orientations plus on-segment checks"},{"trigger":"Compute area from ordered polygon vertices","breaks_when":"Self-intersecting polygon semantics are unspecified","sub_variant":"Signed shoelace formula"},{"trigger":"Classify point inside/outside/on polygon","breaks_when":"Polygon is non-simple or boundary semantics differ","sub_variant":"Boundary test then half-open ray crossing"},{"trigger":"Find outer boundary of point set","breaks_when":"Dynamic online insertions/deletions are required","sub_variant":"Monotonic-chain convex hull"},{"trigger":"Closest pair among planar points","breaks_when":"Metric/dimension differs from planar Euclidean","sub_variant":"O(n log n) closest-pair algorithm"},{"trigger":"Count horizontal/vertical segment intersections","breaks_when":"Arbitrary orientations require a general active ordered set","sub_variant":"Sweep line with compressed y and Fenwick tree"},{"trigger":"Maximum distance on a convex polygon","breaks_when":"Input is not convex and hull is not constructed","sub_variant":"Rotating calipers"}]'::jsonb,
'["CSES 2192 Polygon Area","CSES 2190 Line Segment Intersection","CSES 2191 Point in Polygon","CSES 2195 Convex Hull","LC 587 Erect the Fence","CSES 2194 Minimum Euclidean Distance","LC 149 Max Points on a Line","LC 1610 Maximum Number of Visible Points","Custom Rotating Calipers Diameter","Custom Orthogonal Segment Intersections"]'::jsonb,
'["Prefer exact integer predicates over floating-point equality.","Promote before multiplication; use BigInteger if coordinate bounds exceed long.","Handle collinear overlap and endpoints in segment intersection.","Choose cross<=0 versus cross<0 deliberately for hull collinearity.","Use a half-open edge convention in ray crossing to avoid double-counting vertices.","Sweep-line event ordering at equal coordinates controls endpoint semantics.","Shoelace returns signed double area; preserve orientation when needed."]'::jsonb)
on conflict (topic_id) do nothing;

insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(48,1,'Foundation','CSES 2192','https://cses.fi/problemset/task/2192','Polygon Area','Med',false,'Signed shoelace formula','Sum x[i]·y[i+1]−y[i]·x[i+1] including the closing edge. The result is signed double area; divide by two and take absolute value only if orientation is irrelevant.',true,'core_pattern','Geometric predicates and polygon fundamentals',1,1),
(48,2,'Foundation','CSES 2190','https://cses.fi/problemset/task/2190','Line Segment Intersection','Med',false,'Orientation tests with collinear boundary handling','Four orientation predicates detect proper crossing; collinear cases require point-on-segment checks using bounding boxes. Prove the complete case split with exact integer arithmetic.',true,'core_pattern','Geometric predicates and polygon fundamentals',1,2),
(48,3,'Variants','CSES 2191','https://cses.fi/problemset/task/2191','Point in Polygon','Hard',false,'Ray crossing with boundary classification','Test boundary first. Otherwise cast a horizontal ray and toggle for edges crossing a half-open vertical interval; use orientation rather than division and explain vertex double-count prevention.',true,'variant','Geometric predicates and polygon fundamentals',1,3),
(48,4,'Hard','CSES 2195','https://cses.fi/problemset/task/2195','Convex Hull','Hard',false,'Monotonic chain with collinearity policy','Sort points, build lower/upper chains and pop turns violating convexity. Choose strict/non-strict cross condition deliberately, deduplicate points and handle all-collinear input.',true,'core_pattern','Convex hulls and calipers',2,1),
(48,5,'Hard','587','https://leetcode.com/problems/erect-the-fence/','Erect the Fence','Hard',false,'Convex hull retaining boundary-collinear points','Build monotonic chain retaining collinear boundary points. Deduplicate points shared by both chains and prove interior collinear points are excluded.',true,'variant','Convex hulls and calipers',2,2),
(48,6,'Hard','CSES 2194','https://cses.fi/problemset/task/2194','Minimum Euclidean Distance','Hard',false,'Closest pair in O(n log n)','Divide by x, solve halves, and inspect only the vertical strip that can beat the best squared distance. Maintain y-order and use the packing bound for constant successor comparisons.',true,'core_pattern','Closest pair and geometric sweeps',3,1),
(48,7,'Med','149','https://leetcode.com/problems/max-points-on-a-line/','Max Points on a Line','Med',false,'Canonical integer slope normalisation','Reduce (dx,dy) by gcd and normalise sign. Count duplicate points separately; handle vertical/horizontal lines without floating-point slope keys.',true,'variant','Closest pair and geometric sweeps',3,2),
(48,8,'Hard','1610','https://leetcode.com/problems/maximum-number-of-visible-points/','Maximum Number of Visible Points','Hard',false,'Angular sorting and circular window','Sort atan2 angles, duplicate with +2π and slide a window whose span is within the viewing angle. Count coincident points separately and define inclusive precision handling.',true,'combination','Closest pair and geometric sweeps',3,3),
(48,9,'Hard',null,null,'Convex Polygon Diameter with Rotating Calipers (Custom)','Hard',false,'Antipodal pairs and support-line rotation','Advance the antipodal pointer while triangle area increases, evaluate candidate squared distances, and prove one full revolution suffices. Handle parallel edges and equal-area plateaus.',true,'combination','Convex hulls and calipers',2,3),
(48,10,'Hard',null,null,'Orthogonal Segment Intersections with Sweep Line (Custom)','Hard',false,'Fenwick tree over active horizontal segments','Insert/remove horizontal segments at sweep events; a vertical segment queries active y-values in its interval using a Fenwick tree. Compress y and define equal-x event order to control endpoint inclusion.',true,'combination','Closest pair and geometric sweeps',3,4)
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
