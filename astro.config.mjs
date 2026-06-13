import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  // Only set production site URL for builds; avoids dev URLs resolving to algofrog.in
  site: process.env.NODE_ENV === 'production' ? 'https://algofrog.in' : undefined,
  base: '/',
  server: {
    port: 4321,
  },
  vite: {
    server: {
      // Pre-transform the huge index.astro on dev start so the browser
      // request doesn't hit Vite's hardcoded 60s fetchModule timeout.
      warmup: {
        clientFiles: ['./src/pages/index.astro'],
      },
    },
  },
});
