# Eight-Topic Curriculum Paths — Data and UI Design

**Status:** Implemented and released to production on 2026-11-10. The path schema, frontend grouping, and reviewed pilot backfill are live.

## Decision

Use three additive nullable columns on `public.problems`:

- `curriculum_path text`: learner-facing path title, for example `Sorted pair search and counting`.
- `curriculum_path_order integer`: order of this path within the topic.
- `path_problem_order integer`: order of the problem inside that path.

The three fields are intentionally separate from `order_num`. Existing `order_num` remains the visible problem number and part of the existing progress key. The UI must never derive progress identity from the new path ordering.

A normalized path catalog table is not justified for this pilot: each topic/problem placement receives one primary learning path, and alternate approaches already have separate topic placements where needed. If later requirements include a problem appearing in multiple paths within the same topic, revisit the model then rather than introducing a join table prematurely.

## Database contract

Migration should:

1. Add the three nullable columns without rewriting existing rows.
2. Add a check that the path title, path order, and problem order are either all null or all populated.
3. Require positive path/problem order values when populated.
4. Add a supporting index on `(topic_id, curriculum_path_order, path_problem_order)`.
5. Add column comments documenting that path metadata is presentation/teaching order only and does not replace `order_num`.

Do not set defaults that silently assign every existing row to one path. Backfill only after the full 275-row required pilot map has been reviewed.

## Frontend contract

The client query that embeds `problems` should select the three new columns. Existing authored HTML remains the source of row presentation and table structure; existing URL → LeetCode ID → normalized-title matching continues to attach stable database IDs to authored rows.

After identity matching and required/optional filtering:

1. For each table already marked `data-curriculum-problem-table="true"`, collect rows that remain required and have a matched problem ID.
2. If every visible required row in that table has path metadata, group and order those rows by `curriculum_path_order`, then `path_problem_order`.
3. Reinsert rows under a path-heading row inside the same table's `tbody`. The heading spans the existing table's column count.
4. Keep the authored `.num-cell` text unchanged. It remains the stable progress number, even when visual teaching order differs.
5. Leave optional Easy references and unmatched rows to the existing reference/removal behavior. They must not create empty path headings.
6. If path metadata is incomplete for a table, fail open: leave its existing row order and presentation unchanged rather than partially regrouping it.

A topic may contain multiple authored problem tables with different column layouts. Group each table independently and repeat a path heading if the same path spans more than one authored table. Do not merge tables or move rows across their table boundaries.

## CSS and accessibility

- Use a visually distinct but compact `tr.curriculum-path-heading` row.
- Render the path title as a `th` with `scope="rowgroup"` and `colspan` equal to the table's column count.
- Do not use color alone to distinguish sections.
- Ensure horizontal scrolling remains owned by the existing `.tbl-wrap`.
- Verify light and dark themes, desktop and narrow mobile widths.

## Production implementation status

- The frontend reads the three path metadata fields and groups visible required rows within each authored table. This is deployed on main.
- Grouping is fail-open: a table is left untouched if any visible required row has missing or inconsistent path metadata.
- Accessible row-group headings are rendered as `th[scope=rowgroup]`; original `.num-cell` text is not modified.
- The additive SQL migration for the three nullable columns, all-null-or-all-populated check constraint, and partial lookup index has been applied to production.
- The role/path backfill is applied: 246 required placements across the eight topics have complete metadata; 71 originally unclassified placements were all resolved, with 56 retained and 15 demoted. Thirteen secondary duplicate placements became optional references, and one preclassified date-arithmetic row was demoted.
- Production Astro build and GitHub Pages deployment succeeded; release footer is generated from the workflow run number.
- The corrected authored explanations for Talent Show and LC 2770 are in the database HTML, in addition to the structured problem metadata.

## Production rollout result and remaining QA

1. Additive schema migration applied successfully.
2. Reviewed role/path data migration applied with assertions for complete metadata, no null roles among required rows, and unique path labels per topic/path order.
3. Production build and GitHub Pages deployment succeeded.
4. The production index.html and generated JS bundle were inspected: version footer is present, and path grouping code plus the required metadata fields are bundled.
5. Production SQL verification returned 246 required rows, zero incomplete path rows, and zero missing required curriculum roles.
6. Browser-level verification of progress restore, completion/revision toggles, mobile widths, and each authored table layout remains a final manual QA task; the deployment is live and the grouping code fails open if a table's row metadata cannot be matched.

## Non-negotiable invariants

- Never update `problems.id`, `topic_id`, or `order_num` for path grouping.
- Never delete a placement to remove a duplicate.
- Never change the existing progress key (`topic_id` + visible `num-cell`).
- Do not expose out-of-scope or excluded-trap rows as required problems.
- Do not claim the path pilot is complete until all retained required placements have a reviewed path and sequence (246 in the current production pilot).
