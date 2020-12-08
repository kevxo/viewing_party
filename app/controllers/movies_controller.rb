class MoviesController < ApplicationController
  before_action :require_user
  def index
    search_title = params[:search_title]
    @movies = MovieFacade.movies(search_title)
  end

  def show
    movie_response = conn.get("/3/movie/#{params[:id]}?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US")
    @movie = JSON.parse(movie_response.body, symbolize_names: true)

    review_response = conn.get "/3/movie/#{params[:id]}/reviews?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1"
    reviews = JSON.parse(review_response.body, symbolize_names: true)
    @reviews = reviews[:results]

    cast_response = conn.get "/3/movie/#{params[:id]}/credits?api_key=#{ENV['MOVIE_API_KEY']}"
    credits = JSON.parse(cast_response.body, symbolize_names: true)
    @cast = credits[:cast]
  end
end
