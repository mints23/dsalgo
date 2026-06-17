import { supabase } from './supabase';

export const PRO_AMOUNT_PAISE = {
  monthly: 14900,
  quarterly: 29900,
} as const;

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

function sleep(ms: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, ms));
}

/** Poll until webhook activates Pro for this payment (or timeout). */
export async function waitForProActivation(
  paymentId: string,
  userId: string,
  timeoutMs = 45000,
): Promise<boolean> {
  const deadline = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    const { data } = await supabase
      .from('subscriptions')
      .select('status, paid_until, razorpay_payment_id')
      .eq('user_id', userId)
      .maybeSingle();

    if (
      data?.razorpay_payment_id === paymentId &&
      data.status === 'active' &&
      data.paid_until &&
      new Date(data.paid_until) > new Date()
    ) {
      return true;
    }
    await sleep(2000);
  }
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
  while (Date.now() < deadline) {
    const { data } = await supabase
      .from('connect_slots')
      .select('id, status, razorpay_payment_id, booked_by')
      .eq('id', slotId)
      .eq('booked_by', userId)
      .maybeSingle();

    if (data?.status === 'paid' && data.razorpay_payment_id === paymentId) {
      return true;
    }
    await sleep(2000);
  }
  return false;
}
