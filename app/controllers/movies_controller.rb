class MoviesController < ApplicationController
  before_action :require_user
  def index
    search_title = params[:search_title]
    @movies = MovieFacade.movies(search_title)
  end

  def show
    movie_id = params[:id]
    @movie = MovieFacade.movie(movie_id)
    @reviews = MovieFacade.reviews(movie_id)
    @cast = MovieFacade.cast(movie_id)
    @image = MovieFacade.image(movie_id)
  end
end
