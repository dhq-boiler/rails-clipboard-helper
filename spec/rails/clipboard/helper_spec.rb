# frozen_string_literal: true

RSpec.describe Rails::Clipboard::Helper do
  it "has a version number" do
    expect(Rails::Clipboard::Helper::VERSION).not_to be nil
  end
end

RSpec.describe Rails::Clipboard::Helper::ViewHelpers do
  include Rails::Clipboard::Helper::ViewHelpers

  # Mock ActionView helper method
  def javascript_tag(&block)
    "<script>#{block.call}</script>"
  end

  describe "#clipboard_copy" do
    it "generates HTML with button and content" do
      result = clipboard_copy("test content")

      expect(result).to include("clipboard-container")
      expect(result).to include("clipboard-button")
      expect(result).to include("test content")
      expect(result).to include("<svg") # Check for SVG icon
      expect(result).to include("bi-copy") # Check for copy icon class
    end

    it "accepts custom button text" do
      result = clipboard_copy("test", button_text: "Copy Me")

      expect(result).to include("Copy Me")
    end

    it "accepts custom copied text" do
      result = clipboard_copy("test", button_text: "Copy", copied_text: "Done!")

      expect(result).to include("data-copied-html")
      expect(result).to include("Done!")
    end

    it "accepts custom CSS classes" do
      result = clipboard_copy("test",
        container_class: "custom-container",
        button_class: "custom-button",
        content_class: "custom-content"
      )

      expect(result).to include("custom-container")
      expect(result).to include("custom-button")
      expect(result).to include("custom-content")
    end

    it "hides content when show_content is false" do
      result = clipboard_copy("secret", show_content: false)

      expect(result).to include('type="hidden"')
      expect(result).to include('value="secret"')
      expect(result).not_to include('<span')
    end

    it "escapes HTML in content" do
      result = clipboard_copy("<script>alert('xss')</script>")

      expect(result).to include("&lt;script&gt;")
      expect(result).not_to include("<script>alert")
    end

    it "generates unique IDs for multiple instances" do
      result1 = clipboard_copy("content1")
      result2 = clipboard_copy("content2")

      # Verify IDs are different
      expect(result1).not_to eq(result2)
    end

    it "shows only icon by default (no text)" do
      result = clipboard_copy("test")

      expect(result).to include("<svg")
      expect(result).to include("bi-copy")
      expect(result).to include("data-original-html")
    end

    it "shows icon with custom text when button_text is provided" do
      result = clipboard_copy("test", button_text: "Copy Me")

      expect(result).to include("<svg")
      expect(result).to include("Copy Me")
    end

    it "shows text only when show_icon is false" do
      result = clipboard_copy("test", button_text: "Copy", show_icon: false)

      expect(result).not_to include("<svg")
      expect(result).to include("Copy")
    end

    it "positions icon on right when icon_position is right" do
      result = clipboard_copy("test", button_text: "Copy", icon_position: "right")

      # Text should appear before SVG
      text_pos = result.index("Copy")
      svg_pos = result.index("<svg")
      expect(text_pos).to be < svg_pos
    end
  end

  describe "#clipboard_javascript_tag" do
    it "generates JavaScript tag" do
      result = clipboard_javascript_tag

      expect(result).to include("<script>")
      expect(result).to include("navigator.clipboard.writeText")
      expect(result).to include("addEventListener")
    end
  end
end
