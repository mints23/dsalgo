export type ConnectService = {
  id: string;
  title: string;
  benefit: string;
  hook: string;
  icon: string;
  subject: string;
  accent: string;
  price: string;
  pricePeriod?: string;
  mailBody: string;
  /** Paise for a single booked session (Razorpay). */
  sessionPricePaise?: number;
  /** When true, booking uses availability slots instead of mailto. */
  slotBooking?: boolean;
  /** Shown as coming soon — collects batch interest instead of booking. */
  comingSoon?: boolean;
};

/** Copy for services that collect batch interest (e.g. DSA Classes). */
export const connectBatchCopy = {
  badge: 'Next batch',
  cardHint: 'Join the next batch',
  cta: 'Add me to batch →',
  signInCta: 'Sign in to join batch →',
  modalLead:
    'Small live batches — patterns, live coding, and what interviewers actually test. Add yourself and we’ll email when the next batch opens.',
  success: "You're on the batch list. We'll email you when the next DSA Classes batch opens.",
  priceSuffix: 'next batch',
} as const;

export const SUPPORT_EMAIL = 'algofrog07@gmail.com';

export const SESSION_FOOTNOTE =
  'Each booking is one live session (30 to 60 minutes), depending on what you need covered.';

export const urgentService: ConnectService = {
  id: 'urgent',
  title: 'Urgent Connect',
  benefit: 'Stuck right now?',
  hook: 'Priority 1:1 session when you need answers fast — interview tomorrow, blocker today.',
  icon: '⚡',
  subject: 'Connect — Urgent Connect',
  accent: '#dc2626',
  price: '₹599',
  pricePeriod: '· 1 session',
  sessionPricePaise: 59900,
  mailBody:
    'Hi,\n\nI need an urgent connect session.\n\nMy blocker:\nCurrent level:\nHow soon I need help:\n\nThanks!',
};

export const connectServices: ConnectService[] = [
  {
    id: 'system-design',
    title: 'System Design',
    benefit: 'Think like a senior engineer',
    hook: 'Trade-offs, scale narratives, and interview-ready design stories.',
    icon: '🏗️',
    subject: 'Connect — System Design',
    accent: '#0f766e',
    price: '₹799',
    pricePeriod: '· 1 session',
    sessionPricePaise: 79900,
    mailBody:
      'Hi,\n\nI need help with: System Design\n\nMy goal:\nCurrent level:\nTimeline:\n\nThanks!',
  },
  {
    id: 'dsa-classes',
    title: 'DSA Classes',
    benefit: 'Learn patterns live',
    hook: 'Topic-focused sessions — when to use it, how to code it, and what interviewers actually test.',
    icon: '📚',
    subject: 'Connect — DSA Classes',
    accent: '#6d28d9',
    price: '₹499',
    pricePeriod: '· per session',
    comingSoon: true,
    mailBody:
      'Hi,\n\nI am interested in DSA Classes when they launch.\n\nMy level:\nTopics I care about:\n\nThanks!',
  },
  {
    id: 'roadmap',
    title: 'Road Map for High CTC',
    benefit: 'Stop guessing what’s next',
    hook: 'Phased plan: what to solve, when, and in what order for top offers.',
    icon: '🗺️',
    subject: 'Connect — Road Map for High CTC',
    accent: '#0369a1',
    price: '₹599',
    pricePeriod: '· 1 session',
    sessionPricePaise: 59900,
    mailBody:
      'Hi,\n\nI need help with: Road Map for High CTC\n\nMy goal:\nCurrent level:\nTimeline:\n\nThanks!',
  },
  {
    id: 'cv-review',
    title: 'CV Review',
    benefit: 'Get past the resume screen',
    hook: 'Impact bullets, ATS layout, and the story recruiters actually read.',
    icon: '📄',
    subject: 'Connect — CV Review',
    accent: '#01696f',
    price: '₹399',
    pricePeriod: '· 1 session',
    sessionPricePaise: 39900,
    mailBody:
      'Hi,\n\nI need help with: CV Review\n\nMy goal:\nCurrent level:\nTimeline:\n\nThanks!',
  },
  {
    id: 'mentorship',
    title: '1:1 Mentorship',
    benefit: 'Ongoing coach in your corner',
    hook: 'Regular check-ins, accountability, and direction across your full prep journey.',
    icon: '🤝',
    subject: 'Connect — 1:1 Mentorship',
    accent: '#b45309',
    price: '₹799',
    pricePeriod: '· 1 session',
    sessionPricePaise: 79900,
    mailBody:
      'Hi,\n\nI need help with: 1:1 Mentorship\n\nMy goal:\nCurrent level:\nTimeline:\n\nThanks!',
  },
  {
    id: 'motivation',
    title: 'Motivation',
    benefit: 'Stay in the game',
    hook: 'Burnout, consistency, and mindset for a 6–12 month grind.',
    icon: '🔥',
    subject: 'Connect — Motivation',
    accent: '#c2410c',
    price: '₹10',
    pricePeriod: '· 1 session',
    sessionPricePaise: 1000,
    mailBody:
      'Hi,\n\nI need help with: Motivation\n\nMy goal:\nCurrent level:\nTimeline:\n\nThanks!',
  },
];

export const connectOfferings = [...connectServices, urgentService];

export const introBody =
  'Hi,\n\nI am interested in mentoring. My goal:\n\nCurrent level (student / 0–2 YOE / 2+ YOE):\nTarget companies / CTC:\nTimeline:\n\nService I need:\n\nThanks!';

export function connectSessionPricePaise(svc: ConnectService): number | undefined {
  if (svc.sessionPricePaise != null) return svc.sessionPricePaise;
  const m = svc.price.replace(/,/g, '').match(/₹?\s*(\d+(?:\.\d+)?)/);
  if (!m) return undefined;
  return Math.round(parseFloat(m[1]) * 100);
}

export function isConnectSlotBookable(svc: ConnectService): boolean {
  if (svc.comingSoon) return false;
  return connectSessionPricePaise(svc) != null;
}

export function isConnectComingSoon(svc: ConnectService): boolean {
  return svc.comingSoon === true;
}

export function mailtoLink(subject: string, body?: string) {
  const params = new URLSearchParams();
  params.set('subject', subject);
  if (body) params.set('body', body);
  return `mailto:${SUPPORT_EMAIL}?${params.toString()}`;
}
