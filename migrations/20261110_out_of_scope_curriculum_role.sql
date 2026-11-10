-- Preserve out-of-topic questions without keeping them in the visible curriculum.
-- Rows are retained for historical progress/playback referential integrity.
begin;

alter table public.problems
  drop constraint if exists problems_curriculum_role_check;

alter table public.problems
  add constraint problems_curriculum_role_check
  check (curriculum_role is null or curriculum_role in (
    'core_pattern',
    'variant',
    'combination',
    'optimization',
    'trap',
    'mastery_assessment',
    'optional_reference',
    'out_of_scope'
  ));

comment on column public.problems.curriculum_role is
  'Pedagogical role: core_pattern, variant, combination, optimization, trap, mastery_assessment, optional_reference, or out_of_scope. NULL means not yet audited.';

commit;
