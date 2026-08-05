class PostsController < ApplicationController
  before_action :set_post, only: %i[ show ]

  def index
    @posts = Post.published.newest_first
  end

  def show
    @post.increment!(:view_count) unless skip_view_count?
  end

  private

  def set_post
    @post = Post.published.find(params.expect(:id))
  end

  def skip_view_count?
    Rails.env.development? || current_user&.admin?
  end
end
