require "commonmarker"
require "rouge"

class MarkdownRenderer
  FORMATTER = Rouge::Formatters::HTML.new(css_class: "highlight")

  class << self
    def render(markdown)
      html = Commonmarker.to_html(
        markdown.to_s,
        options: {
          parse: { smart: true },
          render: { unsafe: true, github_pre_lang: true }
        }
      )

      highlight_code_blocks(html)
    end

    private

    def highlight_code_blocks(html)
      fragment = Nokogiri::HTML.fragment(html)

      fragment.css("pre code").each do |code_node|
        language = code_language(code_node)
        lexer = Rouge::Lexer.find(language) || Rouge::Lexers::PlainText
        highlighted = FORMATTER.format(lexer.lex(code_node.text))

        pre_node = code_node.parent
        pre_node.replace(Nokogiri::HTML.fragment(highlighted))
      end

      fragment.to_html
    end

    def code_language(code_node)
      code_node["class"].to_s[/language-(\S+)/, 1] || "text"
    end
  end
end
