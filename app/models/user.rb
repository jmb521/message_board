class User < ApplicationRecord
  has_one :profile
  has_many :posts
  has_many :comments, :through => :posts
  enum role: [:user, :moderator, :admin]
  has_secure_password

  validates :password, confirmation: true
  validates :email, :password, :password_confirmation, :username, presence: true
  validates :email, :username, uniqueness: true
end
