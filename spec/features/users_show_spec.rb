require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

random_number = rand(1..User.count)

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'user has his/her image displayed' do
    expect(page.find('img')['src']).to eq @user.photo
  end

  scenario 'username is displayed on the page' do
    expect(page.find('.user_section_title').text).to eq @user.name
  end

  scenario 'user has the right number of posts' do
    expect(page.find('.user_details_info span').text.scan(/\d+/).first.to_i).to equal @user.posts_counter
  end

  scenario 'user has the right bio displayed' do
    expect(page.find('.user_bio_section span').text).to eq @user.bio
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'user has his/her first three (or less than) posts displayed' do
    page_posts = page.all('.user_details_post_container')
    page_posts = page_posts.map do |post|
      {
        title: post.find('.user_details_post_tile').text,
        text: post.find('p').text
      }
    end

    @user.three_most_recent_post.each_with_index do |post, index|
      database_post = { title: post.title, text: post.text }
      expect(database_post).to eq page_posts[index]
    end
  end

  scenario "the page displays a button that lets me see all the user's posts" do
    button = page.find('.user_details_see_btn')

    expect(button.text).to eq 'See all posts'
    expect(button['href']).to eq "#{base_url}/users/#{random_number}/posts"
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}"
  end

  scenario 'each post title links to the /users/:id/posts/:post_id page (show action of Posts controller)' do
    @user.three_most_recent_post.each_with_index do |post, index|
      article = page.all('.user_details_post_tile')[index]

      expected_url = "#{base_url}/users/#{@user.id}/posts/#{post.id}"

      article.find('a').click

      expect(page).to have_current_path(expected_url)

      visit "#{base_url}/users/#{random_number}"
    end
  end

  scenario 'clicking on All Posts button redirects me to all posts page' do
    page.find('.user_details_see_btn').click

    expect(page).to have_current_path("#{base_url}/users/#{random_number}/posts")
  end

  # scenario "clicking on Back to user button redirects me to user's page" do # (no back button)
  #   page.find('.btn-back').click

  #   expect(page).to have_current_path("#{base_url}/users/#{random_number}")
  # end
end
