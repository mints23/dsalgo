begin;
with assignments(problem_id,topic_id,path_name,path_order,inferred_role) as (values
(10024::bigint,10,'Classic sieve and prime queries',1,'variant'),
(10025::bigint,10,'Classic sieve and prime queries',1,'variant'),
(10026::bigint,10,'Classic sieve and prime queries',1,'variant'),
(10027::bigint,10,'Classic sieve and prime queries',1,'variant'),
(10028::bigint,10,'Prime transformations and greedy applications',2,'variant'),
(10029::bigint,10,'Prime transformations and greedy applications',2,'variant'),
(10030::bigint,10,'Smallest-prime-factor and multiplicative functions',3,'combination'),
(10031::bigint,10,'Smallest-prime-factor and multiplicative functions',3,'combination'),
(10032::bigint,10,'Smallest-prime-factor and multiplicative functions',3,'combination'),
(10033::bigint,10,'Smallest-prime-factor and multiplicative functions',3,'combination'),
(10034::bigint,10,'Smallest-prime-factor and multiplicative functions',3,'combination'),
(10035::bigint,10,'Smallest-prime-factor and multiplicative functions',3,'combination'),
(10036::bigint,10,'Smallest-prime-factor and multiplicative functions',3,'combination'),
(10037::bigint,10,'Smallest-prime-factor and multiplicative functions',3,'combination'),
(10038::bigint,10,'Large-range segmented sieving',4,'combination'),
(10042::bigint,11,'Point updates and multidimensional range sums',1,'variant'),
(10052::bigint,11,'Point updates and multidimensional range sums',1,'variant'),
(10055::bigint,11,'Point updates and multidimensional range sums',1,'variant'),
(10043::bigint,11,'Inversion counting and dynamic rank queries',2,'variant'),
(10044::bigint,11,'Inversion counting and dynamic rank queries',2,'variant'),
(10045::bigint,11,'Inversion counting and dynamic rank queries',2,'variant'),
(10046::bigint,11,'Inversion counting and dynamic rank queries',2,'variant'),
(10047::bigint,11,'Inversion counting and dynamic rank queries',2,'variant'),
(10049::bigint,11,'Inversion counting and dynamic rank queries',2,'variant'),
(10053::bigint,11,'Inversion counting and dynamic rank queries',2,'variant'),
(10054::bigint,11,'Inversion counting and dynamic rank queries',2,'variant'),
(10048::bigint,11,'Offline queries and sweep-line combinations',3,'combination'),
(10050::bigint,11,'Offline queries and sweep-line combinations',3,'combination'),
(10051::bigint,11,'Offline queries and sweep-line combinations',3,'combination'),
(10057::bigint,11,'Offline queries and sweep-line combinations',3,'combination'),
(10056::bigint,11,'Order statistics with Fenwick binary lifting',4,'combination'),
(10061::bigint,12,'Lazy propagation and range transformations',1,'variant'),
(10062::bigint,12,'Lazy propagation and range transformations',1,'variant'),
(10063::bigint,12,'Lazy propagation and range transformations',1,'variant'),
(10064::bigint,12,'Lazy propagation and range transformations',1,'variant'),
(10065::bigint,12,'Lazy propagation and range transformations',1,'variant'),
(10071::bigint,12,'Lazy propagation and range transformations',1,'variant'),
(10074::bigint,12,'Lazy propagation and range transformations',1,'variant'),
(10066::bigint,12,'Segment-tree dynamic programming and merge nodes',2,'combination'),
(10067::bigint,12,'Segment-tree dynamic programming and merge nodes',2,'combination'),
(10068::bigint,12,'Geometric sweeps and range-counting trees',3,'combination'),
(10070::bigint,12,'Geometric sweeps and range-counting trees',3,'combination'),
(10069::bigint,12,'Search, dynamic domains and advanced trees',4,'combination'),
(10072::bigint,12,'Search, dynamic domains and advanced trees',4,'combination'),
(10073::bigint,12,'Search, dynamic domains and advanced trees',4,'combination'),
(10075::bigint,12,'Search, dynamic domains and advanced trees',4,'combination'),
(10076::bigint,12,'Search, dynamic domains and advanced trees',4,'combination'),
(10080::bigint,13,'Prefix function and classic pattern matching',1,'variant'),
(10081::bigint,13,'Prefix function and classic pattern matching',1,'variant'),
(10082::bigint,13,'Prefix function and classic pattern matching',1,'variant'),
(10083::bigint,13,'Prefix function and classic pattern matching',1,'variant'),
(10084::bigint,13,'Prefix function and classic pattern matching',1,'variant'),
(10085::bigint,13,'Prefix function and classic pattern matching',1,'variant'),
(10086::bigint,13,'Prefix function and classic pattern matching',1,'variant'),
(10087::bigint,13,'Z-function and string similarity',2,'combination'),
(10092::bigint,13,'Z-function and string similarity',2,'combination'),
(10088::bigint,13,'Multiple-pattern matching and greedy applications',3,'combination'),
(10089::bigint,13,'Multiple-pattern matching and greedy applications',3,'combination'),
(10091::bigint,13,'Multiple-pattern matching and greedy applications',3,'combination'),
(10090::bigint,13,'Automata and dynamic-programming hybrids',4,'combination'),
(10093::bigint,13,'Automata and dynamic-programming hybrids',4,'combination'),
(10094::bigint,13,'Automata and dynamic-programming hybrids',4,'combination')
)
update public.problems p set curriculum_path=a.path_name,curriculum_path_order=a.path_order,path_problem_order=p.order_num,curriculum_role=coalesce(p.curriculum_role,a.inferred_role)
from assignments a where p.id=a.problem_id and p.topic_id=a.topic_id and p.is_required=true;
do $$
declare tid integer; req integer; complete integer; roles integer;
begin
 foreach tid in array array[10,11,12,13] loop
  select count(*) into req from public.problems where topic_id=tid and is_required=true;
  select count(*) into complete from public.problems where topic_id=tid and is_required=true and curriculum_path is not null and curriculum_path_order is not null and path_problem_order is not null;
  select count(*) into roles from public.problems where topic_id=tid and is_required=true and curriculum_role is not null;
  if req<>complete or req<>roles then raise exception 'Topic % validation failed: required %, complete %, roles %',tid,req,complete,roles; end if;
 end loop;
end $$;
commit;