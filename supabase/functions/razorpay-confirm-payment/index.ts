/**
 * Authenticated fallback: verify payment with Razorpay API and activate immediately.
 * Use after Checkout success so users are not blocked on webhook delivery delay.
 */
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.49.1';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

type RazorpayNotes = Record<string, string>;

type RazorpayPayment = {
  id?: string;
  amount?: number;
  currency?: string;
  status?: string;
  notes?: RazorpayNotes;
  order_id?: string;
  email?: string;
};

function razorpayBasicAuth(): string | null {
  const keyId = Deno.env.get('RAZORPAY_KEY_ID');
  const keySecret = Deno.env.get('RAZORPAY_KEY_SECRET');
  if (!keyId || !keySecret) {
    console.error('RAZORPAY_KEY_ID / RAZORPAY_KEY_SECRET not set');
    return null;
  }
  return `Basic ${btoa(`${keyId}:${keySecret}`)}`;
}

async function fetchRazorpayPayment(paymentId: string, retries = 2): Promise<RazorpayPayment | null> {
  const auth = razorpayBasicAuth();
  if (!auth) return null;
  for (let i = 0; i < retries; i++) {
    const res = await fetch(`https://api.razorpay.com/v1/payments/${encodeURIComponent(paymentId)}`, {
      headers: { Authorization: auth },
    });
    if (!res.ok) {
      console.error('Razorpay fetch payment failed', res.status, await res.text());
      if (i < retries - 1) await new Promise((r) => setTimeout(r, 1000));
      continue;
    }
    const payment = (await res.json()) as RazorpayPayment;
    if (payment.status === 'captured' || payment.status === 'authorized') return payment;
    if (i < retries - 1) await new Promise((r) => setTimeout(r, 1000));
    else return payment;
  }
  return null;
}

/** Manual-capture accounts: capture authorized payments before Pro activation. */
async function captureRazorpayPayment(
  paymentId: string,
  amount: number,
  currency: string,
): Promise<{ payment: RazorpayPayment | null; error?: string }> {
  const auth = razorpayBasicAuth();
  if (!auth) return { payment: null, error: 'razorpay_keys_missing' };
  const res = await fetch(`https://api.razorpay.com/v1/payments/${encodeURIComponent(paymentId)}/capture`, {
    method: 'POST',
    headers: { Authorization: auth, 'Content-Type': 'application/json' },
    body: JSON.stringify({ amount, currency }),
  });
  const text = await res.text();
  if (!res.ok) {
    console.error('Razorpay capture failed', res.status, text);
    return { payment: null, error: text };
  }
  try {
    return { payment: JSON.parse(text) as RazorpayPayment };
  } catch {
    return { payment: null, error: 'invalid_capture_response' };
  }
}

type CaptureResult = {
  payment: RazorpayPayment | null;
  captureError?: string;
  status?: string;
};

async function fetchOrderNotes(orderId: string): Promise<RazorpayNotes> {
  const auth = razorpayBasicAuth();
  if (!auth) return {};
  const res = await fetch(`https://api.razorpay.com/v1/orders/${encodeURIComponent(orderId)}`, {
    headers: { Authorization: auth },
  });
  if (!res.ok) return {};
  try {
    const order = (await res.json()) as { notes?: RazorpayNotes };
    return order.notes ?? {};
  } catch {
    return {};
  }
}

async function ensurePaymentCaptured(paymentId: string): Promise<CaptureResult> {
  let payment = await fetchRazorpayPayment(paymentId);
  if (!payment?.id || payment.currency !== 'INR') {
    return { payment: null, status: payment?.status };
  }
  if (payment.status === 'captured') return { payment };

  if (payment.status === 'authorized' && payment.amount) {
    for (let i = 0; i < 3; i++) {
      const { payment: captured, error } = await captureRazorpayPayment(
        paymentId,
        payment.amount,
        payment.currency ?? 'INR',
      );
      if (captured?.status === 'captured') {
        if (payment.order_id && !captured.notes?.type) {
          const orderNotes = await fetchOrderNotes(payment.order_id);
          captured.notes = { ...orderNotes, ...(captured.notes ?? {}) };
        }
        return { payment: captured };
      }
      if (i === 0) {
        payment = (await fetchRazorpayPayment(paymentId, 1)) ?? payment;
        if (payment.status === 'captured') return { payment };
      }
      if (i < 2) await new Promise((r) => setTimeout(r, 1500));
      else return { payment: null, captureError: error, status: 'authorized' };
    }
  }
  return { payment: null, status: payment.status };
}

function expectedProAmountPaise(plan: string): number {
  return plan === 'quarterly' ? 29900 : 16900;
}

/** Payment must be tied to the JWT user via order notes or Razorpay payer email. */
function paymentBelongsToUser(
  notes: RazorpayNotes,
  payment: RazorpayPayment,
  user: { id: string; email?: string },
): boolean {
  const noteUserId = notes.user_id?.trim();
  if (noteUserId) return noteUserId === user.id;
  const payEmail = payment.email?.trim().toLowerCase();
  const userEmail = user.email?.trim().toLowerCase();
  return !!(payEmail && userEmail && payEmail === userEmail);
}

function jsonResponse(body: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }
  if (req.method !== 'POST') {
    return new Response('Method not allowed', { status: 405, headers: corsHeaders });
  }

  const authHeader = req.headers.get('Authorization');
  if (!authHeader) {
    return jsonResponse({ ok: false, error: 'unauthorized' }, 401);
  }

  const supabaseUrl = Deno.env.get('SUPABASE_URL');
  const anonKey = Deno.env.get('SUPABASE_ANON_KEY');
  const serviceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');
  if (!supabaseUrl || !anonKey || !serviceKey) {
    console.error('Supabase env missing');
    return jsonResponse({ ok: false, error: 'misconfigured' }, 500);
  }

  const userClient = createClient(supabaseUrl, anonKey, {
    global: { headers: { Authorization: authHeader } },
  });
  const {
    data: { user },
    error: userErr,
  } = await userClient.auth.getUser();
  if (userErr || !user) {
    return jsonResponse({ ok: false, error: 'unauthorized' }, 401);
  }

  let body: { payment_id?: string; plan?: string; slot_id?: number };
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ ok: false, error: 'invalid_json' }, 400);
  }

  const paymentId = body.payment_id?.trim();
  if (!paymentId) {
    return jsonResponse({ ok: false, error: 'payment_id required' }, 400);
  }

  const captureResult = await ensurePaymentCaptured(paymentId);
  const payment = captureResult.payment;
  if (!payment?.id) {
    return jsonResponse({
      ok: false,
      error: 'payment_not_captured',
      status: captureResult.status ?? 'unknown',
      capture_error: captureResult.captureError ?? null,
    }, 400);
  }
  if (payment.currency !== 'INR' || payment.status !== 'captured') {
    return jsonResponse({ ok: false, error: 'payment_not_captured', status: payment.status }, 400);
  }

  const notes = {
    ...(payment.order_id ? await fetchOrderNotes(payment.order_id) : {}),
    ...(payment.notes ?? {}),
  };
  const amount = payment.amount ?? 0;
  const plan = (notes.plan || body.plan || 'monthly').toLowerCase();
  const noteType = notes.type;

  if (!paymentBelongsToUser(notes, payment, user)) {
    return jsonResponse({ ok: false, error: 'payment_user_mismatch' }, 403);
  }

  const admin = createClient(supabaseUrl, serviceKey);

  const isProPayment =
    noteType === 'pro' ||
    (noteType !== 'connect' && body.plan && amount === expectedProAmountPaise(plan));

  if (isProPayment) {
    if (amount !== expectedProAmountPaise(plan)) {
      return jsonResponse({ ok: false, error: 'pro_amount_mismatch' }, 400);
    }
    const { error } = await admin.rpc('webhook_activate_subscription', {
      p_payment_id: paymentId,
      p_user_id: user.id,
      p_plan: plan,
      p_amount_paise: amount,
    });
    if (error) {
      console.error('webhook_activate_subscription:', error.message);
      return jsonResponse({ ok: false, error: error.message }, 500);
    }
    return jsonResponse({ ok: true, kind: 'pro' });
  }

  if (noteType === 'connect') {
    const slotId = Number(notes.slot_id);
    const serviceId = notes.service_id;
    const notesAmount = Number(notes.amount_paise);
    if (!slotId || !serviceId || !notesAmount || notesAmount !== amount) {
      return jsonResponse({ ok: false, error: 'connect_notes_invalid' }, 400);
    }
    const { error } = await admin.rpc('webhook_confirm_connect_slot', {
      p_payment_id: paymentId,
      p_user_id: user.id,
      p_slot_id: slotId,
      p_service_id: serviceId,
      p_amount_paise: amount,
    });
    if (error) {
      console.error('webhook_confirm_connect_slot:', error.message);
      return jsonResponse({ ok: false, error: error.message }, 500);
    }
    return jsonResponse({ ok: true, kind: 'connect' });
  }

  return jsonResponse({ ok: false, error: 'unknown_payment_type' }, 400);
});
