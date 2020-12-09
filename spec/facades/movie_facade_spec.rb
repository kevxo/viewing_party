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
  end
end
