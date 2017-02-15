class Post < ApplicationRecord
  has_many :comments
  # has_many :users, :through => :comments
  belongs_to :user

  def delete_post
    #allows owner of the post, a moderator or an admin to delete the post.
  end
end
