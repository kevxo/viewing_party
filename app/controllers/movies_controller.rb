class MoviesController < ApplicationController
  before_action :require_user
  def index
    if params[:search_title]
      response = conn.get("/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1&include_adult=false&query=#{params[:search_title]}")
      @movies = JSON.parse(response.body, symbolize_names: true)[:results]
      if @movies.count == 20
        response = conn.get("/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2&include_adult=false&query=#{params[:search_title]}")
        @movies << JSON.parse(response.body, symbolize_names: true)[:results]
      end
    else
      page1 = conn.get("/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=1")
      page2 = conn.get("/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&language=en-US&page=2")

      @movies = []
      @movies << JSON.parse(page1.body, symbolize_names: true)[:results]
      @movies << JSON.parse(page2.body, symbolize_names: true)[:results]
    end
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

private

def conn
  Faraday.new('https://api.themoviedb.org')
end
