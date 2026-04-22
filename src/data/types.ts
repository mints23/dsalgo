export type TierCode = 'T1' | 'T2' | 'T3' | 'T4' | 'T5';

export interface Tier {
  code: TierCode;
  label: string;
}

export type TopicSection =
  | {
      type: 'html';
      /**
       * Trusted HTML string rendered via Astro `set:html`.
       * Keep this as author-written markup for maximum flexibility.
       */
      html: string;
    }
  | {
      type: 'comingSoon';
      html: string;
    };

export interface Topic {
  /** Behavior ID (must match `tp{id}` and sidebar `data-topic-id`). */
  id: number;
  /** Visible number shown in UI (can differ from `id`). */
  displayNumber: string;

  /**
   * Some topics exist as content cards but are not listed in the sidebar today.
   * Keep this flag to preserve the current navigation behavior.
   */
  showInSidebar: boolean;

  /** Sidebar grouping header (e.g. "Algorithms", "Data Structures"). */
  navSection: string;
  /** Sidebar label text (e.g. "Two Pointer"). */
  navLabel: string;
  /** Dot color in the sidebar list. */
  navTierDotColor: string;

  /** Title shown in topic header. */
  title: string;
  tier: Tier;
  /** Small label shown next to tier (e.g. "Technique", "Data Structure"). */
  typeLabel: string;
  /** One-line summary under the title (free text). */
  summaryMeta: string;

  /** Topbar breadcrumb meta (formerly the `topicMetas` lookup). */
  topbarMeta: string;

  /**
   * Topic body content rendered as HTML.
   * This is where the sub-variants, tables, callouts, etc. live today.
   */
  bodyHtml: string;
}

