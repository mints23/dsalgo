/**
 * Create Razorpay Order with payment_capture=1 so checkout auto-captures
 * (fixes "authorized" / pending payments on manual-capture accounts).
 */
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.49.1';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

function razorpayBasicAuth(): string | null {
  const keyId = Deno.env.get('RAZORPAY_KEY_ID');
  const keySecret = Deno.env.get('RAZORPAY_KEY_SECRET');
  if (!keyId || !keySecret) return null;
  return `Basic ${btoa(`${keyId}:${keySecret}`)}`;
}

function proAmountPaise(plan: string): number {
  return plan === 'quarterly' ? 29900 : 16900;
}

function connectAmountPaise(serviceId: string): number | null {
  switch (serviceId.trim()) {
    case 'system-design':
      return 49900;
    case 'roadmap':
      return 39900;
    case 'dsa-classes':
      return 39900;
    case 'cv-review':
      return 39900;
    case 'mentorship':
      return 79900;
    default:
      return null;
  }
}

function jsonResponse(body: Record<string, unknown>, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}

type CreateBody =
  | { kind?: string; plan?: string }
  | { kind?: string; slot_id?: number; service_id?: string; amount_paise?: number };

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
  if (!supabaseUrl || !anonKey) {
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

  let body: CreateBody;
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ ok: false, error: 'invalid_json' }, 400);
  }

  const auth = razorpayBasicAuth();
  if (!auth) {
    return jsonResponse({ ok: false, error: 'razorpay_keys_missing' }, 500);
  }

  let amount = 0;
  let notes: Record<string, string> = {};

  const kind = (body.kind ?? 'pro').toLowerCase();
  if (kind === 'pro') {
    const plan = (body.plan ?? 'monthly').toLowerCase();
    amount = proAmountPaise(plan);
    notes = { type: 'pro', user_id: user.id, plan };
  } else if (kind === 'connect') {
    const slotId = Number(body.slot_id);
    const serviceId = String(body.service_id ?? '').trim();
    const expected = connectAmountPaise(serviceId);
    const amountPaise = Number(body.amount_paise);
    if (!slotId || !serviceId || !expected || amountPaise !== expected) {
      return jsonResponse({ ok: false, error: 'connect_amount_invalid' }, 400);
    }
    amount = expected;
    notes = {
      type: 'connect',
      user_id: user.id,
      slot_id: String(slotId),
      service_id: serviceId,
      amount_paise: String(amount),
    };
  } else {
    return jsonResponse({ ok: false, error: 'unknown_kind' }, 400);
  }

  const orderRes = await fetch('https://api.razorpay.com/v1/orders', {
    method: 'POST',
    headers: { Authorization: auth, 'Content-Type': 'application/json' },
    body: JSON.stringify({
      amount,
      currency: 'INR',
      payment_capture: 1,
      notes,
    }),
  });

  const orderText = await orderRes.text();
  if (!orderRes.ok) {
    console.error('Razorpay create order failed', orderRes.status, orderText);
    return jsonResponse({ ok: false, error: 'razorpay_order_failed', detail: orderText }, 502);
  }

  let order: { id?: string; amount?: number };
  try {
    order = JSON.parse(orderText);
  } catch {
    return jsonResponse({ ok: false, error: 'razorpay_order_invalid' }, 502);
  }

  if (!order.id) {
    return jsonResponse({ ok: false, error: 'razorpay_order_missing_id' }, 502);
  }

  return jsonResponse({
    ok: true,
    order_id: order.id,
    amount: order.amount ?? amount,
    currency: 'INR',
  });
});
