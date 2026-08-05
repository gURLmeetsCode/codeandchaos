require "test_helper"

class MarkdownRendererTest < ActiveSupport::TestCase
  test "renders paragraphs" do
    html = MarkdownRenderer.render("Hello **world**.")
    assert_includes html, "<strong>world</strong>"
  end

  test "highlights fenced code blocks" do
    markdown = <<~MD
      ```ruby
      Post.published
      ```
    MD

    html = MarkdownRenderer.render(markdown)
    assert_includes html, "highlight"
    assert_includes html, "Post"
  end
end
