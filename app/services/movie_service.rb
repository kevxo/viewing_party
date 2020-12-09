class MovieService
  def self.most_popular(limit)
    pages = []
    page = 1
    until pages.count == limit
      response = get_top_pages(page)
      pages << parse_results(response)[:results]
      pages.flatten!
      page += 1
    end
    pages
  end

  def self.movies_by_title(title, limit)
    pages = []
    page = 1
    until pages.count == limit
      response = get_search_pages(page, title)
      pages << parse_results(response)[:results]
      pages.flatten!
      break if pages.count < 20

      page += 1
    end
    pages
  end

  def self.movie_by_id(movie_id)
    response = conn.get("/3/movie/#{movie_id}?&language=en-US")
    parse_results(response)
  end

  def self.get_reviews(movie_id)
    review_response = conn.get "/3/movie/#{movie_id}/reviews?&language=en-US&page=1"
    parse_results(review_response)[:results]
  end

  def self.get_cast(movie_id)
    cast_response = conn.get "/3/movie/#{movie_id}/credits"
    parse_results(cast_response)[:cast]
  end

  def self.get_search_pages(page, title)
    conn.get("/3/search/movie?&language=en-US&page=#{page}&include_adult=false&query=#{title}")
  end

  def self.get_top_pages(page)
    conn.get("/3/movie/top_rated?page=#{page}")
  end

  def self.parse_results(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new('https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['MOVIE_API_KEY']
    end
  end
end
