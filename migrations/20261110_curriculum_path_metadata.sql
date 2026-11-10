-- Additive metadata for pedagogical path grouping. Existing problem identity,
-- authored order_num, and user_progress keys remain untouched.
alter table public.problems
  add column if not exists curriculum_path text,
  add column if not exists curriculum_path_order integer,
  add column if not exists path_problem_order integer;

alter table public.problems
  drop constraint if exists problems_curriculum_path_metadata_check;

alter table public.problems
  add constraint problems_curriculum_path_metadata_check
  check (
    (
      curriculum_path is null
      and curriculum_path_order is null
      and path_problem_order is null
    )
    or
    (
      curriculum_path is not null
      and length(btrim(curriculum_path)) > 0
      and curriculum_path_order is not null
      and curriculum_path_order > 0
      and path_problem_order is not null
      and path_problem_order > 0
    )
  );

create index if not exists problems_topic_curriculum_path_idx
  on public.problems (topic_id, curriculum_path_order, path_problem_order)
  where is_required = true;
