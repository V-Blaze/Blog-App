require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

random_number = rand(1..User.count)

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts"
  end

  scenario 'displaying user photo on the page' do
    expect(page.find('img')['src']).to eq @user.photo
  end

  scenario 'displaying user username on the page' do
    expect(page.find('.user_post_section_title').text).to eq @user.name
  end

  scenario 'displaying right number of posts on the page' do
    expect(page.find('.user_post_details_info span').text.scan(/\d+/).first.to_i).to equal @user.posts_counter
  end

  scenario 'displaying post title on the page' do
    expect(page.all('.user_post_title').count).to be > 0
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts"
  end

  scenario 'displaying at least some of the post body on the page' do
    posts_bodies = page.all('.user_posts_info p').map(&:text)
    posts_bodies.each do |article|
      article = article.sub(/\.{3}\z/, '') if article.end_with?('...')
      expect(@user.posts.any? { |post| /^#{article}/.match?(post.text) }).to be true
    end
  end

  scenario 'displaying the first five comments on a post' do # (?)
    @user.posts.each do |post|
      post.five_most_recent_comments.each do |comment|
        expect(page).to have_content comment.text
      end
    end
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts"
  end

  scenario 'displaying number of comments on the page' do
    page.all('.user_posts_info').each do |post|
      post_title = post.find('.user_post_title a').text
      number_of_comments = post.all('.user_posts_comments_likes span')[0].text.scan(/\d+/).first.to_i
      expect(Post.find_by(title: post_title).comments_counter).to eq number_of_comments
    end
  end

  scenario 'displaying number of likes on the page' do
    page.all('.user_posts_info').each do |post|
      post_title = post.find('.user_post_title a').text
      number_of_likes = post.all('.user_posts_comments_likes span')[1].text.scan(/\d+/).last.to_i
      expect(Post.find_by(title: post_title).likes_counter).to eq number_of_likes
    end
  end

  # scenario 'displaying pagination button on the page' do # (no pagination button)
  #   expect(page).to have_selector('.user-posts-more button')
  # end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts"
  end

  scenario 'post clicking redirects to /users/:id/posts/:post_id' do
    @user.posts.each.with_index do |post, index|
      article = page.all('.user_post_title a')[index]
      expected_url = "#{base_url}/users/#{@user.id}/posts/#{post.id}"
      article.click
      expect(page).to have_current_path(expected_url)
      visit "#{base_url}/users/#{@user.id}/posts"
    end
  end

  # scenario "back button clicking redirects to user's page" do # (no back button)
  #   page.find(:css, '.btn-back').click
  #   expect(page).to have_current_path("#{base_url}/users/#{random_number}")
  # end
end
