class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :created_at, :updated_at
  has_many :comments
end
