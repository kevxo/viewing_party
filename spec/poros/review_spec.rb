require 'rails_helper'

RSpec.describe Review do
  it "exists" do
    attrs = {
      author: Faker::Name.name,
      content: Faker::Quote.yoda
    }

    movie = Review.new(attrs)

    expect(movie).to be_a(Review)
    expect(movie.author).to eq(attrs[:author])
    expect(movie.content).to eq(attrs[:content])
  end
end
