# frozen_string_literal: true

module Rails
  module Clipboard
    module Helper
      class Engine < ::Rails::Engine
        isolate_namespace Rails::Clipboard::Helper

        initializer "rails_clipboard_helper.assets" do |app|
          app.config.assets.precompile += %w[rails_clipboard_helper.js] if app.config.respond_to?(:assets)
        end

        initializer "rails_clipboard_helper.view_helpers" do
          ActiveSupport.on_load(:action_view) do
            include Rails::Clipboard::Helper::ViewHelpers
          end
        end
      end
    end
  end
end

