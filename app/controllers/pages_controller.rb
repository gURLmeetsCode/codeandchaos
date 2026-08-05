class PagesController < ApplicationController
  def about
  end

  def start
    @tagline = StartHere.tagline
    @topics = Post.topic_counts
    @starter_posts = StartHere.starter_posts
  end
end
