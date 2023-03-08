require 'rails_helper'
require 'capybara/rspec'

base_url = 'http://localhost:3000'

random_number = rand(1..User.count)
posts_id = User.find(random_number).posts.map(&:id)
random_post = posts_id[rand(0...posts_id.length)]

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts/#{random_post}"
  end

  scenario 'post title is visible on the page' do
    expect(page).to have_selector('h3.post_title')
  end

  scenario 'post author is visible on the page' do
    author = page.find('.post_title').text.split(/ by /)[1]

    expect(author).to eq @user.name
  end

  scenario 'the number of comments of the post is shown on the page' do
    number_of_comments = page.all('.post_comments_likes_count span')[0].text.scan(/\d+/).first.to_i

    expect(Post.find(random_post).comments_counter).to eq number_of_comments
  end

  scenario 'the number of likes of the post is shown on the page' do
    number_of_likes = page.all('.post_comments_likes_count span')[1].text.scan(/\d+/).last.to_i

    expect(Post.find(random_post).likes_counter).to eq number_of_likes
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts/#{random_post}"
  end

  scenario 'the post body is displayed on the page' do
    expect(Post.find(random_post).text).to eq page.find('.post_text').text
  end

  scenario 'the name of each commentor appears on the page' do
    page_commentors = page.all('.post_comments_details').map { |c| c.all('span')[0].text.match(/(\w+?):/)[1] }
    post_commentors = Post.includes(comments: :author).find(random_post).comments.map { |c| c.author.name }

    expect(page_commentors).to eq post_commentors
  end

  scenario 'all the comments are displayed on the page' do
    page_comments = page.all('.post_comments_details').map { |c| c.all('span')[1].text }
    post_comments = Post.includes(comments: :author).find(random_post).comments.map(&:text)

    expect(page_comments).to eq post_comments
  end
end

RSpec.feature 'Users#index view', type: :feature, js: true do
  before(:each) do
    @user = User.find(random_number)
    visit "#{base_url}/users/#{random_number}/posts/#{random_post}"
  end
end
