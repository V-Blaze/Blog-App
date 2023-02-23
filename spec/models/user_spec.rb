require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.', posts_counter: 0) }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should be equal or great than 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Subject should be valid' do
    expect(subject).to be_valid
  end

  it 'Returns 3 most recent post' do
    subject.posts.create(title: 'Hello', text: 'This is my first post')
    subject.posts.create(title: 'Hello', text: 'This is my second post')
    subject.posts.create(title: 'Hello', text: 'This is my third post')
    subject.posts.create(title: 'Hello', text: 'This is my fourth post')
    expect(subject.three_most_recent_post.count).to eql(3)
  end
end
