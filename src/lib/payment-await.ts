import { supabase } from './supabase';

export const PRO_AMOUNT_PAISE = {
  monthly: 16900,
  quarterly: 29900,
} as const;

export const PRO_MONTHLY_INR = PRO_AMOUNT_PAISE.monthly / 100;

export type ProPlan = keyof typeof PRO_AMOUNT_PAISE;

export function proPaymentNotes(userId: string, plan: ProPlan): Record<string, string> {
  return {
    type: 'pro',
    user_id: userId,
    plan,
  };
}

export function connectPaymentNotes(
  userId: string,
  slotId: number,
  serviceId: string,
  amountPaise: number,
): Record<string, string> {
  return {
    type: 'connect',
    user_id: userId,
    slot_id: String(slotId),
    service_id: serviceId,
    amount_paise: String(amountPaise),
  };
}

export type CheckoutOrderResult =
  | { ok: true; orderId: string; amount: number }
  | { ok: false; error: string };

async function parseInvokeErrorBody(error: unknown): Promise<string> {
  if (!error || typeof error !== 'object') return 'invoke_failed';
  const ctx = (error as { context?: Response }).context;
  if (ctx && typeof ctx.json === 'function') {
    try {
      const body = (await ctx.json()) as {
        error?: string;
        status?: string;
        detail?: string;
      };
      if (body?.error === 'payment_not_captured' && body.status) {
        return `payment_not_captured (${body.status})`;
      }
      if (body?.error === 'razorpay_keys_missing') {
        return 'razorpay_keys_missing — set RAZORPAY_KEY_ID and RAZORPAY_KEY_SECRET in Supabase Edge Function secrets';
      }
      if (body?.error === 'razorpay_order_failed' && body.detail) {
        return `razorpay_order_failed: ${body.detail.slice(0, 200)}`;
      }
      if (body?.error) return body.error;
    } catch {
      /* ignore */
    }
  }
  const message = (error as { message?: string }).message ?? 'invoke_failed';
  if (/not found|404|Failed to send a request/i.test(message)) {
    return 'function_not_deployed — create and deploy razorpay-create-order in Supabase Dashboard';
  }
  return message;
}

/** Create Razorpay order with auto-capture before opening Checkout. */
export async function createCheckoutOrder(
  body: Record<string, unknown>,
): Promise<CheckoutOrderResult> {
  const { data, error } = await supabase.functions.invoke('razorpay-create-order', { body });
  if (error) {
    const msg = await parseInvokeErrorBody(error);
    console.warn('razorpay-create-order:', msg, error);
    return { ok: false, error: msg };
  }
  const payload = data as {
    ok?: boolean;
    order_id?: string;
    amount?: number;
    error?: string;
    detail?: string;
  } | null;
  if (!payload?.ok || !payload.order_id) {
    const err =
      payload?.error === 'razorpay_keys_missing'
        ? 'razorpay_keys_missing — set RAZORPAY_KEY_ID and RAZORPAY_KEY_SECRET in Supabase Edge Function secrets'
        : payload?.error === 'razorpay_order_failed' && payload.detail
          ? `razorpay_order_failed: ${String(payload.detail).slice(0, 200)}`
          : payload?.error ?? 'unknown_order_error';
    console.warn('razorpay-create-order response:', payload);
    return { ok: false, error: err };
  }
  return { orderId: payload.order_id, amount: payload.amount ?? 0, ok: true };
}

export async function createProCheckoutOrder(plan: ProPlan): Promise<CheckoutOrderResult> {
  return createCheckoutOrder({ kind: 'pro', plan });
}

/** Server order when available; falls back to client amount so Checkout can still open. */
export async function resolveProCheckout(plan: ProPlan): Promise<{
  amount: number;
  orderId?: string;
  orderError?: string;
}> {
  const order = await createProCheckoutOrder(plan);
  if (order.ok) {
    return { orderId: order.orderId, amount: order.amount };
  }
  return { amount: PRO_AMOUNT_PAISE[plan], orderError: order.error };
}

export async function createConnectCheckoutOrder(
  slotId: number,
  serviceId: string,
  amountPaise: number,
): Promise<CheckoutOrderResult> {
  return createCheckoutOrder({
    kind: 'connect',
    slot_id: slotId,
    service_id: serviceId,
    amount_paise: amountPaise,
  });
}

/** Connect checkout with amount fallback when order API is unavailable. */
export async function resolveConnectCheckout(
  slotId: number,
  serviceId: string,
  amountPaise: number,
): Promise<{ amount: number; orderId?: string; orderError?: string }> {
  const order = await createConnectCheckoutOrder(slotId, serviceId, amountPaise);
  if (order.ok) {
    return { orderId: order.orderId, amount: order.amount };
  }
  return { amount: amountPaise, orderError: order.error };
}

function sleep(ms: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, ms));
}

type SubRow = {
  status?: string;
  paid_until?: string | null;
  razorpay_payment_id?: string | null;
};

function isProRowActive(row: SubRow | null | undefined, paymentId?: string): boolean {
  if (!row || row.status !== 'active' || !row.paid_until) return false;
  if (new Date(row.paid_until) <= new Date()) return false;
  if (paymentId && row.razorpay_payment_id && row.razorpay_payment_id !== paymentId) return false;
  return true;
}

type ConfirmResult = { ok: true } | { ok: false; error: string };

async function parseConfirmInvokeError(error: unknown): Promise<string> {
  return parseInvokeErrorBody(error);
}

const INVOKE_TIMEOUT_MS = 22000;

/** Ask Edge Function to verify payment with Razorpay API and activate (fast path). */
async function confirmPaymentViaEdge(body: Record<string, unknown>): Promise<ConfirmResult> {
  try {
    const invoke = supabase.functions.invoke('razorpay-confirm-payment', { body });
    const raced = await Promise.race([
      invoke,
      sleep(INVOKE_TIMEOUT_MS).then(() => ({ timedOut: true as const })),
    ]);

    if ('timedOut' in raced) {
      console.warn('razorpay-confirm-payment: timed out');
      return { ok: false, error: 'timeout' };
    }

    const { data, error } = raced;
    if (error) {
      const msg = await parseConfirmInvokeError(error);
      console.warn('razorpay-confirm-payment:', msg, error);
      return { ok: false, error: msg };
    }

    const payload = data as { ok?: boolean; error?: string } | null;
    if (!payload?.ok) {
      console.warn('razorpay-confirm-payment response:', payload);
      return { ok: false, error: payload?.error ?? 'unknown' };
    }
    return { ok: true };
  } catch (e) {
    console.warn('razorpay-confirm-payment exception:', e);
    return { ok: false, error: String(e) };
  }
}

async function fetchSubscription(userId: string) {
  return supabase
    .from('subscriptions')
    .select('status, paid_until, razorpay_payment_id')
    .eq('user_id', userId)
    .maybeSingle();
}

export type ProActivationProgress = (message: string) => void;

/** Poll until Pro is active for this payment (or timeout). */
export async function waitForProActivation(
  paymentId: string,
  userId: string,
  plan: ProPlan = 'monthly',
  options?: { timeoutMs?: number; onProgress?: ProActivationProgress },
): Promise<boolean> {
  const timeoutMs = options?.timeoutMs ?? 45000;
  const onProgress = options?.onProgress;
  const deadline = Date.now() + timeoutMs;
  let lastError = '';

  onProgress?.('Confirming your payment…');

  for (let attempt = 0; Date.now() < deadline; attempt++) {
    const confirm = await confirmPaymentViaEdge({ payment_id: paymentId, plan });
    if (confirm.ok) {
      onProgress?.('Welcome to Pro!');
      return true;
    }
    lastError = confirm.error;

    const { data } = await fetchSubscription(userId);
    if (isProRowActive(data, paymentId) || isProRowActive(data)) {
      return true;
    }

    if (lastError === 'unauthorized') {
      onProgress?.('Please sign in again');
      return false;
    }

    if (attempt >= 2) {
      onProgress?.('Almost there…');
    } else if (attempt === 1) {
      onProgress?.('Finishing your upgrade…');
    } else {
      onProgress?.('Confirming your payment…');
    }

    await sleep(attempt < 3 ? 700 : 1200);
  }

  console.warn('Pro activation timed out. Last error:', lastError);
  return false;
}

/** Poll until webhook marks Connect slot paid (or timeout). */
export async function waitForConnectPaid(
  slotId: number,
  paymentId: string,
  userId: string,
  timeoutMs = 45000,
): Promise<boolean> {
  const deadline = Date.now() + timeoutMs;

  for (let attempt = 0; Date.now() < deadline; attempt++) {
    const confirm = await confirmPaymentViaEdge({ payment_id: paymentId, slot_id: slotId });
    if (confirm.ok) return true;

    const { data } = await supabase
      .from('connect_slots')
      .select('id, status, razorpay_payment_id, booked_by')
      .eq('id', slotId)
      .eq('booked_by', userId)
      .maybeSingle();

    if (data?.status === 'paid' && data.razorpay_payment_id === paymentId) {
      return true;
    }
    await sleep(attempt < 3 ? 700 : 1200);
  }
  return false;
}

/** Full-page reload after payment (cache-bust). */
export function reloadAfterPayment() {
  const url = new URL(window.location.href);
  url.searchParams.set('pro', '1');
  window.location.replace(url.toString());
}
