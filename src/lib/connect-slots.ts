import { supabase } from './supabase';

export type ConnectSlot = {
  id: number;
  service_id: string;
  starts_at: string;
  ends_at: string;
  status: 'available' | 'reserved' | 'paid' | 'cancelled';
};

function parseRpcJsonArray<T>(data: unknown): T[] {
  if (Array.isArray(data)) return data as T[];
  if (typeof data === 'string') {
    try {
      const parsed = JSON.parse(data) as unknown;
      return Array.isArray(parsed) ? (parsed as T[]) : [];
    } catch {
      return [];
    }
  }
  return [];
}

/** Load open slots from Supabase `connect_slots` (no static fallback). */
export async function loadConnectSlots(): Promise<ConnectSlot[]> {
  await supabase.rpc('sweep_connect_holds');

  const { data, error } = await supabase
    .from('connect_slots')
    .select('id, service_id, starts_at, ends_at, status')
    .eq('status', 'available')
    .gt('starts_at', new Date().toISOString())
    .order('starts_at', { ascending: true });

  if (error) {
    console.error('Failed to load connect slots:', error);
    return [];
  }

  return (data ?? []) as ConnectSlot[];
}

/** Load the signed-in user's upcoming paid (and checkout-held) slots. */
export async function loadMyConnectBookings(): Promise<ConnectSlot[]> {
  const {
    data: { session },
  } = await supabase.auth.getSession();
  if (!session) return [];

  const merged = new Map<number, ConnectSlot>();
  const nowIso = new Date().toISOString();

  const { data: rpcData, error: rpcErr } = await supabase.rpc('list_my_connect_bookings');
  if (!rpcErr) {
    for (const row of parseRpcJsonArray<ConnectSlot>(rpcData)) {
      if (row?.id != null) merged.set(Number(row.id), row);
    }
  } else {
    console.warn('list_my_connect_bookings RPC failed:', rpcErr.message);
  }

  const { data: tableRows, error: tableErr } = await supabase
    .from('connect_slots')
    .select('id, service_id, starts_at, ends_at, status')
    .eq('booked_by', session.user.id)
    .in('status', ['paid', 'reserved'])
    .gt('ends_at', nowIso)
    .order('starts_at', { ascending: true });

  if (!tableErr && tableRows) {
    for (const row of tableRows as ConnectSlot[]) {
      merged.set(row.id, row);
    }
  } else if (tableErr) {
    console.error('Failed to load my connect bookings from table:', tableErr);
  }

  return [...merged.values()].sort((a, b) => a.starts_at.localeCompare(b.starts_at));
}
