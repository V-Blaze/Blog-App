class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def update_post_user_counter
    author.increment!(:posts_counter)
  end

  def five_most_recent_comments
    comments.last(5)
  end
end
