class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def update_post_user_counter
    user.increment!(:posts_counter)
  end

  def five_most_recent_comments
    comments.last(5)
  end
end
