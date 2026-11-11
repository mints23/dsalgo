-- 2-SAT modelling and assignment exercises for Advanced Graph Algorithms.
-- Applied to production Supabase on 2026-11-11. Idempotent; preserves stable problem identities.
begin;

insert into public.problems
(topic_id,order_num,layer,lc_number,lc_url,title,difficulty,is_premium,sub_variant,key_insight,is_required,curriculum_role,curriculum_path,curriculum_path_order,path_problem_order)
values
(29,25,'Hard','CSES 1684','https://cses.fi/problemset/task/1684','Giant Pizza','Hard',false,'2-SAT from two-literal clauses and SCC assignment','Represent each literal as a vertex. Clause (a OR b) adds implications NOT a→b and NOT b→a. Satisfiable iff x and NOT x never share an SCC. Recover assignment from SCC topological order, deriving the comparison direction for the chosen SCC implementation. Test forced literals and contradictory units.',true,'core_pattern','Satisfiability, implication graphs and 2-SAT',6,1),
(29,26,'Hard','CF 776D','https://codeforces.com/problemset/problem/776/D','The Door Problem','Hard',false,'2-SAT from switch parity constraints','Each door''s required final state imposes equality or inequality between its two switch variables. Encode equality with implications in both directions and inequality with cross implications. Solve SCC and map truth values back to switch states.',true,'variant','Satisfiability, implication graphs and 2-SAT',6,2),
(29,27,'Hard','CF 468B','https://codeforces.com/problemset/problem/468/B','Two Sets','Hard',false,'2-SAT assignment with complement implications','For each value x, define Boolean choice A or B. If x is assigned to A, its complement A−x must exist and also be assigned A; similarly for B−x. Encode implications from each choice to the required complement choice. Missing complements force the opposite set. Detect contradictions by SCC and recover a valid assignment.',true,'combination','Satisfiability, implication graphs and 2-SAT',6,3)
on conflict (topic_id,order_num) do nothing;

update public.problems set
 lc_number='CF 468B',lc_url='https://codeforces.com/problemset/problem/468/B',title='Two Sets',
 sub_variant='2-SAT assignment with complement implications',
 key_insight='For each value x, define Boolean choice A or B. If x is assigned to A, its complement A−x must exist and also be assigned A; similarly for B−x. Encode implications from each choice to the required complement choice. Missing complements force the opposite set. Detect contradictions by SCC and recover a valid assignment; handle duplicate values by indexing occurrences if the input permits them.'
where topic_id=29 and order_num=27;

update public.topics set summary_meta='27 problems · 21 required · bridges, SCC, Euler paths, MST, flow and 2-SAT' where id=29;

update public.topic_content
set sub_variants=sub_variants || '["2-SAT implication graph from 2-CNF clauses","SCC-based satisfiability test and assignment extraction","Geometric/physical constraints reduced to Boolean equality or inequality","At-most-one encodings with pairwise or sequential auxiliary variables"]'::jsonb,
 pattern_triggers=pattern_triggers || '[
 {"trigger":"Every constraint is a clause of at most two literals and you need a satisfying assignment","breaks_when":"Clauses contain three or more unconstrained literals; general SAT is not solved by SCC","sub_variant":"2-SAT implication graph and SCC contradiction test"},
 {"trigger":"Two Boolean choices must be equal or different under pairwise constraints","breaks_when":"Constraints are not expressible as 2-CNF implications","sub_variant":"Encode equality/inequality as implications and solve 2-SAT"},
 {"trigger":"At most one among many Boolean choices may be true","breaks_when":"The constraint requires exactly-k beyond 2-CNF and cannot be encoded with auxiliary variables","sub_variant":"Pairwise exclusion or sequential-counter 2-CNF encoding"}
 ]'::jsonb,
 core_idea=core_idea || E'\n\n2-SAT: Convert each 2-CNF clause (a∨b) into implications ¬a→b and ¬b→a. A satisfying assignment exists iff no variable and its negation lie in the same strongly connected component. The SCC condensation DAG provides an assignment order. Equality, inequality, forced values and at-most-one constraints often need to be modelled before the implication graph is built.',
 why_it_matters=why_it_matters || E'\n\nThe advanced graph track now includes Boolean satisfiability and assignment extraction from SCCs, a distinct use of strongly connected components beyond cycle classification and condensation counting.',
 coverage_problems=coverage_problems || '["CSES 1684 Giant Pizza","CF 776D The Door Problem","CF 468B Two Sets"]'::jsonb
where topic_id=29
and not (sub_variants @> '["2-SAT implication graph from 2-CNF clauses"]'::jsonb);

commit;
