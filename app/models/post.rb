class Post < ApplicationRecord
  has_many :comments
  belongs_to :user

  def comment_attributes=(comment_content)

        comment = Comment.new(comment_content)

        comment.post_id = self.id
        if comment.save
          self.comments << comment
        end
    end


end
