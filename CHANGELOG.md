# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2025-11-09

### Changed
- Changed button default style to link-like appearance (no border, no background, blue text color)
- Added hover effect with underline on buttons
- Changed success feedback from background color to text color change (green)
- **BREAKING**: Replaced external JavaScript with inline JavaScript - no asset pipeline setup needed
- Removed `clipboard_javascript_tag` helper method (no longer needed)
- Removed Engine and Railtie (simplified gem structure)
- Removed dependency on `railties` (only requires `actionview` now)
- Updated documentation to remove JavaScript setup instructions

## [0.1.1] - 2025-11-09

### Fixed
- Fixed Railtie loading issue that prevented helper methods from being available in views
- Added proper conditional loading for both Engine and Railtie
- Improved helper method initialization in Rails applications

### Added
- Added troubleshooting section to README
- Documented helper method not found error resolution

## [0.1.0] - 2025-11-09

### Added
- Initial release
- Implemented `clipboard_copy` helper method with SVG icon support
- SVG copy icon (default) that changes to checkmark on successful copy
- Icon-only mode (default), icon+text mode, and text-only mode
- Configurable icon position (left or right of text)
- Implemented `clipboard_javascript_tag` helper method (for backward compatibility)
- Clipboard copy functionality with automatic JavaScript loading
- Rails Engine for automatic asset integration
- Support for Sprockets, Importmap, esbuild, and webpack
- Turbo/Hotwire and Turbolinks support
- Customizable button text and CSS classes
- Content show/hide option
- Visual feedback on successful copy
- HTML character escaping
- Support for Rails 6.0 and above
- Comprehensive RSpec tests
- Documentation

[0.1.2]: https://github.com/dhq_boiler/rails-clipboard-helper/releases/tag/v0.1.2
[0.1.1]: https://github.com/dhq_boiler/rails-clipboard-helper/releases/tag/v0.1.1
[0.1.0]: https://github.com/dhq_boiler/rails-clipboard-helper/releases/tag/v0.1.0

