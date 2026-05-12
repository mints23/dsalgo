/**
 * Default topic IDs for the trial preview path (when your `topics.id` matches sidebar order).
 * Two Pointer, HashMap, Binary Search, Sliding Window, Top K Elements, 1D Linear DP,
 * Multi-Source BFS, Segment Tree.
 *
 * At runtime we also include any topic whose `nav_label` / `title` matches Top K or 1D Linear
 * (see `resolveTrialContentTopicIds`) so preview works even when IDs differ from this list.
 *
 * Keep trial label rules in sync with `migrations/trial_preview_topic_rls.sql`.
 * The app loads nested `topic_content` / `problems` only for resolved IDs during trial.
 */
export const TRIAL_PREVIEW_TOPIC_IDS: readonly number[] = [1, 2, 3, 4, 10, 14, 29, 39];

export const TRIAL_PREVIEW_TOPIC_ID_SET: ReadonlySet<number> = new Set(TRIAL_PREVIEW_TOPIC_IDS);

/** Lowercase nav + title — used to find Top K / 1D Linear when `topics.id` ≠ catalog defaults. */
function topicTextBlob(r: { nav_label?: string | null; title?: string | null }): string {
  return `${String(r.nav_label ?? '')} ${String(r.title ?? '')}`.toLowerCase();
}

/** True if this row should load full trial content (beyond the default id list). */
export function isTrialLabelAugmentedTopic(r: { nav_label?: string | null; title?: string | null }): boolean {
  const b = topicTextBlob(r);
  if (b.includes('top k')) return true;
  if (b.includes('1d linear')) return true;
  return false;
}

/**
 * All topic IDs for which we request `topic_content` + `problems` during an active trial.
 * Merges `TRIAL_PREVIEW_TOPIC_IDS` with any shell row matching Top K / 1D Linear labels.
 */
export function resolveTrialContentTopicIds(
  shellRows: readonly { id: unknown; nav_label?: string | null; title?: string | null }[],
): number[] {
  const ids = new Set<number>();
  for (const n of TRIAL_PREVIEW_TOPIC_IDS) {
    if (Number.isFinite(n)) ids.add(Number(n));
  }
  for (const r of shellRows) {
    const id = Number(r.id);
    if (!Number.isFinite(id)) continue;
    if (isTrialLabelAugmentedTopic(r)) ids.add(id);
  }
  return [...ids].sort((a, b) => a - b);
}
