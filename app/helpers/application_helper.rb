module ApplicationHelper
  def admin_area?
    return true if controller_path.start_with?("admin/")

    user_signed_in? &&
      current_user.admin? &&
      devise_controller? &&
      controller_name == "registrations" &&
      action_name.in?(%w[edit update])
  end

  def page_title(title = nil)
    parts = [ "gURLmeetsCode" ]
    parts.unshift(title) if title.present?
    parts.join(" · ")
  end

  def brand_mark(suffix: nil)
    parts = [
      "g".html_safe,
      tag.span("URL", class: "brand__accent"),
      "meetsCode"
    ]
    parts << " #{suffix}" if suffix.present?
    safe_join(parts)
  end

  def delete_post_confirm(post)
    "Are you sure you want to delete \"#{post.title}\"? This action cannot be undone."
  end

  def publish_post_confirm(post)
    if post.scheduled?
      "Publish \"#{post.title}\" now? It will go live immediately instead of #{l(post.published_at, format: :long)}."
    else
      "Publish \"#{post.title}\"? It will go live immediately."
    end
  end
end
