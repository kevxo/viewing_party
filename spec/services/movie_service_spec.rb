require 'rails_helper'

describe MovieService do
  context "class methods" do
    context ".top_40" do
      it "returns the top 40 movies", :vcr do
        movie_service = MovieService.top_40

        expect(movie_service).to be_a(Array)
        expect(movie_service.first).to be_a(Hash)
        expect(movie_service.count).to eq(40)

        first_result = movie_service[0]
        expect(first_result).to have_key(:vote_average)
        expect(first_result[:vote_average]).to be_a(Float)
        expect(first_result).to have_key(:title)
        expect(first_result[:title]).to be_a(String)
        expect(first_result).to have_key(:overview)
        expect(first_result[:overview]).to be_a(String)
      end

      it "returns the movies by title", :vcr do
        movie_service = MovieService.movies_by_title("Interstellar")

        expect(movie_service).to be_a(Array)
        expect(movie_service.first).to be_a(Hash)

        first_result = movie_service[0]
        expect(first_result).to have_key(:vote_average)
        expect(first_result[:vote_average]).to be_a(Float)
        expect(first_result).to have_key(:title)
        expect(first_result[:title]).to be_a(String)
        expect(first_result).to have_key(:overview)
        expect(first_result[:overview]).to be_a(String)
      end
    end
  end
end
