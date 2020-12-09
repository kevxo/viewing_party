class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :overview

  def initialize(movie_data)
    @id = movie_data[:id]
    @title = movie_data[:title]
    @vote_average = movie_data[:vote_average]
    @runtime = movie_data[:runtime]
    @genres = movie_data[:genres]
    @overview = movie_data[:overview]
  end

  def genres
    @genres.map do |genre|
      genre[:name]
    end
  end
end
