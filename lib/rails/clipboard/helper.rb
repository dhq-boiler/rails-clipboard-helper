# frozen_string_literal: true

require_relative "helper/version"
require_relative "helper/view_helpers"

if defined?(Rails::Engine)
  require_relative "helper/engine"
elsif defined?(Rails::Railtie)
  require_relative "helper/railtie"
end

module Rails
  module Clipboard
    module Helper
      class Error < StandardError; end
    end
  end
end
