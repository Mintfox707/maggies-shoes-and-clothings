let deferredInstallPrompt;

function registerInstallButton() {
  if (document.getElementById('pwa-install')) return;
  const actions = document.querySelector('.header-actions');
  if (!actions) return;
  const button = document.createElement('button');
  button.id = 'pwa-install';
  button.className = 'pwa-install';
  button.type = 'button';
  button.textContent = 'Install';
  button.hidden = true;
  actions.prepend(button);

  button.addEventListener('click', async () => {
    if (deferredInstallPrompt) {
      deferredInstallPrompt.prompt();
      await deferredInstallPrompt.userChoice;
      deferredInstallPrompt = null;
      button.hidden = true;
    } else {
      const ios = /iphone|ipad|ipod/i.test(navigator.userAgent);
      alert(ios
        ? "To install: tap Share, then choose 'Add to Home Screen'."
        : "Open your browser menu and choose 'Install app' or 'Add to Home screen'.");
    }
  });
}

window.addEventListener('beforeinstallprompt', event => {
  event.preventDefault();
  deferredInstallPrompt = event;
  const button = document.getElementById('pwa-install');
  if (button) button.hidden = false;
});

window.addEventListener('appinstalled', () => {
  const button = document.getElementById('pwa-install');
  if (button) button.hidden = true;
});

registerInstallButton();

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('./sw.js').catch(error => console.error('PWA setup failed:', error));
  });
}
