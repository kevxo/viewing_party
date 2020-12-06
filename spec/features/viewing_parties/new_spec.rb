require 'rails_helper'

describe 'As a authenticated user' do
  describe 'When I visit the new viewing party page' do
    before :each do
      @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @user_list = create_list(:user, 2)

      @user.friendships.create!(friend_id: @user_list.first.id)
      @user.friendships.create!(friend_id: @user_list.last.id)
    end

    it 'should see Movie Title, Duration, Date, Start time,
    checkboxes to each friend, and create party button', :vcr do
      visit '/discover'
      click_button("Top 40 Movies")
      expect(current_path).to eq('/movies')

      click_link("The Shawshank Redemption")

      click_button 'Create Viewing Party for Movie'

      expect(current_path).to eq('/viewing_party/new')

      expect(page).to have_content('Viewing Party Details')
      expect(page).to have_content("Movie title: The Shawshank Redemption")
      expect(page).to have_content("Duration of Party")
      expect(page).to have_field(:duration, :with => '142')

      fill_in :day, with: '12/12/2020'

      expect(page).to have_content('Start Time')
      fill_in :time,	with: '10:15'

      expect(page).to have_content('Include')


      check("#{@user_list.first.name}")

      click_button 'Create Party'

      expect(current_path).to eq('/dashboard')

      within ".viewing_parties" do
        expect(page).to have_content('The Shawshank Redemption')
        expect(page).to have_content('12/12/2020')
        expect(page).to have_content('10:15')
        expect(page).to have_content('Hosting')
      end
    end
  end
end