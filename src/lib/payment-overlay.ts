/** User-facing payment status overlay — no gateway or server jargon. */

let overlayRoot: HTMLElement | null = null;

function getOverlayRoot(): HTMLElement {
  if (overlayRoot?.isConnected) return overlayRoot;
  overlayRoot = document.createElement('div');
  overlayRoot.className = 'payment-overlay';
  overlayRoot.setAttribute('role', 'status');
  overlayRoot.setAttribute('aria-live', 'polite');
  overlayRoot.hidden = true;
  document.body.appendChild(overlayRoot);
  return overlayRoot;
}

function friendlyStatus(message: string): string {
  const m = message.toLowerCase();
  if (m.includes('welcome') || m.includes('reload')) return 'Welcome to Pro!';
  if (m.includes('almost')) return 'Almost there…';
  if (m.includes('finish') || m.includes('captur') || m.includes('sync')) {
    return 'Finishing your upgrade…';
  }
  if (m.includes('session') || m.includes('sign in')) return 'Please sign in again to continue.';
  return 'Confirming your payment…';
}

function spinnerMarkup(): string {
  return `<div class="payment-overlay-spinner" aria-hidden="true"></div>`;
}

function renderLoading(title: string, subtitle: string) {
  const root = getOverlayRoot();
  root.className = 'payment-overlay payment-overlay--active';
  root.hidden = false;
  root.innerHTML = `
    <div class="payment-overlay-card">
      ${spinnerMarkup()}
      <p class="payment-overlay-title">${title}</p>
      <p class="payment-overlay-sub">${subtitle}</p>
    </div>
  `;
  document.body.style.overflow = 'hidden';
}

export type ProActivatingOverlay = {
  setMessage: (internalOrFriendly: string) => void;
  showSuccess: () => void;
  close: () => void;
};

export function showProActivatingOverlay(): ProActivatingOverlay {
  renderLoading('Activating Pro', 'This usually takes a few seconds…');
  const root = getOverlayRoot();
  const sub = () => root.querySelector<HTMLElement>('.payment-overlay-sub');

  return {
    setMessage(msg: string) {
      const el = sub();
      if (el) el.textContent = friendlyStatus(msg);
    },
    showSuccess() {
      const el = sub();
      if (el) el.textContent = 'Welcome to Pro!';
      root.classList.add('payment-overlay--success');
    },
    close() {
      closePaymentOverlay();
    },
  };
}

export function showProPendingOverlay() {
  const root = getOverlayRoot();
  root.className = 'payment-overlay payment-overlay--active payment-overlay--pending';
  root.hidden = false;
  root.innerHTML = `
    <div class="payment-overlay-card">
      <div class="payment-overlay-icon payment-overlay-icon--check" aria-hidden="true">✓</div>
      <p class="payment-overlay-title">Payment received</p>
      <p class="payment-overlay-sub">Your Pro access is syncing. Refresh the page in a moment — it should appear shortly.</p>
      <div class="payment-overlay-actions">
        <button type="button" class="payment-overlay-btn payment-overlay-btn--primary" data-payment-refresh>
          Refresh page
        </button>
        <button type="button" class="payment-overlay-btn payment-overlay-btn--ghost" data-payment-dismiss>
          Continue browsing
        </button>
      </div>
    </div>
  `;
  document.body.style.overflow = 'hidden';

  root.querySelector('[data-payment-refresh]')?.addEventListener('click', () => {
    window.location.reload();
  });
  root.querySelector('[data-payment-dismiss]')?.addEventListener('click', () => {
    closePaymentOverlay();
  });
}

export function showConnectPendingOverlay() {
  const root = getOverlayRoot();
  root.className = 'payment-overlay payment-overlay--active payment-overlay--pending';
  root.hidden = false;
  root.innerHTML = `
    <div class="payment-overlay-card">
      <div class="payment-overlay-icon payment-overlay-icon--check" aria-hidden="true">✓</div>
      <p class="payment-overlay-title">Payment received</p>
      <p class="payment-overlay-sub">Your session is being confirmed. Refresh Connect in a moment if it does not update.</p>
      <div class="payment-overlay-actions">
        <button type="button" class="payment-overlay-btn payment-overlay-btn--primary" data-payment-refresh>
          Refresh page
        </button>
        <button type="button" class="payment-overlay-btn payment-overlay-btn--ghost" data-payment-dismiss>
          OK
        </button>
      </div>
    </div>
  `;
  document.body.style.overflow = 'hidden';

  root.querySelector('[data-payment-refresh]')?.addEventListener('click', () => {
    window.location.reload();
  });
  root.querySelector('[data-payment-dismiss]')?.addEventListener('click', () => {
    closePaymentOverlay();
  });
}

export function closePaymentOverlay() {
  if (!overlayRoot) return;
  overlayRoot.hidden = true;
  overlayRoot.className = 'payment-overlay';
  overlayRoot.innerHTML = '';
  document.body.style.overflow = '';
}
