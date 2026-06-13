import { supabase } from './supabase';

export type ConnectSlot = {
  id: number;
  service_id: string;
  starts_at: string;
  ends_at: string;
  status: 'available' | 'reserved' | 'paid' | 'cancelled';
};

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
