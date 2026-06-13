/** Open slots — student picks service on Connect after choosing time. */
export const CONNECT_SLOT_SERVICE_ID = 'open';

export const IST = 'Asia/Kolkata';

/** Default evening columns shown on Connect + admin grid. */
export const CONNECT_SLOT_PRESETS = [
  { label: '6:00 PM', time: '18:00', durationMins: 60 },
  { label: '7:30 PM', time: '19:30', durationMins: 45 },
  { label: '8:30 PM', time: '20:30', durationMins: 60 },
] as const;

export function istDateKey(iso: string): string {
  return new Intl.DateTimeFormat('en-CA', { timeZone: IST }).format(new Date(iso));
}

/** 24h `HH:mm` in IST for matching preset columns. */
export function istTime24(iso: string): string {
  const parts = new Intl.DateTimeFormat('en-GB', {
    timeZone: IST,
    hour: '2-digit',
    minute: '2-digit',
    hour12: false,
  }).formatToParts(new Date(iso));
  const h = parts.find((p) => p.type === 'hour')?.value ?? '00';
  const m = parts.find((p) => p.type === 'minute')?.value ?? '00';
  return `${h}:${m}`;
}

/** Convert date + time entered as IST into UTC ISO string. */
export function istToUtcIso(dateStr: string, timeStr: string): string {
  const [y, m, d] = dateStr.split('-').map(Number);
  const [hh, mm] = timeStr.split(':').map(Number);
  const probe = new Date(Date.UTC(y, m - 1, d, hh, mm));
  const parts = new Intl.DateTimeFormat('en-US', {
    timeZone: IST,
    timeZoneName: 'shortOffset',
  }).formatToParts(probe);
  const offsetPart = parts.find((p) => p.type === 'timeZoneName')?.value ?? 'GMT+5:30';
  const match = offsetPart.match(/GMT([+-])(\d{1,2})(?::(\d{2}))?/);
  let offsetMin = 330;
  if (match) {
    const sign = match[1] === '+' ? 1 : -1;
    offsetMin = sign * (Number(match[2]) * 60 + Number(match[3] ?? '0'));
  }
  return new Date(Date.UTC(y, m - 1, d, hh, mm) - offsetMin * 60_000).toISOString();
}

export function istTodayKey(): string {
  return new Intl.DateTimeFormat('en-CA', { timeZone: IST }).format(new Date());
}

/** Next N calendar dates from tomorrow (IST), as `YYYY-MM-DD`. */
export function upcomingIstDateKeys(count: number): string[] {
  const keys: string[] = [];
  const base = new Date();
  for (let i = 1; i <= count; i++) {
    const day = new Date(base.getTime() + i * 86_400_000);
    keys.push(new Intl.DateTimeFormat('en-CA', { timeZone: IST }).format(day));
  }
  return keys;
}
