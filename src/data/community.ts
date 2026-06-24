/** Discord community — override with PUBLIC_DISCORD_INVITE_URL in .env if the invite changes. */
export const DISCORD_INVITE_URL = (
  import.meta.env.PUBLIC_DISCORD_INVITE_URL ?? 'https://discord.gg/gSccpmtm'
).trim();

export const DISCORD_JOIN_HEADLINE = 'Join the AlgoFrog Discord';
export const DISCORD_JOIN_COPY =
  'Ask questions, share progress, and prep with others on the community server.';

export const DISCORD_TOPBAR_HINT = 'Ask questions · share progress · prep together';

export const DISCORD_INTRO_COPY =
  'Send a DM on Discord with your target CTC, current level, and biggest blocker. I’ll point you to the right service — no pressure, no spam.';
export const DISCORD_INTRO_CTA = 'Message on Discord';
export const DISCORD_INTRO_SUB = 'Join the server first, then DM me there.';

export function hasDiscordInvite(): boolean {
  return /^https:\/\/(discord\.gg\/|discord\.com\/invite\/)/i.test(DISCORD_INVITE_URL);
}
