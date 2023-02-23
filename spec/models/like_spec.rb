require 'rails_helper'

RSpec.describe Like, type: :model do
  subject do
    Like.new(
      post: Post.new(
        author: User.new(
          name: 'Val', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
          bio: 'Teacher from Microverse.',
          posts_counter: 0
        ), title: 'Hello', text: 'Awesome post',
        likes_counter: 0, comments_counter: 0
      ),
      author: User.new(name: 'Blaze', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Mentor from NG.',
                       posts_counter: 0)
    )
  end

  before { subject.save }

  it 'update_post_comments_counter should return a right result when calling it with before save' do
    expect(subject.post.likes_counter).to eq(0)
  end
end
