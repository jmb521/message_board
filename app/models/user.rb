class User < ApplicationRecord
  has_one :profile
  has_many :posts
  has_many :comments, :through => :posts
  enum role: [:user, :moderator, :admin]
  has_secure_password
end
