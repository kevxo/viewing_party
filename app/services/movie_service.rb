class MovieService

  def self.top_40
    pages = []
    page_1 = self.get_top_pages(1)
    page_2 = self.get_top_pages(2)
    pages << self.parse_results(page_1)
    pages << self.parse_results(page_2)
    pages.flatten!
  end

  def self.movies_by_title(title)
    pages = []
    page_1 = self.get_search_pages(1, title)
    pages << self.parse_results(page_1)
    if pages.count == 20
      page_2 = self.get_search_pages(2, title)
      pages << self.parse_results(page_2)
    end
    pages.flatten!
  end

  private

  def self.get_search_pages(page, title)
    self.conn.get("/3/search/movie?&language=en-US&page=#{page}&include_adult=false&query=#{title}")
  end

  def self.get_top_pages(page)
    self.conn.get("/3/movie/top_rated?page=#{page}")
  end

  def self.parse_results(response)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end

  def self.conn
    Faraday.new('https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['MOVIE_API_KEY']
    end
  end
end
