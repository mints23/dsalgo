import type { APIRoute } from 'astro';
import { GUIDE_PROBLEM_ROW_COUNT, GUIDE_TOPIC_COUNT } from '../data/site-stats';

const manifest = {
  name: 'DSA Mastery Guide',
  short_name: 'DSA Mastery',
  description: `Master Data Structures & Algorithms with ${GUIDE_TOPIC_COUNT} topics and ${GUIDE_PROBLEM_ROW_COUNT} curated problems`,
  start_url: '/',
  display: 'standalone',
  background_color: '#f7f6f2',
  theme_color: '#1f5c61',
  icons: [
    {
      src: '/icon-192.svg',
      sizes: '192x192',
      type: 'image/svg+xml',
      purpose: 'any maskable',
    },
  ],
};

export const prerender = true;

export const GET: APIRoute = () =>
  new Response(JSON.stringify(manifest, null, 2), {
    headers: { 'Content-Type': 'application/manifest+json; charset=utf-8' },
  });
