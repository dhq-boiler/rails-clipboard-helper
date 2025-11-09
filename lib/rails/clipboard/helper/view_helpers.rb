# frozen_string_literal: true

require "securerandom"
require "erb"
require "active_support/core_ext/string/output_safety"

module Rails
  module Clipboard
    module Helper
      module ViewHelpers
        # Helper method to display text content with a copy button
        #
        # @param content [String] Content to copy
        # @param options [Hash] Options
        # @option options [String] :button_text Button text (default: nil - shows icon only)
        # @option options [String] :copied_text Text after copying (default: "Copied!")
        # @option options [String] :container_class CSS class for container
        # @option options [String] :content_class CSS class for content
        # @option options [String] :button_class CSS class for button
        # @option options [Boolean] :show_content Whether to display content (default: true)
        # @option options [Boolean] :show_icon Whether to show SVG icon (default: true)
        # @option options [String] :icon_position Icon position relative to text: 'left' or 'right' (default: 'left')
        #
        # @return [String] HTML string
        def clipboard_copy(content, options = {})
          button_text = options.fetch(:button_text, nil)
          copied_text = options.fetch(:copied_text, "Copied!")
          container_class = options.fetch(:container_class, "clipboard-container")
          content_class = options.fetch(:content_class, "clipboard-content")
          button_class = options.fetch(:button_class, "clipboard-button")
          show_content = options.fetch(:show_content, true)
          show_icon = options.fetch(:show_icon, true)
          icon_position = options.fetch(:icon_position, "left")

          unique_id = "clipboard-#{SecureRandom.hex(8)}"

          # SVG copy icon
          copy_icon = <<~SVG.strip
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-copy" viewBox="0 0 16 16" style="vertical-align: middle;">
              <path fill-rule="evenodd" d="M4 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 5a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1v-1h1v1a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h1v1z"/>
            </svg>
          SVG

          # Check icon for copied state
          check_icon = <<~SVG.strip
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16" style="vertical-align: middle;">
              <path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z"/>
            </svg>
          SVG

          # Build button content
          if show_icon && button_text
            # Icon + text
            if icon_position == "right"
              button_content = "#{ERB::Util.html_escape(button_text)} #{copy_icon}"
              copied_content = "#{ERB::Util.html_escape(copied_text)} #{check_icon}"
            else
              button_content = "#{copy_icon} #{ERB::Util.html_escape(button_text)}"
              copied_content = "#{check_icon} #{ERB::Util.html_escape(copied_text)}"
            end
          elsif show_icon
            # Icon only
            button_content = copy_icon
            copied_content = check_icon
          else
            # Text only
            button_content = ERB::Util.html_escape(button_text || "Copy")
            copied_content = ERB::Util.html_escape(copied_text)
          end

          # Inline JavaScript for clipboard functionality
          onclick_js = <<~JS.strip.gsub("\n", ' ')
            (function(btn) {
              const target = document.getElementById('#{unique_id}');
              const text = target.tagName === 'INPUT' || target.tagName === 'TEXTAREA' ? target.value : target.textContent;
              navigator.clipboard.writeText(text).then(() => {
                const original = btn.innerHTML;
                btn.innerHTML = '#{copied_content.gsub("'", "\\\\'")}';
                btn.style.color = '#28a745';
                setTimeout(() => {
                  btn.innerHTML = original;
                  btn.style.color = '#0066cc';
                }, 2000);
              }).catch(err => {
                console.error('Failed to copy:', err);
                alert('Failed to copy to clipboard');
              });
            })(this);
          JS

          html = <<~HTML
            <div class="#{container_class}" style="display: flex; align-items: center; gap: 10px;">
              #{show_content ? %Q(<span class="#{content_class}" id="#{unique_id}">#{ERB::Util.html_escape(content)}</span>) : %Q(<input type="hidden" id="#{unique_id}" value="#{ERB::Util.html_escape(content)}">)}
              <button 
                type="button" 
                class="#{button_class}" 
                style="padding: 0; cursor: pointer; border: none; background: none; color: #0066cc; text-decoration: none; display: inline-flex; align-items: center; gap: 4px; font: inherit;"
                onmouseover="this.style.textDecoration='underline';"
                onmouseout="this.style.textDecoration='none';"
                onclick="#{onclick_js}"
              >
                #{button_content}
              </button>
            </div>
          HTML

          html.html_safe
        end
      end
    end
  end
end

