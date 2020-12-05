require 'rails_helper'

RSpec.describe 'Logging in' do
  describe 'As authenticate user' do
    it 'can login with valid credentials' do
      user = User.create(name: 'Kevin', email: 'kev123@example.com', password: 'securepassword')
      visit '/'

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button 'Log In'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Welcome #{user.name}!")
    end

    it 'can\'t login with bad credentials' do
      visit '/'

      fill_in :email, with: 'not_real@example.com'
      fill_in :password, with: '12333222'

      click_button 'Log In'

      expect(current_path).to eq('/')
      expect(page).to have_content('Credentials are incorrect')
    end
  end

  describe 'Logging Out' do
    it 'User can log out' do
      user = User.create(name: 'Kevin', email: 'kev123@example.com', password: 'securepassword')
        visit '/'

        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_button 'Log In'

        click_on 'Click Here to Logout'

        expect(current_path).to eq('/')
        expect(page).to have_content('You are now logged out')
    end
  end
end