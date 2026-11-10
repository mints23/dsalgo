-- Preserve trap-tagged problem records while excluding them from learner-facing topic paths.
alter table public.problems drop constraint if exists problems_curriculum_role_check;
alter table public.problems add constraint problems_curriculum_role_check
check (curriculum_role is null or curriculum_role in (
  'core_pattern',
  'variant',
  'combination',
  'optimization',
  'trap',
  'mastery_assessment',
  'optional_reference',
  'out_of_scope',
  'excluded_trap'
));
comment on column public.problems.curriculum_role is
'Pedagogical role: core_pattern, variant, combination, optimization, trap, mastery_assessment, optional_reference, out_of_scope, or excluded_trap (preserved historical trap removed from learner path).';
