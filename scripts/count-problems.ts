import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
dotenv.config();

const sb = createClient(process.env.PUBLIC_SUPABASE_URL!, process.env.SUPABASE_SERVICE_ROLE_KEY!);

async function main() {
  // Total rows
  const { count: total } = await sb.from('problems').select('*', { count: 'exact', head: true });
  console.log('Total problem rows:', total);

  // Unique LC numbers (non-null)
  const { data: lcRows } = await sb.from('problems').select('lc_number').not('lc_number', 'is', null);
  const uniqueLc = new Set(lcRows?.map((r: any) => r.lc_number));
  console.log('Unique LC numbers:', uniqueLc.size);

  // Problems without LC number (custom / AtCoder / etc.)
  const { data: nullLc } = await sb.from('problems').select('id').is('lc_number', null);
  console.log('Non-LC problems:', nullLc?.length ?? 0);

  // Per-topic breakdown (paginate to avoid 1000-row default limit)
  let all: any[] = [];
  let from = 0;
  const PAGE = 1000;
  while (true) {
    const { data } = await sb
      .from('problems')
      .select('topic_id, lc_number, topics(title)')
      .order('topic_id')
      .range(from, from + PAGE - 1);
    if (!data || data.length === 0) break;
    all = all.concat(data);
    if (data.length < PAGE) break;
    from += PAGE;
  }

  const grouped = new Map<number, { title: string; count: number; uniqueLc: Set<string> }>();
  for (const r of all ?? []) {
    const t = r.topic_id;
    if (!grouped.has(t)) grouped.set(t, { title: (r as any).topics?.title || '?', count: 0, uniqueLc: new Set() });
    const g = grouped.get(t)!;
    g.count++;
    if (r.lc_number) g.uniqueLc.add(r.lc_number);
  }

  console.log('\n─── Per Topic ───');
  for (const [id, v] of [...grouped.entries()].sort((a, b) => a[0] - b[0])) {
    console.log(`  [${String(id).padStart(2)}] ${String(v.count).padStart(3)} rows | ${String(v.uniqueLc.size).padStart(3)} unique LC | ${v.title}`);
  }

  // Duplicates across topics
  const lcToTopics = new Map<string, number[]>();
  for (const r of all ?? []) {
    if (!r.lc_number) continue;
    if (!lcToTopics.has(r.lc_number)) lcToTopics.set(r.lc_number, []);
    lcToTopics.get(r.lc_number)!.push(r.topic_id);
  }
  const dupes = [...lcToTopics.entries()].filter(([, ts]) => ts.length > 1);
  console.log(`\nLC numbers appearing in multiple topics: ${dupes.length}`);
  if (dupes.length <= 20) {
    for (const [lc, ts] of dupes.sort((a, b) => +a[0] - +b[0])) {
      console.log(`  LC ${lc} → topics ${ts.join(', ')}`);
    }
  }
}

main();
