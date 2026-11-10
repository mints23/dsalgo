begin;
with assignments(problem_id,topic_id,path_name,path_order,inferred_role) as (values
(10454::bigint,25,'Dijkstra''s shortest-path invariant and path counting',1,'core_pattern'),
(10455::bigint,25,'Dijkstra''s shortest-path invariant and path counting',1,'core_pattern'),
(10458::bigint,25,'Dijkstra''s shortest-path invariant and path counting',1,'core_pattern'),
(10459::bigint,25,'Dijkstra''s shortest-path invariant and path counting',1,'core_pattern'),
(10456::bigint,25,'Minimax, grid and implicit-graph Dijkstra',2,'combination'),
(10464::bigint,25,'Minimax, grid and implicit-graph Dijkstra',2,'combination'),
(10465::bigint,25,'Minimax, grid and implicit-graph Dijkstra',2,'combination'),
(10467::bigint,25,'Minimax, grid and implicit-graph Dijkstra',2,'combination'),
(10472::bigint,25,'Minimax, grid and implicit-graph Dijkstra',2,'combination'),
(10460::bigint,25,'Multi-pass shortest paths and graph transformations',3,'combination'),
(10461::bigint,25,'Multi-pass shortest paths and graph transformations',3,'combination'),
(10463::bigint,25,'Multi-pass shortest paths and graph transformations',3,'combination'),
(10466::bigint,25,'State-expanded and time-constrained shortest paths',4,'combination'),
(10468::bigint,25,'State-expanded and time-constrained shortest paths',4,'combination'),
(10469::bigint,25,'State-expanded and time-constrained shortest paths',4,'combination'),
(10470::bigint,25,'State-expanded and time-constrained shortest paths',4,'combination'),
(10471::bigint,25,'State-expanded and time-constrained shortest paths',4,'combination'),
(10473::bigint,25,'State-expanded and time-constrained shortest paths',4,'combination'),
(10475::bigint,26,'Floyd-Warshall APSP and distance closure',1,'core_pattern'),
(10480::bigint,26,'Floyd-Warshall APSP and distance closure',1,'core_pattern'),
(10482::bigint,26,'Floyd-Warshall APSP and distance closure',1,'core_pattern'),
(10483::bigint,26,'Path reconstruction and alternative path algebras',2,'combination'),
(10484::bigint,26,'Path reconstruction and alternative path algebras',2,'combination'),
(10476::bigint,26,'Graph-wide relationship and connectivity contrasts',3,'variant'),
(10477::bigint,26,'Graph-wide relationship and connectivity contrasts',3,'variant'),
(10481::bigint,26,'Graph-wide relationship and connectivity contrasts',3,'variant'),
(10488::bigint,27,'Bellman-Ford relaxation and negative-cycle detection',1,'core_pattern'),
(10491::bigint,27,'Bellman-Ford relaxation and negative-cycle detection',1,'core_pattern'),
(10492::bigint,27,'Bellman-Ford relaxation and negative-cycle detection',1,'core_pattern'),
(10489::bigint,27,'Bounded-edge and resource-constrained shortest paths',2,'combination'),
(10490::bigint,27,'Bounded-edge and resource-constrained shortest paths',2,'combination'),
(10494::bigint,27,'Bounded-edge and resource-constrained shortest paths',2,'combination'),
(10495::bigint,27,'Bounded-edge and resource-constrained shortest paths',2,'combination'),
(10493::bigint,27,'Negative-cycle applications and algorithm comparisons',3,'combination'),
(10496::bigint,27,'Negative-cycle applications and algorithm comparisons',3,'combination'),
(10497::bigint,27,'Negative-cycle applications and algorithm comparisons',3,'combination'),
(10501::bigint,28,'DSU fundamentals and component connectivity',1,'core_pattern'),
(10502::bigint,28,'DSU fundamentals and component connectivity',1,'core_pattern'),
(10503::bigint,28,'DSU fundamentals and component connectivity',1,'core_pattern'),
(10504::bigint,28,'DSU fundamentals and component connectivity',1,'core_pattern'),
(10507::bigint,28,'DSU fundamentals and component connectivity',1,'core_pattern'),
(10505::bigint,28,'Kruskal, weighted DSU and component aggregation',2,'combination'),
(10506::bigint,28,'Kruskal, weighted DSU and component aggregation',2,'combination'),
(10508::bigint,28,'Kruskal, weighted DSU and component aggregation',2,'combination'),
(10509::bigint,28,'Kruskal, weighted DSU and component aggregation',2,'combination'),
(10510::bigint,28,'Kruskal, weighted DSU and component aggregation',2,'combination'),
(10511::bigint,28,'Kruskal, weighted DSU and component aggregation',2,'combination'),
(10512::bigint,28,'Kruskal, weighted DSU and component aggregation',2,'combination'),
(10513::bigint,28,'Offline connectivity and reverse-time processing',3,'combination'),
(10521::bigint,29,'Low-link connectivity and articulation structure',1,'variant'),
(10522::bigint,29,'Low-link connectivity and articulation structure',1,'variant'),
(10523::bigint,29,'Low-link connectivity and articulation structure',1,'variant'),
(10524::bigint,29,'Low-link connectivity and articulation structure',1,'variant'),
(10526::bigint,29,'Directed graph structure and cycle analysis',2,'variant'),
(10527::bigint,29,'Directed graph structure and cycle analysis',2,'variant'),
(10528::bigint,29,'Directed graph structure and cycle analysis',2,'variant'),
(10529::bigint,29,'Directed graph structure and cycle analysis',2,'variant'),
(10530::bigint,29,'Eulerian paths and edge-order construction',3,'variant'),
(10531::bigint,29,'Eulerian paths and edge-order construction',3,'variant'),
(10532::bigint,29,'Eulerian paths and edge-order construction',3,'variant'),
(10533::bigint,29,'MST variants and graph optimisation',4,'combination'),
(10535::bigint,29,'MST variants and graph optimisation',4,'combination'),
(10536::bigint,29,'MST variants and graph optimisation',4,'combination'),
(10525::bigint,29,'MST variants and graph optimisation',4,'combination'),
(10534::bigint,29,'MST variants and graph optimisation',4,'combination')
)
update public.problems p set curriculum_path=a.path_name,curriculum_path_order=a.path_order,path_problem_order=p.order_num,curriculum_role=coalesce(p.curriculum_role,a.inferred_role)
from assignments a where p.id=a.problem_id and p.topic_id=a.topic_id and p.is_required=true;
do $$
declare tid integer; req integer; complete integer; roles integer;
begin
 foreach tid in array array[25,26,27,28,29] loop
  select count(*) into req from public.problems where topic_id=tid and is_required=true;
  select count(*) into complete from public.problems where topic_id=tid and is_required=true and curriculum_path is not null and curriculum_path_order is not null and path_problem_order is not null;
  select count(*) into roles from public.problems where topic_id=tid and is_required=true and curriculum_role is not null;
  if req<>complete or req<>roles then raise exception 'Topic % validation failed: required %, complete %, roles %',tid,req,complete,roles; end if;
 end loop;
end $$;
commit;