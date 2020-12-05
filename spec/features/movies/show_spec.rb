require 'rails_helper'

describe "As an authenticated user, when I visit the movie's detail page" do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'has a button to create a viewing party', :vcr do
    visit '/discover'
    click_button("Top 40 Movies")
    expect(current_path).to eq('/movies')
    click_link("The Shawshank Redemption")

    expect(current_path).to eq("/movies/278")
    expect(page).to have_button('Create Viewing Party for Movie')
  end

  it "has movie details", :vcr do
    visit '/discover'
    click_button("Top 40 Movies")
    expect(current_path).to eq('/movies')
    click_link("The Shawshank Redemption")

    within ".movie-details" do
      title = find(".title").text
      expect(title).to_not be_empty

      vote = find(".vote").text
      expect(vote).to_not be_empty

      runtime = find(".runtime").text
      expect(runtime).to_not be_empty

      genre = find(".genre").text
      expect(genre).to_not be_empty

      summary = find(".summary").text
      expect(summary).to_not be_empty

      cast = find(".cast").text
      expect(cast).to_not be_empty

      reviews = find(".reviews").text
      expect(reviews).to_not be_empty
      expect(page).to have_content("6 Reviews")
    end
  end
end
