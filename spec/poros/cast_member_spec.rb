require 'rails_helper'

RSpec.describe CastMember do
  it "exists" do
    attrs = {
      name: Faker::Movies::Lebowski.actor,
      character: Faker::Movies::Lebowski.character
    }

    movie = CastMember.new(attrs)

    expect(movie).to be_a(CastMember)
    expect(movie.name).to eq(attrs[:name])
    expect(movie.character).to eq(attrs[:character])
  end
end
