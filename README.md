# Rails::Clipboard::Helper

A Rails view helper gem that displays a copy button alongside text content, allowing users to easily copy the content to their clipboard.

## Features

- Easy text copying to clipboard
- Customizable styles
- Uses modern Clipboard API
- Visual feedback on successful copy

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-clipboard-helper'
```

And then execute:

```bash
bundle install
```

## Usage

### JavaScript Setup

The gem uses Rails Engine to automatically make JavaScript available. You need to include it in your asset pipeline:

**For Sprockets (Asset Pipeline):**

Add to `app/assets/javascripts/application.js`:
```javascript
//= require rails_clipboard_helper
```

**For Importmap (Rails 7+):**

Add to `config/importmap.rb`:
```ruby
pin "rails_clipboard_helper"
```

Then the JavaScript will be automatically loaded.

**For esbuild/webpack:**

The JavaScript file is located at `app/assets/javascripts/rails_clipboard_helper.js` in the gem.
You may need to configure your build tool to include it.

**Manual setup (alternative):**

If you prefer not to use the asset pipeline, add to your layout:
```erb
<%= clipboard_javascript_tag %>
```

**Features:**
- Automatic initialization on page load
- Turbo/Hotwire support (turbo:load, turbo:render)
- Turbolinks support (turbolinks:load)
- Prevents duplicate event listeners

### Basic Usage

Use the `clipboard_copy` helper in your views:

```erb
<%= clipboard_copy("Text you want to copy") %>
```

By default, this displays an SVG copy icon. When clicked, it changes to a checkmark icon.

### Usage with Options

**Icon only (default):**
```erb
<%= clipboard_copy("Text to copy") %>
```

**Icon with text:**
```erb
<%= clipboard_copy("Text to copy", button_text: "Copy") %>
```

**Text only (no icon):**
```erb
<%= clipboard_copy("Text to copy", button_text: "Copy", show_icon: false) %>
```

**Icon on the right:**
```erb
<%= clipboard_copy("Text to copy", button_text: "Copy", icon_position: "right") %>
```

**More options:**

```erb
<%= clipboard_copy(
  "Text you want to copy",
  button_text: "Copy",
  copied_text: "Copied!",
  container_class: "my-clipboard-container",
  content_class: "my-content",
  button_class: "my-button"
) %>
```

### Hide Content

To display only the button and hide the content to be copied:

```erb
<%= clipboard_copy(
  "Secret token: abc123xyz",
  button_text: "Copy Token",
  show_content: false
) %>
```

### Available Options

| Option | Default Value | Description |
|--------|---------------|-------------|
| `button_text` | `nil` | Text to display on button (if nil, shows icon only) |
| `copied_text` | `"Copied!"` | Text to display after successful copy |
| `show_icon` | `true` | Whether to show SVG icon |
| `icon_position` | `"left"` | Icon position: "left" or "right" (when button_text is provided) |
| `container_class` | `"clipboard-container"` | CSS class for container element |
| `content_class` | `"clipboard-content"` | CSS class for content element |
| `button_class` | `"clipboard-button"` | CSS class for button element |
| `show_content` | `true` | Whether to display content |

### Custom Styles

You can customize the styles with your own CSS:

```css
.clipboard-container {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px;
  background: #f5f5f5;
  border-radius: 8px;
}

.clipboard-button {
  padding: 8px 16px;
  background: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background 0.3s;
}

.clipboard-button:hover {
  background: #0056b3;
}

.clipboard-content {
  font-family: monospace;
  padding: 5px 10px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 4px;
}
```

## Examples

### Display and Copy API Key (Icon Only)

```erb
<div class="api-key-section">
  <h3>Your API Key</h3>
  <%= clipboard_copy(@user.api_key) %>
</div>
```

### Copy Code Snippet (Icon with Text)

```erb
<% code_snippet = 'gem "rails-clipboard-helper"' %>
<%= clipboard_copy(
  code_snippet,
  button_text: "Copy Code",
  container_class: "code-copy-container",
  content_class: "code-snippet"
) %>
```

### Hide Content (Icon Only Button)

```erb
<%= clipboard_copy(
  "secret_token_abc123",
  show_content: false
) %>
```

## Browser Support

This gem uses the modern Clipboard API, which is supported by:

- Chrome 43+
- Firefox 41+
- Safari 13.1+
- Edge 12+

Requires HTTPS or localhost for operation.

## Development

After checking out the repo:

```bash
bin/setup  # Install dependencies
rake spec  # Run tests
bin/console  # Start interactive prompt
```

To install this gem onto your local machine:

```bash
bundle exec rake install
```

To release a new version:

1. Update the version number in `version.rb`
2. Run `bundle exec rake release`

## Contributing

Bug reports and pull requests are welcome at https://github.com/dhq_boiler/rails-clipboard-helper

## License

This gem is available as open source software.

## Author

dhq_boiler (dhq_boiler@live.jp)
