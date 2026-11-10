-- Advanced-track curriculum metadata.
-- Safe/additive: existing problem rows, IDs, progress and playback are preserved.

begin;

alter table public.problems
  add column if not exists is_required boolean not null default false;

alter table public.problems
  add column if not exists curriculum_role text;

do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'problems_curriculum_role_check'
      and conrelid = 'public.problems'::regclass
  ) then
    alter table public.problems
      add constraint problems_curriculum_role_check
      check (curriculum_role is null or curriculum_role in (
        'core_pattern',
        'variant',
        'combination',
        'optimization',
        'trap',
        'mastery_assessment',
        'optional_reference'
      ));
  end if;
end $$;

-- Only known Medium/Hard records enter the required path.
-- Easy and unclassified records remain intact but are not required until reviewed.
update public.problems
set is_required = case
  when lower(trim(coalesce(difficulty, ''))) in ('med', 'medium', 'hard') then true
  else false
end,
curriculum_role = case
  when lower(trim(coalesce(difficulty, ''))) = 'easy' and curriculum_role is null
    then 'optional_reference'
  else curriculum_role
end;

create index if not exists idx_problems_required_topic_order
  on public.problems (topic_id, order_num)
  where is_required = true;

comment on column public.problems.is_required is
  'Whether this problem is part of the required advanced curriculum. Easy and unclassified problems are not required by default.';

comment on column public.problems.curriculum_role is
  'Pedagogical role: core_pattern, variant, combination, optimization, trap, mastery_assessment, or optional_reference. NULL means not yet audited.';

commit;
