/**
 * Reverse proxy: api.algofrog.in → *.supabase.co
 * Bypasses ISP blocks on supabase.co in India (Jio, Airtel, etc.).
 */

export interface Env {
  SUPABASE_ORIGIN: string;
  /** Injected for /functions/v1/* when external callers (Razorpay) omit apikey */
  SUPABASE_ANON_KEY?: string;
  /** Comma-separated allowed browser origins for CORS */
  ALLOWED_ORIGINS?: string;
}

const DEFAULT_ORIGINS = [
  'https://algofrog.in',
  'https://www.algofrog.in',
  'http://localhost:4321',
  'http://127.0.0.1:4321',
];

function allowedOrigins(env: Env): string[] {
  const extra = env.ALLOWED_ORIGINS?.split(',').map((s) => s.trim()).filter(Boolean) ?? [];
  return [...DEFAULT_ORIGINS, ...extra];
}

function corsOrigin(request: Request, env: Env): string | null {
  const origin = request.headers.get('Origin');
  if (!origin) return null;
  return allowedOrigins(env).includes(origin) ? origin : null;
}

function corsHeaders(request: Request, env: Env): Headers {
  const headers = new Headers();
  const origin = corsOrigin(request, env);
  if (origin) {
    headers.set('Access-Control-Allow-Origin', origin);
    headers.set('Access-Control-Allow-Credentials', 'true');
  }
  headers.set(
    'Access-Control-Allow-Headers',
    'authorization, x-client-info, apikey, content-type, x-supabase-api-version, accept, accept-profile, content-profile, prefer, range, x-upsert',
  );
  headers.set('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD');
  headers.set('Access-Control-Max-Age', '86400');
  return headers;
}

function mergeCors(base: Headers, cors: Headers): Headers {
  const out = new Headers(base);
  // Drop upstream CORS headers (Supabase sets its own) — duplicates break browsers.
  for (const key of [...out.keys()]) {
    if (key.toLowerCase().startsWith('access-control-')) {
      out.delete(key);
    }
  }
  cors.forEach((v, k) => out.set(k, v));
  return out;
}

function rewriteLocation(location: string, supabaseOrigin: string, proxyOrigin: string): string {
  if (location.startsWith(supabaseOrigin)) {
    return proxyOrigin + location.slice(supabaseOrigin.length);
  }
  return location;
}

async function proxyToSupabase(request: Request, env: Env): Promise<Response> {
  const supabaseOrigin = env.SUPABASE_ORIGIN.replace(/\/$/, '');
  if (!supabaseOrigin.startsWith('https://')) {
    return new Response('SUPABASE_ORIGIN must be https://…', { status: 500 });
  }

  const incoming = new URL(request.url);
  const proxyOrigin = `${incoming.protocol}//${incoming.host}`;
  const target = new URL(incoming.pathname + incoming.search, supabaseOrigin);
  const headers = new Headers(request.headers);
  const isEdgeFunction = incoming.pathname.startsWith('/functions/v1/');
  const anonKey = env.SUPABASE_ANON_KEY?.trim();
  if (
    isEdgeFunction &&
    anonKey &&
    !headers.has('apikey') &&
    !headers.has('authorization')
  ) {
    headers.set('apikey', anonKey);
    headers.set('Authorization', `Bearer ${anonKey}`);
  }
  const proxied = new Request(target.toString(), {
    method: request.method,
    headers,
    body: request.body,
    redirect: 'manual',
  });

  const upstream = await fetch(proxied, { redirect: 'manual' });
  const responseHeaders = new Headers(upstream.headers);

  const location = responseHeaders.get('Location');
  if (location) {
    responseHeaders.set('Location', rewriteLocation(location, supabaseOrigin, proxyOrigin));
  }

  return new Response(upstream.body, {
    status: upstream.status,
    statusText: upstream.statusText,
    headers: mergeCors(responseHeaders, corsHeaders(request, env)),
  });
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    if (request.method === 'OPTIONS') {
      const origin = corsOrigin(request, env);
      if (!origin) {
        return new Response(null, { status: 403 });
      }
      return new Response(null, { status: 204, headers: corsHeaders(request, env) });
    }

    try {
      return await proxyToSupabase(request, env);
    } catch (err) {
      console.error('proxy error:', err);
      return new Response('Proxy error', { status: 502 });
    }
  },
};
