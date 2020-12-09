require 'rails_helper'

describe MovieService do
  context "class methods" do
    context ".most_popular" do
      it "returns the top 40 movies", :vcr do
        movie_service = MovieService.most_popular(40)

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
    end

    context ".movies_by_title" do
      it "returns the movies by title", :vcr do
        movie_service = MovieService.movies_by_title("Interstellar", 40)

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

    context ".movie_by_id" do
      it "returns the movie by id", :vcr do
        movie_service = MovieService.movie_by_id("278")

        expect(movie_service).to be_a(Hash)
        expect(movie_service).to have_key(:title)
        expect(movie_service).to have_key(:vote_average)
        expect(movie_service).to have_key(:overview)
        expect(movie_service[:genres]).to be_a(Array)
        expect(movie_service[:title]).to eq("The Shawshank Redemption")
      end
    end

    context ".get_reviews" do
      it "returns reviews of movie", :vcr do
        movie_service = MovieService.get_reviews("278")

        expect(movie_service).to be_a(Array)
        expect(movie_service.first).to be_a(Hash)

        first_result = movie_service[0]
        expect(first_result).to have_key(:author)
        expect(first_result[:author]).to be_a(String)
        expect(first_result).to have_key(:content)
        expect(first_result[:content]).to be_a(String)
      end
    end

    context ".get_cast" do
      it "returns cast of movie", :vcr do
        movie_service = MovieService.get_cast("278")

        expect(movie_service).to be_a(Array)
        expect(movie_service.first).to be_a(Hash)

        first_result = movie_service[0]
        expect(first_result).to have_key(:name)
        expect(first_result[:name]).to be_a(String)
        expect(first_result).to have_key(:character)
        expect(first_result[:character]).to be_a(String)
      end
    end
  end
end
