# frozen_string_literal: true

require_relative "helper/version"
require_relative "helper/view_helpers"

module Rails
  module Clipboard
    module Helper
      class Error < StandardError; end

      # Automatically include view helpers in ActionView
      if defined?(ActionView::Base)
        ActionView::Base.include ViewHelpers
      end
    end
  end
end
