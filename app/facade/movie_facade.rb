class MovieFacade
  def self.movies(search_title = nil)
    if search_title
      search_json = MovieService.movies_by_title(search_title)
      search_json.map do |movie_data|
        Movie.new(movie_data)
      end
    else
      top_40_json = MovieService.top_40
      top_40_json.map do |movie_data|
        Movie.new(movie_data)
      end
    end
  end
end
