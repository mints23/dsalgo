import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.49.1';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type, x-razorpay-signature',
};

async function hmacSha256Hex(secret: string, body: string): Promise<string> {
  const key = await crypto.subtle.importKey(
    'raw',
    new TextEncoder().encode(secret),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  const sig = await crypto.subtle.sign('HMAC', key, new TextEncoder().encode(body));
  return Array.from(new Uint8Array(sig))
    .map((b) => b.toString(16).padStart(2, '0'))
    .join('');
}

type RazorpayNotes = Record<string, string>;

type RazorpayPayment = {
  id?: string;
  amount?: number;
  currency?: string;
  status?: string;
  notes?: RazorpayNotes;
  order_id?: string;
};

async function fetchOrderNotes(orderId: string): Promise<RazorpayNotes> {
  const auth = razorpayBasicAuth();
  if (!auth) return {};
  const res = await fetch(`https://api.razorpay.com/v1/orders/${encodeURIComponent(orderId)}`, {
    headers: { Authorization: auth },
  });
  if (!res.ok) {
    console.error('fetch order notes failed', orderId, res.status);
    return {};
  }
  try {
    const order = (await res.json()) as { notes?: RazorpayNotes };
    return order.notes ?? {};
  } catch {
    return {};
  }
}

async function resolvePaymentNotes(
  payment: RazorpayPayment,
  orderNotesFromEvent?: RazorpayNotes,
): Promise<RazorpayNotes> {
  const fromEvent = { ...(orderNotesFromEvent ?? {}), ...(payment.notes ?? {}) };
  if (fromEvent.type && fromEvent.user_id) return fromEvent;
  if (payment.order_id) {
    const fromOrder = await fetchOrderNotes(payment.order_id);
    return { ...fromOrder, ...fromEvent };
  }
  return fromEvent;
}

function razorpayBasicAuth(): string | null {
  const keyId = Deno.env.get('RAZORPAY_KEY_ID');
  const keySecret = Deno.env.get('RAZORPAY_KEY_SECRET');
  if (!keyId || !keySecret) return null;
  return `Basic ${btoa(`${keyId}:${keySecret}`)}`;
}

async function captureRazorpayPayment(
  paymentId: string,
  amount: number,
  currency: string,
): Promise<RazorpayPayment | null> {
  const auth = razorpayBasicAuth();
  if (!auth) return null;
  const res = await fetch(`https://api.razorpay.com/v1/payments/${encodeURIComponent(paymentId)}/capture`, {
    method: 'POST',
    headers: { Authorization: auth, 'Content-Type': 'application/json' },
    body: JSON.stringify({ amount, currency }),
  });
  const text = await res.text();
  if (!res.ok) {
    console.error('Razorpay capture failed', paymentId, res.status, text);
    return null;
  }
  try {
    return JSON.parse(text) as RazorpayPayment;
  } catch {
    return null;
  }
}

async function ensurePaymentCaptured(payment: RazorpayPayment): Promise<RazorpayPayment | null> {
  if (!payment.id || payment.currency !== 'INR') return null;
  if (payment.status === 'captured') return payment;
  if (payment.status === 'authorized' && payment.amount) {
    for (let i = 0; i < 3; i++) {
      const captured = await captureRazorpayPayment(
        payment.id,
        payment.amount,
        payment.currency ?? 'INR',
      );
      if (captured?.status === 'captured') return captured;
      if (i < 2) await new Promise((r) => setTimeout(r, 1500));
    }
  }
  return null;
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  if (req.method === 'GET') {
    return new Response(
      JSON.stringify({ ok: true, service: 'razorpay-webhook', jwt: false }),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } },
    );
  }

  if (req.method !== 'POST') {
    return new Response('Method not allowed', { status: 405, headers: corsHeaders });
  }

  const webhookSecret = Deno.env.get('RAZORPAY_WEBHOOK_SECRET');
  if (!webhookSecret) {
    console.error('RAZORPAY_WEBHOOK_SECRET is not set');
    return new Response('Server misconfigured', { status: 500, headers: corsHeaders });
  }

  const signature = req.headers.get('X-Razorpay-Signature') ?? '';
  const body = await req.text();

  const expected = await hmacSha256Hex(webhookSecret, body);
  if (!signature || signature !== expected) {
    console.error('Invalid Razorpay webhook signature', {
      hasSignature: !!signature,
      bodyLength: body.length,
    });
    return new Response('Invalid signature', { status: 401, headers: corsHeaders });
  }

  let event: {
    event?: string;
    payload?: { payment?: { entity?: RazorpayPayment }; order?: { entity?: { notes?: RazorpayNotes } } };
  };

  try {
    event = JSON.parse(body);
  } catch {
    return new Response('Invalid JSON', { status: 400, headers: corsHeaders });
  }

  const eventName = event.event ?? '';
  if (eventName !== 'payment.captured' && eventName !== 'payment.authorized') {
    return new Response(JSON.stringify({ ok: true, skipped: eventName }), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  let payment = event.payload?.payment?.entity;
  if (!payment?.id) {
    return new Response(JSON.stringify({ ok: true, ignored: true }), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  if (payment.status !== 'captured') {
    const captured = await ensurePaymentCaptured(payment);
    if (captured) {
      payment = captured;
    }
  }

  if (!payment.id || payment.status !== 'captured' || payment.currency !== 'INR') {
    return new Response(JSON.stringify({ ok: true, pending: payment.status }), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  const orderNotes = event.payload?.order?.entity?.notes;
  const notes = await resolvePaymentNotes(payment, orderNotes);
  const type = notes.type;
  const userId = notes.user_id;
  const paymentId = payment.id;
  const amount = payment.amount ?? 0;

  if (!type || !userId) {
    console.error('Webhook missing notes.type or notes.user_id', {
      paymentId: payment.id,
      orderId: payment.order_id,
      notes,
    });
    return new Response(JSON.stringify({ ok: true, ignored: 'missing_notes', payment_id: payment.id }), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  const supabaseUrl = Deno.env.get('SUPABASE_URL');
  const serviceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');
  if (!supabaseUrl || !serviceKey) {
    console.error('Supabase env missing');
    return new Response('Server misconfigured', { status: 500, headers: corsHeaders });
  }

  const supabase = createClient(supabaseUrl, serviceKey);

  if (type === 'pro') {
    const plan = notes.plan || 'monthly';
    const { error } = await supabase.rpc('webhook_activate_subscription', {
      p_payment_id: paymentId,
      p_user_id: userId,
      p_plan: plan,
      p_amount_paise: amount,
    });
    if (error) {
      console.error('webhook_activate_subscription:', error.message);
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }
  } else if (type === 'connect') {
    const slotId = Number(notes.slot_id);
    const serviceId = notes.service_id;
    const notesAmount = Number(notes.amount_paise);
    if (!slotId || !serviceId || !notesAmount || notesAmount !== amount) {
      console.error('Connect webhook amount/notes mismatch', { notes, amount });
      return new Response(JSON.stringify({ error: 'connect notes invalid' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }
    const { error } = await supabase.rpc('webhook_confirm_connect_slot', {
      p_payment_id: paymentId,
      p_user_id: userId,
      p_slot_id: slotId,
      p_service_id: serviceId,
      p_amount_paise: amount,
    });
    if (error) {
      console.error('webhook_confirm_connect_slot:', error.message);
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }
  } else {
    return new Response(JSON.stringify({ ok: true, skipped: type }), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  return new Response(JSON.stringify({ ok: true }), {
    status: 200,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
});
