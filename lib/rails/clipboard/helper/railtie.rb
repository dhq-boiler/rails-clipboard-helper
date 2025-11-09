# frozen_string_literal: true

module Rails
  module Clipboard
    module Helper
      class Railtie < ::Rails::Railtie
        initializer "rails_clipboard_helper.view_helpers" do
          ActiveSupport.on_load(:action_view) do
            include Rails::Clipboard::Helper::ViewHelpers
          end
        end

        initializer "rails_clipboard_helper.assets" do |app|
          if app.config.respond_to?(:assets)
            app.config.assets.precompile += %w[rails_clipboard_helper.js]
          end
        end

        # Add paths for asset pipeline
        config.before_initialize do |app|
          if app.config.respond_to?(:assets)
            app.config.assets.paths << root.join("app", "assets", "javascripts")
          end
        end

        def self.root
          @root ||= Pathname.new(File.expand_path("../../../..", __dir__))
        end
      end
    end
  end
end

