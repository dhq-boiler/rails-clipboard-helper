# frozen_string_literal: true

require_relative "lib/rails/clipboard/helper/version"

Gem::Specification.new do |spec|
  spec.name = "rails-clipboard-helper"
  spec.version = Rails::Clipboard::Helper::VERSION
  spec.authors = ["dhq_boiler"]
  spec.email = ["dhq_boiler@live.jp"]

  spec.summary = "Rails helper for displaying text with a copy-to-clipboard button"
  spec.description = "A Rails view helper gem that displays text content alongside a copy button, allowing users to easily copy the content to their clipboard."
  spec.homepage = "https://github.com/dhq_boiler/rails-clipboard-helper"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/dhq_boiler/rails-clipboard-helper/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/dhq_boiler/rails-clipboard-helper/issues"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .github/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "railties", ">= 6.0", "< 9.0"
  spec.add_dependency "actionview", ">= 6.0", "< 9.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
