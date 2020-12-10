require 'rails_helper'

RSpec.describe Movie do
  before :each do
    @attrs = {
      title: Faker::Movie.title,
      vote_average: Faker::Number.decimal(l_digits: 1, r_digits: 1).to_s,
      id: Faker::Number.number(digits: 2),
      runtime: Faker::Number.number(digits: 3),
      overview: Faker::Movie.quote,
      genres: [{:id=>18, :name=>"Drama"}, {:id=>80, :name=>"Crime"}]
      }

    @movie = Movie.new(@attrs)
  end
  it "exists" do
    expect(@movie).to be_a(Movie)
    expect(@movie.title).to eq(@attrs[:title])
    expect(@movie.vote_average).to eq(@attrs[:vote_average])
    expect(@movie.id).to eq(@attrs[:id])
    expect(@movie.runtime).to eq(@attrs[:runtime])
    expect(@movie.overview).to eq(@attrs[:overview])
  end

  describe '#instance_methods' do
    it 'genres' do
      expected = "Drama, Crime"

      expect(@movie.genres).to eq(expected)
    end
  end
end
