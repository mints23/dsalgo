# Cloudflare proxy for Supabase (India ISP workaround)

Indian ISPs may block `*.supabase.co`. This Worker proxies all traffic through **`https://api.algofrog.in`** so browsers never contact Supabase directly.

```
Browser → api.algofrog.in (Cloudflare Worker) → YOUR_PROJECT.supabase.co
```

---

## Prerequisites (do these first)

Complete every item before deploying the Worker.

### Checklist

| # | Requirement | You need | How to verify |
|---|-------------|----------|----------------|
| 1 | **Cloudflare account** | Free plan is enough | [dash.cloudflare.com](https://dash.cloudflare.com) login works |
| 2 | **Domain on Cloudflare DNS** | `algofrog.in` zone added to Cloudflare | Dashboard → **Websites** → `algofrog.in` appears |
| 3 | **GitHub Pages still works** | Root domain points to gh-pages after DNS move | `https://algofrog.in` loads after nameserver change |
| 4 | **Supabase project** | Existing project with data + auth | Dashboard opens (VPN/DNS if blocked locally) |
| 5 | **Supabase URL + anon key** | From Settings → API | Copy Project URL + `anon` `public` key |
| 6 | **Node.js 18+** | For Wrangler deploy | `node -v` |
| 7 | **Wrangler login** | Cloudflare API access | `npx wrangler login` |
| 8 | **Local `.env`** | Build/deploy keys | Copy from `.env.example` |

---

### 1. Cloudflare account

1. Sign up at [cloudflare.com](https://www.cloudflare.com/) (free).
2. No paid plan required for Workers free tier (100k requests/day).

---

### 2. Move `algofrog.in` DNS to Cloudflare

Your site uses GitHub Pages (`public/CNAME` → `algofrog.in`). The Worker subdomain **`api.algofrog.in`** needs Cloudflare to host DNS.

**Steps:**

1. Cloudflare Dashboard → **Add a site** → enter `algofrog.in` → **Free** plan.
2. Cloudflare scans existing DNS records — review them.
3. At your **domain registrar** (where you bought `algofrog.in`), replace nameservers with the two Cloudflare nameservers (e.g. `ada.ns.cloudflare.com`, `bob.ns.cloudflare.com`).
4. Wait until Cloudflare shows **Active** (minutes to 48h).

**Keep GitHub Pages working** — in Cloudflare DNS, set:

| Type | Name | Target | Proxy |
|------|------|--------|-------|
| `CNAME` | `@` | `YOUR_GITHUB_USERNAME.github.io` | DNS only (grey cloud) |
| `CNAME` | `www` | `YOUR_GITHUB_USERNAME.github.io` | optional |

GitHub repo → **Settings → Pages → Custom domain** should still show `algofrog.in`.

> **Note:** GitHub’s docs for apex `@` on Cloudflare may use `A` records to GitHub IPs instead of CNAME — follow [GitHub Pages + Cloudflare](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site#configuring-an-apex-domain) if CNAME at apex fails.

**Do not add `api` manually yet** — the Worker custom domain step creates it.

---

### 3. Collect Supabase values

Supabase Dashboard → **Project Settings → API**:

| Variable | Where | Example |
|----------|-------|---------|
| Project URL | `SUPABASE_ORIGIN` in Worker | `https://abcdefghijklmnop.supabase.co` |
| `anon` `public` key | `PUBLIC_SUPABASE_ANON_KEY` in `.env` | `eyJhbG…` |
| `service_role` key | `.env` for scripts only — **never** in the site | keep secret |

Write down your **project ref** (subdomain before `.supabase.co`).

If the dashboard is blocked on your ISP, use VPN or Cloudflare DNS (`1.1.1.1`) temporarily — you only need to copy these once.

---

### 4. Supabase Auth (already configured — confirm)

Dashboard → **Authentication → URL Configuration**:

| Setting | Value |
|---------|-------|
| Site URL | `https://algofrog.in` |
| Redirect URLs | `https://algofrog.in/**` |
| | `https://algofrog.in/auth/callback` |
| | `http://localhost:4321/**` |
| | `http://localhost:4321/auth/callback` |

No change needed for the proxy — auth still redirects to `algofrog.in/auth/callback`.

---

### 5. Install tools locally

```bash
node -v          # v18 or newer
npm -v
```

Login to Cloudflare (once):

```bash
cd workers/supabase-proxy
npm install
npx wrangler login
```

Browser opens → approve access.

---

### 6. Local `.env` (project root)

Copy example and fill in real values:

```bash
cp .env.example .env
```

For production build (after proxy is live):

```env
PUBLIC_SUPABASE_URL=https://api.algofrog.in
PUBLIC_SUPABASE_ANON_KEY=your-anon-key
PUBLIC_RAZORPAY_KEY_ID=rzp_live_...
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

Keep `SUPABASE_SERVICE_ROLE_KEY` out of git (already in `.gitignore`).

---

### 7. Optional — Razorpay webhook (if P0 payments deployed)

You will later set webhook URL to:

```
https://api.algofrog.in/functions/v1/razorpay-webhook
```

Requires Edge Function `razorpay-webhook` deployed on Supabase + `razorpay_webhook_secure.sql` applied.

---

## Prerequisites done? Verify

Run these before Worker deploy:

```bash
# DNS propagated (may take time after nameserver change)
nslookup algofrog.in

# Site still up
curl -s -o /dev/null -w "%{http_code}\n" https://algofrog.in

# Wrangler authenticated
npx wrangler whoami
```

When all checks pass → continue to **Deploy the Worker** below.

---

## 1. Deploy the Worker

```bash
cd workers/supabase-proxy
npm install
```

Edit `wrangler.toml` and set `SUPABASE_ORIGIN` to your real URL, e.g.:

```
SUPABASE_ORIGIN = "https://abcdefghijklmnop.supabase.co"
```

Deploy:

```bash
npm run deploy
```

Or from repo root:

```bash
npm run deploy:proxy
```

---

## 2. Custom domain

Cloudflare Dashboard → **Workers & Pages** → **algofrog-supabase-proxy** → **Settings** → **Domains & Routes** → Add:

```
api.algofrog.in
```

Ensure DNS record exists (Worker custom domain usually creates it).

Test:

```bash
curl -s -o /dev/null -w "%{http_code}" "https://api.algofrog.in/rest/v1/" -H "apikey: YOUR_ANON_KEY"
```

Expect `200` or `401`, not timeout.

---

## 3. Site environment (production build)

In `.env` (build time for `npm run deploy`):

```env
PUBLIC_SUPABASE_URL=https://api.algofrog.in
PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

Rebuild and deploy the Astro site:

```bash
npm run deploy
```

Local dev (if Supabase is blocked on your network):

```env
PUBLIC_SUPABASE_URL=https://api.algofrog.in
```

Or keep direct URL if your DNS/VPN can reach Supabase:

```env
PUBLIC_SUPABASE_URL=https://YOUR_PROJECT_REF.supabase.co
```

---

## 4. Supabase Auth

No change to redirect URLs — still:

```
https://algofrog.in/auth/callback
http://localhost:4321/auth/callback
```

The JS client talks to `api.algofrog.in/auth/v1/...` via the proxy.

---

## 5. Razorpay webhook

Point webhook URL to the proxy (forwards to Edge Function):

```
https://api.algofrog.in/functions/v1/razorpay-webhook
```

If the Worker does not have `SUPABASE_ANON_KEY` set, append your anon key (Razorpay allows query params):

```
https://api.algofrog.in/functions/v1/razorpay-webhook?apikey=YOUR_SUPABASE_ANON_KEY
```

### Webhook checklist (if deliveries fail)

1. **Edge Function** `razorpay-webhook` deployed in Supabase (paste latest `index.ts`).
2. **JWT verification OFF** for this function (Dashboard → function → Settings → Verify JWT = disabled). Razorpay does not send a user JWT.
3. **Secrets** in Supabase → Edge Functions → Secrets:
   - `RAZORPAY_WEBHOOK_SECRET` — from Razorpay → Webhooks → your webhook → **Secret** (not the API Key secret).
   - `RAZORPAY_KEY_ID` + `RAZORPAY_KEY_SECRET` — for auto-capture on `payment.authorized`.
4. **Razorpay → Webhooks** → Active events: `payment.authorized`, `payment.captured`.
5. **Cloudflare Worker** variable `SUPABASE_ANON_KEY` = same anon key as the site (or use `?apikey=` URL above).
6. **SQL**: ensure `webhook_activate_subscription` in `migrations/razorpay_webhook_secure.sql` accepts monthly `16900` paise (₹169).
7. **Test reachability**: open `https://api.algofrog.in/functions/v1/razorpay-webhook` in a browser — should show `{"ok":true,"service":"razorpay-webhook"}`.
8. **Razorpay webhook logs**: 401 = secret mismatch; 500 = DB/RPC error (check Supabase function logs); 200 + no Pro = `missing_notes` or capture still pending.

Primary activation path after checkout is still **`razorpay-confirm-payment`** (does not depend on webhook).

---

## 6. Local scripts (service role)

Scripts can use either direct Supabase URL or the proxy:

```env
PUBLIC_SUPABASE_URL=https://api.algofrog.in
SUPABASE_SERVICE_ROLE_KEY=...
```

---

## Later: full migration off Supabase

Keep this proxy until Neon + Workers API is ready. Then switch `PUBLIC_SUPABASE_URL` to your new API base and remove the Worker.
