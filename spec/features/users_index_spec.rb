require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

RSpec.feature 'Users#index view', type: :feature, js: true do
  users = User.all

  before(:each) do
    visit "#{base_url}/users"
  end

  scenario 'all users from the database are present' do
    users.each { |user| expect(page).to have_content user.name }
  end

  scenario 'each user has the right number of posts' do
    page.all('div.user_main').each.with_index(1) do |user_main, index|
      expect(user_main.all('span')[0].text.scan(/\d+/).first.to_i).to equal users.find(index).posts_counter
    end
  end

  scenario 'each user has his/her image displayed' do
    page.all('img').each.with_index(1) do |img, index|
      expect(img['src']).to eq users.find(index).photo
    end
  end

  scenario 'each username links to the /users/:id page (show action)' do
    User.all.each.with_index do |_user, index|
      username = page.all('.user_details')[index]

      expected_url = "#{base_url}/users/#{User.find_by(name: username.find('.user_title').text).id}"

      username.find('a').click

      expect(page).to have_current_path(expected_url)

      visit "#{base_url}/users"
    end
  end
end
