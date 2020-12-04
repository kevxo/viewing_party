class MoviesController < ApplicationController
  before_action :require_user
  def index
    conn = Faraday.new('https://api.themoviedb.org')

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
end
