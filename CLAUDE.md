# CLAUDE.md

Guidance for working in this repository.

## Commands

```bash
npm run dev          # Astro dev server (port 4321)
npm run build        # Production build → dist/
npm run preview      # Serve dist/ locally
npm run deploy       # build + gh-pages push (algofrog.in)
npm run deploy:proxy # Cloudflare Worker (api.algofrog.in)
```

No lint or test framework is configured.

## Architecture (summary)

**Full diagram and flows:** [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

- **Static site:** Astro on GitHub Pages (`algofrog.in`).
- **Backend:** Supabase (auth, Postgres, RLS, RPCs). Guide content is fetched client-side from `topics` / `problems` — not baked into HTML.
- **API proxy:** `PUBLIC_SUPABASE_URL=https://api.algofrog.in` in prod — Cloudflare Worker → `*.supabase.co` (India ISP blocks). See [docs/CLOUDFLARE_SUPABASE_PROXY.md](docs/CLOUDFLARE_SUPABASE_PROXY.md).
- **Payments:** Razorpay Checkout in browser; activation via Edge Function `razorpay-webhook` + `migrations/razorpay_webhook_secure.sql`. Client polls after pay (`src/lib/payment-await.ts`); never trust client activation RPCs.

### Pages

| Route | Role |
|-------|------|
| `/` | DSA guide (auth + subscription gated) |
| `/login`, `/auth/callback` | Google OAuth PKCE |
| `/connect` | Mentor slots + Razorpay |
| `/admin` | Admin panel (`is_admin`) |
| `/expired` | Post-trial upgrade |

### Key libs

- `src/lib/supabase.ts` — browser client
- `src/lib/payment-await.ts` — Razorpay notes + webhook polling
- `src/lib/auth-redirect.ts` — OAuth redirects
- `src/lib/admin-access.ts` — admin nav visibility

### Migrations

Run SQL in Supabase SQL Editor from `migrations/`. Schema snapshot: `supabase-schema.sql`. Payment lockdown: `razorpay_webhook_secure.sql`.

### Env (build)

Copy `.env.example` → `.env`. Prod: `PUBLIC_SUPABASE_URL=https://api.algofrog.in`. Never commit secrets.

## Theming

`src/styles/global.css` — CSS variables on `:root` / `[data-theme="dark"]`. Primary: `#01696f` (light) / `#4f98a3` (dark). Use variables, not hardcoded colors.

## Deployment

`npm run deploy` → `gh-pages` branch, custom domain `algofrog.in`. Worker deploy is separate (`npm run deploy:proxy`).
