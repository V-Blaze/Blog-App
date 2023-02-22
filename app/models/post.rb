class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_post_user_counter

  def five_most_recent_comments
    comments.last(5)
  end

  private

  def update_post_user_counter
    author.increment!(:posts_counter)
  end
end
