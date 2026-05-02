/**
 * One-off: extracts minimal sidebar rows from topics.ts for login sneak peek.
 * Run: node tools/dump-login-sneak-topics.mjs
 */
import fs from 'fs';

const p = new URL('../src/data/topics.ts', import.meta.url);
const t = fs.readFileSync(p, 'utf8');
const re =
  /\{[\s\S]*?id:\s*(\d+),[\s\S]*?displayNumber:\s*"([^"]+)",[\s\S]*?showInSidebar:\s*(true|false),[\s\S]*?navSection:\s*"([^"]+)",[\s\S]*?navLabel:\s*"([^"]+)",[\s\S]*?navTierDotColor:\s*"([^"]+)"/g;
const rows = [];
let m;
while ((m = re.exec(t))) {
  if (m[3] === 'true') {
    rows.push({
      displayNumber: m[2],
      navSection: m[4],
      navLabel: m[5],
      navTierDotColor: m[6],
    });
  }
}
rows.sort((a, b) => Number(a.displayNumber) - Number(b.displayNumber));
console.log(JSON.stringify(rows, null, 2));
console.error('topics:', rows.length);
