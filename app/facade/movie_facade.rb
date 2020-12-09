class MovieFacade
  def self.movies(search_title = nil)
    if search_title
      search_json = MovieService.movies_by_title(search_title, 40)
      search_json.map do |movie_data|
        Movie.new(movie_data)
      end
    else
      top_40_json = MovieService.most_popular(40)
      top_40_json.map do |movie_data|
        Movie.new(movie_data)
      end
    end
  end

  def self.movie(movie_id)
    movie_data = MovieService.movie_by_id(movie_id)
    Movie.new(movie_data)
  end

  def self.reviews(movie_id)
    reviews = MovieService.get_reviews(movie_id)
    reviews.map do |review_data|
      Review.new(review_data)
    end
  end

  def self.cast(movie_id)
    cast = MovieService.get_cast(movie_id)
    cast[0..9].map do |cast_data|
      CastMember.new(cast_data)
    end
  end
end
