module PostsHelper
  TOPIC_COLORS = {
    "Ruby" => "#cc342d",
    "Rails" => "#d30001",
    "Career" => "#3d7d88",
    "Frontend" => "#f59e0b",
    "DevOps" => "#8b5cf6"
  }.freeze

  def topic_color(topic)
    TOPIC_COLORS.fetch(topic, "#69707d")
  end

  def reading_time_label(post)
    "#{post.reading_time_minutes} min read"
  end

  def render_markdown(text)
    MarkdownRenderer.render(text).html_safe
  end
end
