require 'rails_helper'

RSpec.describe Image do
  it "exists" do
    attrs = {
      path: "https://image.tmdb.org/t/p/w400"
    }

    image = Image.new(attrs)

    expect(image).to be_a(Image)
    expect(image.path).to eq(attrs[:path])
  end
end
