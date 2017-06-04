class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id
  has_many :comments
end
