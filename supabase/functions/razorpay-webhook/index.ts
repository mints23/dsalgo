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

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
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
    console.error('Invalid Razorpay webhook signature');
    return new Response('Invalid signature', { status: 401, headers: corsHeaders });
  }

  let event: {
    event?: string;
    payload?: { payment?: { entity?: Record<string, unknown> } };
  };

  try {
    event = JSON.parse(body);
  } catch {
    return new Response('Invalid JSON', { status: 400, headers: corsHeaders });
  }

  if (event.event !== 'payment.captured') {
    return new Response(JSON.stringify({ ok: true, skipped: event.event }), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  const payment = event.payload?.payment?.entity as
    | {
        id?: string;
        amount?: number;
        currency?: string;
        status?: string;
        notes?: RazorpayNotes;
      }
    | undefined;

  if (!payment?.id || payment.status !== 'captured' || payment.currency !== 'INR') {
    return new Response(JSON.stringify({ ok: true, ignored: true }), {
      status: 200,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }

  const notes = payment.notes ?? {};
  const type = notes.type;
  const userId = notes.user_id;
  const paymentId = payment.id;
  const amount = payment.amount ?? 0;

  if (!type || !userId) {
    console.error('Webhook missing notes.type or notes.user_id', notes);
    return new Response(JSON.stringify({ ok: true, ignored: 'missing_notes' }), {
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
