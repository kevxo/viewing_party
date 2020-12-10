require 'rails_helper'

describe "as an authenticated user" do
  before :each do
    visit '/registration'

    fill_in :name, with: 'Kevin'
    fill_in :email, with: 'kev123@example.com'
    fill_in :password, with: 'passwordsecure'
    fill_in :password_confirmation, with: 'passwordsecure'
    click_button 'Register'
  end
  describe "when I visit the movies page", :vcr do
    it 'I should see the 40 results from my search,
    I should also see the "Top 40 Movies" button and the Find Movies form at the top of the page' do
      visit '/discover'

      click_button("Top 40 Movies")

      expect(current_path).to eq('/movies')

      expect(page).to have_content("Welcome Kevin!")
      expect(page).to have_button("Top 40 Movies")
      expect(page).to have_field(:search_title, placeholder: 'Search by Movie Title')
      expect(page).to have_button('Find Movies')

      expect(page).to have_css('.results', count: 40)

      within(first('.results')) do
        expect(page).to have_css('.name')
        expect(page).to have_css('.vote_average')
      end

      fill_in(:search_title, :with => "Interstellar")
      click_button("Find Movies")

      expect(current_path).to eq('/movies')

      expect(page).to have_css('.results', count: 17)

      within(first('.results')) do
        expect(page).to have_content("Interstellar")
        expect(page).to have_content("Vote Average: 8.3")
      end
    end
  end
end
