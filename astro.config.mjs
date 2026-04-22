import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: 'https://algofrog.in',
  base: '/',
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
