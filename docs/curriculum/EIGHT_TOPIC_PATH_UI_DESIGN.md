# Eight-Topic Curriculum Paths — Data and UI Design

**Status:** Implementation design for the eight-topic pilot. No production schema or application changes are made by this document.

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

## Implementation status on the feature branch

- The frontend now reads the three path metadata fields and groups visible required rows within each authored table.
- Grouping is fail-open: a table is left untouched if any visible required row has missing or inconsistent path metadata.
- Accessible row-group headings are rendered as `th[scope=rowgroup]`; original `.num-cell` text is not modified.
- An additive SQL migration has been added for the three nullable columns, their all-null-or-all-populated check constraint, and a partial lookup index.
- A pull-request workflow runs `npm ci` and `npm run build`. The current feature-branch build passed.
- No production migration has been applied and no path data has been backfilled. Until both happen, production behavior remains unchanged.

## Rollout sequence

1. Complete the cross-topic ownership review and path assignments for every retained required placement in the eight-topic pilot (275 current required placements, adjusted only by reviewed demotions).
2. Verify every path sequence and custom problem source; preserve stable IDs, topic IDs, and `order_num`.
3. Apply the additive schema migration to production before deploying code that selects the new columns.
4. Apply a separate reviewed data migration to populate role/path metadata. Check the affected-row count and assert that every retained required placement has complete metadata.
5. Run the production Astro build in GitHub Actions and test representative topics with 1, 2, 3, and 7 authored tables.
6. Verify progress restore, completion toggles, revision marks, optional references, row matching, and mobile table rendering.
7. Merge and deploy only after the checks pass; then verify the generated footer version and that it is rendered at the bottom of the page.

## Non-negotiable invariants

- Never update `problems.id`, `topic_id`, or `order_num` for path grouping.
- Never delete a placement to remove a duplicate.
- Never change the existing progress key (`topic_id` + visible `num-cell`).
- Do not expose out-of-scope or excluded-trap rows as required problems.
- Do not claim the path pilot is complete until all 275 required placements have a reviewed path and sequence.
