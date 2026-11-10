begin;
with assignments(problem_id,topic_id,path_name,path_order,inferred_role) as (values
(10210::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10211::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10212::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10213::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10214::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10215::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10246::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10247::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10251::bigint,17,'DFS traversal, depth and path aggregates',1,'variant'),
(10216::bigint,17,'Tree DP and rerooting',2,'combination'),
(10217::bigint,17,'Tree DP and rerooting',2,'combination'),
(10219::bigint,17,'Tree DP and rerooting',2,'combination'),
(10220::bigint,17,'Tree DP and rerooting',2,'combination'),
(10221::bigint,17,'Tree DP and rerooting',2,'combination'),
(10222::bigint,17,'Tree DP and rerooting',2,'combination'),
(10223::bigint,17,'Tree DP and rerooting',2,'combination'),
(10235::bigint,17,'Tree DP and rerooting',2,'combination'),
(10240::bigint,17,'Tree DP and rerooting',2,'combination'),
(10241::bigint,17,'Tree DP and rerooting',2,'combination'),
(10250::bigint,17,'Tree DP and rerooting',2,'combination'),
(10255::bigint,17,'Tree DP and rerooting',2,'combination'),
(10226::bigint,17,'Ancestor queries, LCA and binary lifting',3,'combination'),
(10227::bigint,17,'Ancestor queries, LCA and binary lifting',3,'combination'),
(10228::bigint,17,'Ancestor queries, LCA and binary lifting',3,'combination'),
(10229::bigint,17,'Ancestor queries, LCA and binary lifting',3,'combination'),
(10248::bigint,17,'Ancestor queries, LCA and binary lifting',3,'combination'),
(10252::bigint,17,'Ancestor queries, LCA and binary lifting',3,'combination'),
(10254::bigint,17,'Ancestor queries, LCA and binary lifting',3,'combination'),
(10230::bigint,17,'Euler tours, HLD and subtree queries',4,'combination'),
(10231::bigint,17,'Euler tours, HLD and subtree queries',4,'combination'),
(10233::bigint,17,'Euler tours, HLD and subtree queries',4,'combination'),
(10237::bigint,17,'Euler tours, HLD and subtree queries',4,'combination'),
(10238::bigint,17,'Euler tours, HLD and subtree queries',4,'combination'),
(10239::bigint,17,'Euler tours, HLD and subtree queries',4,'combination'),
(10232::bigint,17,'DSU on tree, small-to-large and centroid decomposition',5,'combination'),
(10234::bigint,17,'DSU on tree, small-to-large and centroid decomposition',5,'combination'),
(10236::bigint,17,'DSU on tree, small-to-large and centroid decomposition',5,'combination'),
(10242::bigint,17,'DSU on tree, small-to-large and centroid decomposition',5,'combination'),
(10256::bigint,17,'DSU on tree, small-to-large and centroid decomposition',5,'combination'),
(10218::bigint,17,'Tree traversal, diameter and structural transformations',6,'combination'),
(10224::bigint,17,'Tree traversal, diameter and structural transformations',6,'combination'),
(10225::bigint,17,'Tree traversal, diameter and structural transformations',6,'combination'),
(10249::bigint,17,'Tree traversal, diameter and structural transformations',6,'combination'),
(10253::bigint,17,'Tree traversal, diameter and structural transformations',6,'combination'),
(10257::bigint,17,'Implicit trees and subset-state techniques',7,'combination'),
(10258::bigint,17,'Implicit trees and subset-state techniques',7,'combination'),
(10259::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10260::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10261::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10262::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10263::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10264::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10265::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10266::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10276::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10277::bigint,18,'Trie fundamentals and prefix-suffix indexing',1,'variant'),
(10267::bigint,18,'Binary XOR tries and constrained XOR queries',2,'combination'),
(10268::bigint,18,'Binary XOR tries and constrained XOR queries',2,'combination'),
(10269::bigint,18,'Binary XOR tries and constrained XOR queries',2,'combination'),
(10270::bigint,18,'Binary XOR tries and constrained XOR queries',2,'combination'),
(10274::bigint,18,'Binary XOR tries and constrained XOR queries',2,'combination'),
(10278::bigint,18,'Binary XOR tries and constrained XOR queries',2,'combination'),
(10279::bigint,18,'Binary XOR tries and constrained XOR queries',2,'combination'),
(10271::bigint,18,'Trie-guided DP and grid search',3,'combination'),
(10272::bigint,18,'Trie-guided DP and grid search',3,'combination'),
(10273::bigint,18,'Trie-guided DP and grid search',3,'combination'),
(10275::bigint,18,'Streaming and multi-pattern matching',4,'combination'),
(10280::bigint,18,'Streaming and multi-pattern matching',4,'combination')
)
update public.problems p set curriculum_path=a.path_name,curriculum_path_order=a.path_order,path_problem_order=p.order_num,curriculum_role=coalesce(p.curriculum_role,a.inferred_role)
from assignments a where p.id=a.problem_id and p.topic_id=a.topic_id and p.is_required=true;
do $$
declare tid integer; req integer; complete integer; roles integer;
begin
 foreach tid in array array[17,18] loop
  select count(*) into req from public.problems where topic_id=tid and is_required=true;
  select count(*) into complete from public.problems where topic_id=tid and is_required=true and curriculum_path is not null and curriculum_path_order is not null and path_problem_order is not null;
  select count(*) into roles from public.problems where topic_id=tid and is_required=true and curriculum_role is not null;
  if req<>complete or req<>roles then raise exception 'Topic % validation failed: required %, complete %, roles %',tid,req,complete,roles; end if;
 end loop;
end $$;
commit;