require 'rails_helper'

describe 'as an authenticated user' do
  before (:each) do
    visit '/registration'

    fill_in :name, with: 'Kevin'
    fill_in :email, with: 'kev123@example.com'
    fill_in :password, with: 'passwordsecure'
    fill_in :password_confirmation, with: 'passwordsecure'
    click_button 'Register'
  end
  describe 'when I visit /dashboard' do
    it 'I see a welcome message, a button to discover movies, a friends section, and a viewing parties section' do
      visit '/dashboard'

      expect(page).to have_content("Welcome Kevin!")
      expect(page).to have_button("Discover Movies")

      within('.friends') do
        expect(page).to have_content("Friends")
        expect(page).to have_button("Add Friend")
        expect(page).to have_field(:email, :with => "Friend's Email")
      end

      within('.viewing_parties') do
        expect(page).to have_content("Viewing Parties")
      end
    end

    it "should redirect to discover page when I click on 'Discover Movies'" do
      visit '/dashboard'

      click_button('Discover Movies')

      expect(current_path).to eq('/discover')
    end
  end
end
