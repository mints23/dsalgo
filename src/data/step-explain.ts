/**
 * Plain-language text shown beside pseudocode in the Key Insight overlay.
 * Prefer storing `explain` on each step in problem_playback.solution (JSON);
 * getStepExplain() fills gaps from # comment lines and note when missing.
 */
import type { Step } from './solution-model';

function clampProse(s: string, max: number): string {
  const t = s.trim();
  if (!t) return '';
  if (t.length <= max) return t;
  return `${t.slice(0, max).trim()}…`;
}

/** Collect narrative from leading # lines and inline # … fragments where helpful. */
export function proseFromHashComments(code: Step['code']): string {
  const lines = Array.isArray(code) ? code : [String(code)];
  const chunks: string[] = [];
  for (const line of lines) {
    const raw = String(line);
    const idx = raw.indexOf('#');
    if (idx >= 0) {
      const after = raw.slice(idx + 1).trim();
      if (after) chunks.push(after);
    }
  }
  if (!chunks.length) return '';
  return clampProse(chunks.join(' '), 480);
}

/** Best-effort prose for the left column (DB `explain` wins when set). */
export function getStepExplain(st: Step): string {
  if (st.explain?.trim()) return st.explain.trim();
  const fromHash = proseFromHashComments(st.code);
  if (fromHash.length >= 36) return fromHash;
  const note = st.note?.trim() ?? '';
  if (note.length >= 18) return clampProse(note, 360);
  return fromHash.length >= 12 ? fromHash : clampProse(note, 360);
}

/** True when overlay should use the words | pseudocode split for this step. */
export function stepHasProseAside(st: Step): boolean {
  return getStepExplain(st).length >= 14;
}
