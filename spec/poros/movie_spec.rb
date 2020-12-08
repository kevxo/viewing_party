require 'rails_helper'

RSpec.describe Movie do
  it "exists" do
    attrs = {
      title: "Interstellar",
      vote_average: "8.8",
      id: 44,
      runtime: 233,
      overview: "It's good."
    }

    movie = Movie.new(attrs)

    expect(movie).to be_a(Movie)
    expect(movie.title).to eq("Interstellar")
    expect(movie.vote_average).to eq("8.8")
    expect(movie.id).to eq(44)
    expect(movie.runtime).to eq(233)
    expect(movie.overview).to eq("It's good.")
  end
end
