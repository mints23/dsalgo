import { supabase } from './supabase';

/** True when subscriptions.is_admin is set for the signed-in user. */
export async function fetchIsAdmin(): Promise<boolean> {
  const {
    data: { session },
  } = await supabase.auth.getSession();
  if (!session) return false;

  const { data, error } = await supabase
    .from('subscriptions')
    .select('is_admin')
    .eq('user_id', session.user.id)
    .maybeSingle();

  if (error) {
    console.error('admin flag load:', error);
    return false;
  }

  return !!data?.is_admin;
}

export function setAdminNavLink(link: HTMLElement | null, isAdmin: boolean) {
  if (!link) return;
  link.hidden = !isAdmin;
  if (isAdmin) {
    link.removeAttribute('aria-hidden');
  } else {
    link.setAttribute('aria-hidden', 'true');
  }
}
