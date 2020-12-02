require 'rails_helper'

describe 'As a user' do
  describe "When I visit the registration path" do
    it 'should see registration form' do
      visit '/registration'

      fill_in :name, with: 'Kevin'
      fill_in :email, with: 'kev123@example.com'
      fill_in :password, with: 'passwordsecure'
      fill_in :password_confirmation, with: 'passwordsecure'

      expect(page).to have_link('Already Registered? Log in Here')
      click_button 'Register'

      expect(current_path).to eq('/dashboard')

      expect(User.first.name).to eq('Kevin')
      expect(User.first.email).to eq('kev123@example.com')
    end

    it 'should return flash message with blank email' do
      visit 'registration'

      fill_in :name, with: 'Kevin'
      fill_in :email, with: ''
      fill_in :password, with: 'passwordsecure'
      fill_in :password_confirmation, with: 'passwordsecure'

      click_button 'Register'

      expect(page).to have_content("Email can't be blank")
      expect(current_path).to eq('/registration')
    end
  end
end