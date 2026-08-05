class Admin::DashboardController < Admin::BaseController
  def index
    @total_views = Post.sum(:view_count)
    @posts_count = Post.count
    @topics_count = Post.where.not(topic: [ nil, "" ]).distinct.count(:topic)
    @views_by_topic = Post.group(:topic).sum(:view_count)
      .transform_keys { |topic| topic.presence || "Untagged" }
      .sort_by { |_, views| -views.to_i }
    @top_posts = Post.published.by_views.limit(10)
    @draft_posts = Post.draft.newest_first
    @scheduled_posts = Post.scheduled.order(:published_at)
  end
end
