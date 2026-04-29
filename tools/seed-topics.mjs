/**
 * Seed topics into Supabase.
 *
 * Usage:
 *   1. Add SUPABASE_SERVICE_ROLE_KEY to your .env (find it in Supabase Dashboard → Settings → API)
 *   2. Run:  npx tsx tools/seed-topics.mjs
 *
 * This uses the service_role key to bypass RLS for seeding.
 */
import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';
import { topics } from '../src/data/topics.ts';

const url = process.env.PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!url || !key) {
  console.error('Missing env vars. Set PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY in .env');
  process.exit(1);
}

const supabase = createClient(url, key);

console.log(`Seeding ${topics.length} topics…`);

const rows = topics.map((t) => ({
  id: t.id,
  display_number: t.displayNumber,
  show_in_sidebar: t.showInSidebar,
  nav_section: t.navSection,
  nav_label: t.navLabel,
  nav_tier_dot_color: t.navTierDotColor,
  title: t.title,
  tier_code: t.tier.code,
  tier_label: t.tier.label,
  type_label: t.typeLabel,
  summary_meta: t.summaryMeta,
  topbar_meta: t.topbarMeta,
  body_html: t.bodyHtml,
}));

const { error } = await supabase.from('topics').upsert(rows, { onConflict: 'id' });

if (error) {
  console.error('Seed failed:', error);
  process.exit(1);
} else {
  console.log(`✓ ${rows.length} topics seeded successfully.`);
}
