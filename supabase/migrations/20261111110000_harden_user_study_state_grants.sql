-- Least-privilege grants for user-owned study state.
-- RLS remains enabled with auth.uid() ownership predicates.
-- TRUNCATE bypasses row-level security, so it must not be granted to clients.
REVOKE ALL PRIVILEGES ON TABLE public.user_progress, public.user_revision FROM anon;
REVOKE TRUNCATE ON TABLE public.user_progress, public.user_revision FROM authenticated;
