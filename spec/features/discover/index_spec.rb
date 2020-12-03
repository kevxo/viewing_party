require 'rails_helper'

describe 'As a authenticated user' do
  describe 'when I visit the discover path' do
    before (:each) do
      visit '/registration'

      fill_in :name, with: 'Kevin'
      fill_in :email, with: 'kev123@example.com'
      fill_in :password, with: 'passwordsecure'
      fill_in :password_confirmation, with: 'passwordsecure'
      click_button 'Register'
    end

    it 'should see a button to Discover top 40 movies and a search for movies' do
      visit '/discover'

      expect(page).to have_content("Welcome Kevin!")
      expect(page).to have_button("Top 40 Movies")
      expect(page).to have_field(:search_title, :with => 'Search by Movie Title')
      expect(page).to have_button('Find Movies')
    end
  end
end