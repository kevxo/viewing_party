require 'rails_helper'

RSpec.describe 'when I visit the root path I should see the welcome page' do
  it 'has a welcome message' do
    visit '/'

    expect(page).to have_content("Welcome to Viewing Party")
  end

  it 'has a brief description' do
    visit '/'

    expect(page).to have_content('Viewing party is an application in which users can explore movie options and create a viewing party event for the user and friend\'s.')
  end

  it 'has a button to log in' do
    visit '/'

    expect(page).to have_button("Log In")
  end

  it 'has a link to register' do
    visit '/'

    click_link("New to Viewing Party? Register Here")
    expect(current_path).to eq('/registration')
  end

end
