module BooksHelper
  def currently_reading_books
    books_config.fetch("books", [])
  end

  def goodreads_profile_url
    books_config["goodreads_profile"]
  end

  def book_cover_tag(book)
    if book["cover"].present?
      image_tag book["cover"], alt: "#{book['title']} cover", class: "reading-list__cover", loading: "lazy"
    elsif book["cover_url"].present?
      image_tag book["cover_url"], alt: "#{book['title']} cover", class: "reading-list__cover", loading: "lazy"
    end
  end

  private

  def books_config
    @books_config ||= YAML.load_file(Rails.root.join("config/books.yml"))
  end
end
