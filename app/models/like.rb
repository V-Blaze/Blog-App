class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :comment

  def update_post_comments_counter
    post.increment!(:likes_counter)
  end
end
