class StartHere
  FeaturedPost = Struct.new(:post, :why, keyword_init: true)

  DEFAULT_STARTER_LIMIT = 3

  def self.config
    @config ||= YAML.load_file(Rails.root.join("config/start_here.yml"))
  end

  def self.tagline
    config.fetch("tagline", "Pick a topic below, or read a note to get the vibe.").to_s.strip
  end

  def self.starter_posts(limit: DEFAULT_STARTER_LIMIT)
    posts = []
    seen_ids = []

    curated_featured_posts.each do |entry|
      break if posts.size >= limit

      posts << entry
      seen_ids << entry.post.id
    end

    if posts.size < limit
      Post.published.newest_first.where.not(id: seen_ids).limit(limit - posts.size).each do |post|
        posts << FeaturedPost.new(post: post, why: nil)
      end
    end

    posts
  end

  def self.hook_for(entry)
    entry.why.presence || entry.post.plain_body.squish.truncate(140)
  end

  def self.curated_featured_posts
    Array(config.fetch("featured_posts", [])).filter_map do |entry|
      post = Post.published.find_by(title: entry["title"])
      next unless post

      FeaturedPost.new(post: post, why: entry["why"].to_s.strip.presence)
    end
  end
end
