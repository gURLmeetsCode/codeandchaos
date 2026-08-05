class Post < ApplicationRecord
  WORDS_PER_MINUTE = 200

  validates :title, :body, presence: true

  before_validation :normalize_topic

  scope :newest_first, -> { order(published_at: :desc, updated_at: desc) }
  scope :by_views, -> { order(view_count: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def topic_label
    topic.presence || "Untagged"
  end

  def word_count
    plain_body.split(/\s+/).count(&:present?)
  end

  def plain_body
    body.to_s
      .gsub(/```.*?```/m, " ")
      .gsub(/`[^`]+`/, " ")
      .gsub(/[#*_>\[\]()~|-]/, " ")
  end

  def reading_time_minutes
    return 1 if word_count.zero?

    (word_count / WORDS_PER_MINUTE.to_f).ceil
  end

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def publish!
    update!(published_at: Time.current)
  end

  def status_label
    return "Draft" if draft?
    return "Scheduled" if scheduled?

    "Published"
  end

  private

  def normalize_topic
    self.topic = topic.to_s.strip.presence
  end
end
