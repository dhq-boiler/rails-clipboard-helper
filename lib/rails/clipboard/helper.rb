# frozen_string_literal: true

require_relative "helper/version"
require_relative "helper/view_helpers"
require_relative "helper/engine" if defined?(Rails::Engine)

module Rails
  module Clipboard
    module Helper
      class Error < StandardError; end
    end
  end
end
