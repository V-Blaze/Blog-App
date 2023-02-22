class Post < ApplicationRecord
    belongs_to :user, class_name: "user", foreign_key: "author_id"
    has_many :comments
    has_many :likes

end
