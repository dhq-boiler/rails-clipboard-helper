# Rails::Clipboard::Helper

A Rails view helper gem that displays a copy button alongside text content, allowing users to easily copy the content to their clipboard.

## Features

- Easy text copying to clipboard
- **No JavaScript setup required** - works out of the box with inline JavaScript
- Link-style button design (no borders, no background)
- Customizable styles
- Uses modern Clipboard API
- Visual feedback on successful copy (icon and color change)

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


### Basic Usage

Use the `clipboard_copy` helper in your views:

```erb
<%= clipboard_copy("Text you want to copy") %>
```

By default, this displays an SVG copy icon styled as a link (no border, no background). When clicked, it changes to a checkmark icon and the color briefly changes to green.

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

The button is styled as a link by default (no border, no background, blue color with underline on hover). You can customize the styles with your own CSS:

```css
/* Custom container style */
.clipboard-container {
  display: flex;
  align-items: center;
  gap: 10px;
}

/* Custom button style - override the link-like default */
.clipboard-button {
  color: #0066cc;
  text-decoration: none;
  cursor: pointer;
  transition: color 0.2s;
}

.clipboard-button:hover {
  color: #004499;
  text-decoration: underline;
}

/* Or create a button-like style */
.my-button {
  padding: 8px 16px;
  background: #007bff;
  color: white !important;
  border: 1px solid #007bff;
  border-radius: 4px;
}

.my-button:hover {
  background: #0056b3;
  text-decoration: none !important;
}

/* Custom content style */
.clipboard-content {
  font-family: monospace;
  padding: 5px 10px;
  background: #f8f9fa;
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

## Troubleshooting

### Helper method `clipboard_copy` is not found

If you get an error like `undefined method 'clipboard_copy'`, try the following:

1. **Restart your Rails server** after installing the gem:
   ```bash
   bundle install
   rails restart  # or ctrl+c and restart your server
   ```

2. **Verify the gem is installed:**
   ```bash
   bundle list | grep rails-clipboard-helper
   ```

3. **Check if the gem is required:**
   The helper should be automatically included in your views.
   If not, you can manually include it in `app/controllers/application_controller.rb`:
   ```ruby
   class ApplicationController < ActionController::Base
     helper Rails::Clipboard::Helper::ViewHelpers
   end
   ```

4. **Check your Rails version:**
   This gem requires ActionView 6.0 or higher.

### Copy button doesn't work

1. **HTTPS requirement:**
   The Clipboard API requires HTTPS (or localhost for development).

2. **Check browser console:**
   Open browser developer console (F12) and look for any JavaScript errors.

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
