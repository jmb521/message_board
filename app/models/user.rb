class User < ApplicationRecord
  has_secure_password
  has_one :profile
  has_many :posts
  has_many :comments, :through => :posts
end
