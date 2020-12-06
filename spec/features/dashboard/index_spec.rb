require 'rails_helper'

describe 'as an authenticated user' do
  before (:each) do
    @user_list = create_list(:user, 5)
    @first_user = @user_list.first
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@first_user)
  end
  describe 'when I visit /dashboard' do
    it 'I see a welcome message, a button to discover movies, a friends section, and a viewing parties section' do
      visit '/dashboard'

      expect(page).to have_content("Welcome #{@first_user.name}!")
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

    it 'I can add a friend if that user is a registered user of the application' do
      visit '/dashboard'

      within('.friends') do
        fill_in(:email, :with => "#{@user_list.second.email}")
        click_button("Add Friend")
      end

      expect(current_path).to eq("/dashboard")

      within('.friends') do
        expect(page).to have_content("#{@user_list.second.name}")
      end
    end

    it 'I see flash message when a user is not a registered member of the application' do
      visit '/dashboard'

      fake_user = "example@example.com"

      within('.friends') do
        fill_in(:email, :with => "#{fake_user}")
        click_button("Add Friend")
      end

      expect(current_path).to eq("/dashboard")

      expect(page).to have_content("Friend could not be found")
    end

    it 'I cannot add myself as a friend' do
      visit '/dashboard'

      within('.friends') do
        fill_in(:email, :with => "#{@first_user.email}")
        click_button("Add Friend")
      end

      expect(current_path).to eq("/dashboard")

      expect(page).to have_content("You can't be your own friend")
    end

    it 'I cannot add a friend who I am already friends with' do
      visit '/dashboard'

      Friendship.create!(user_id: @first_user.id, friend_id: @user_list.second.id)

      within('.friends') do
        fill_in(:email, :with => "#{@user_list.second.email}")
        click_button("Add Friend")
      end

      expect(current_path).to eq("/dashboard")

      expect(page).to have_content("Already friends with that user")
    end

    it 'I can see all friends including inverse friendships' do
      @first_user.friendships.create!(friend_id: @user_list.second.id)
      @first_user.friendships.create!(friend_id: @user_list.third.id)

      @user_list.fourth.friendships.create!(friend_id: @first_user.id)

      visit '/dashboard'

      within(".friends") do
        expect(page).to have_content("#{@user_list.second.name}")
        expect(page).to have_content("#{@user_list.third.name}")
        expect(page).to have_content("#{@user_list.fourth.name}")
      end
    end
  end
end
