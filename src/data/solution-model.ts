/** Optional side-panel snapshot for solution overlay (array + vars + aux DS). */
export type DryRunSnapshot = {
  caption: string;
  cells?: Array<{ v: string | number; s?: string; p?: string }>;
  vars?: Array<{ k: string; v: string | number; hi?: boolean }>;
  /** e.g. stack bottom → top, drawn as monospace lines */
  auxTitle?: string;
  auxLines?: string[];
};

export type Step = {
  title: string;
  code: string[];
  note: string;
  /**
   * Plain-language explanation for this beat (persist in problem_playback.solution JSON).
   * Shown beside pseudocode in the overlay; if omitted, UI may derive text from # lines + note.
   */
  explain?: string;
  phase?: string;
  dry?: DryRunSnapshot;
};

export type Solution = {
  approach: string;
  time: string;
  space: string;
  steps: Step[];
};
