require 'rails_helper'

describe MovieFacade do
  context "class methods" do
    context ".movies" do
      it "returns the top 40 movies and search results", :vcr do
        top_40_facade = MovieFacade.movies()
        expect(top_40_facade).to be_a(Array)
        expect(top_40_facade.first).to be_a(Movie)
        expect(top_40_facade.count).to eq(40)

        search_facade = MovieFacade.movies("Interstellar")
        expect(search_facade).to be_a(Array)
        expect(search_facade.first).to be_a(Movie)
        expect(search_facade).to all(be_a(Movie))
      end
    end

    context ".image" do
      it "returns the top 40 movies and search results", :vcr do
        image_data = MovieFacade.image(278)
        expect(image_data).to be_a(Image)
        expect(image_data.path).to be_a(String)
      end
    end

    context ".movie" do
      it "returns the top 40 movies and search results", :vcr do
        movie_data = MovieFacade.movie(278)
        expect(movie_data).to be_a(Movie)
        expect(movie_data.title).to be_a(String)
        expect(movie_data.runtime).to be_a(Integer)
        expect(movie_data.vote_average).to be_a(Float)
      end
    end

    context ".reviews" do
      it "returns the top 40 movies and search results", :vcr do
        review_data = MovieFacade.reviews(278)
        expect(review_data).to be_a(Array)
        expect(review_data.first.author).to be_a(String)
        expect(review_data.first.content).to be_a(String)
      end
    end

    context ".cast" do
      it "returns the top 40 movies and search results", :vcr do
        cast_data = MovieFacade.cast(278)
        expect(cast_data).to be_a(Array)
        expect(cast_data.first.character).to be_a(String)
        expect(cast_data.first.name).to be_a(String)
      end
    end
  end
end
