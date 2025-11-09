// Rails Clipboard Helper - Automatic clipboard functionality
(function() {
  'use strict';

  function initClipboardButtons() {
    document.querySelectorAll('[data-clipboard-target]').forEach(function(button) {
      // Skip if already initialized
      if (button.dataset.clipboardInitialized) return;
      button.dataset.clipboardInitialized = 'true';

      button.addEventListener('click', function() {
        const targetId = this.getAttribute('data-clipboard-target');
        const targetElement = document.getElementById(targetId);

        // Support both old (text) and new (HTML) data attributes
        const originalContent = this.getAttribute('data-original-html') || this.getAttribute('data-original-text');
        const copiedContent = this.getAttribute('data-copied-html') || this.getAttribute('data-copied-text');

        let textToCopy;
        if (targetElement.tagName === 'INPUT' || targetElement.tagName === 'TEXTAREA') {
          textToCopy = targetElement.value;
        } else {
          textToCopy = targetElement.textContent;
        }

        navigator.clipboard.writeText(textToCopy).then(() => {
          // Use innerHTML for HTML content (SVG icons), textContent for plain text
          if (this.getAttribute('data-original-html')) {
            this.innerHTML = copiedContent;
          } else {
            this.textContent = copiedContent;
          }
          this.style.background = '#d4edda';

          setTimeout(() => {
            if (this.getAttribute('data-original-html')) {
              this.innerHTML = originalContent;
            } else {
              this.textContent = originalContent;
            }
            this.style.background = '#f8f9fa';
          }, 2000);
        }).catch(err => {
          console.error('Failed to copy to clipboard:', err);
          alert('Failed to copy');
        });
      });
    });
  }

  // Initialize on DOMContentLoaded
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initClipboardButtons);
  } else {
    initClipboardButtons();
  }

  // Re-initialize on Turbo events (for Turbo/Hotwire support)
  if (typeof Turbo !== 'undefined') {
    document.addEventListener('turbo:load', initClipboardButtons);
    document.addEventListener('turbo:render', initClipboardButtons);
  }

  // Re-initialize on turbolinks events (for older Turbolinks support)
  document.addEventListener('turbolinks:load', initClipboardButtons);
})();

