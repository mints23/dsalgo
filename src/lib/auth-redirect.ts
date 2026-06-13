/** Safe in-app path from `?redirect=` (blocks open redirects). */
export function getSafeRedirectPath(search = typeof window !== 'undefined' ? window.location.search : ''): string {
  const raw = new URLSearchParams(search).get('redirect');
  if (!raw || !raw.startsWith('/') || raw.startsWith('//') || raw.includes('://')) {
    return '/';
  }
  return raw;
}

function normalizeRedirectPath(path: string): string {
  if (path.startsWith('/') && !path.startsWith('//') && !path.includes('://')) {
    return path;
  }
  return '/';
}

/** Best redirect target: query param, else same-origin referrer, else home. */
export function resolveLoginRedirectPath(): string {
  const fromQuery = getSafeRedirectPath();
  if (fromQuery !== '/') return fromQuery;

  if (typeof document === 'undefined' || typeof window === 'undefined') return '/';

  try {
    if (!document.referrer) return '/';
    const ref = new URL(document.referrer);
    if (ref.origin !== window.location.origin) return '/';
    if (ref.pathname === '/login' || ref.pathname.startsWith('/auth/')) return '/';
    return normalizeRedirectPath(ref.pathname + ref.search);
  } catch {
    return '/';
  }
}

/** Current app origin — always the tab you are on (localhost in dev, algofrog.in in prod). */
export function getAppOrigin(): string {
  if (typeof window !== 'undefined') {
    return window.location.origin;
  }
  const fromEnv = import.meta.env.PUBLIC_AUTH_REDIRECT_ORIGIN;
  if (typeof fromEnv === 'string' && fromEnv.trim()) {
    return fromEnv.trim().replace(/\/$/, '');
  }
  return 'https://algofrog.in';
}

/** Navigate to an in-app path without leaving the current origin. */
export function goToAppPath(path: string) {
  window.location.replace(`${getAppOrigin()}${normalizeRedirectPath(path)}`);
}

/** OAuth callback URL — whitelist `${origin}/auth/callback` (or `${origin}/**`) in Supabase. */
export function getAuthCallbackUrl(): string {
  return `${getAppOrigin()}/auth/callback`;
}

/** Email confirmation links may return to login with a redirect path. */
export function getLoginOAuthReturnUrl(redirectPath: string): string {
  const safe = normalizeRedirectPath(redirectPath);
  return `${getAppOrigin()}/login?redirect=${encodeURIComponent(safe)}`;
}

export const AUTH_REDIRECT_STORAGE_KEY = 'auth_redirect';

export function storeAuthRedirect(path: string) {
  if (typeof sessionStorage === 'undefined') return;
  sessionStorage.setItem(AUTH_REDIRECT_STORAGE_KEY, normalizeRedirectPath(path));
}

export function readStoredAuthRedirect(): string {
  if (typeof sessionStorage === 'undefined') return '/';
  const raw = sessionStorage.getItem(AUTH_REDIRECT_STORAGE_KEY);
  sessionStorage.removeItem(AUTH_REDIRECT_STORAGE_KEY);
  return normalizeRedirectPath(raw ?? '/');
}
