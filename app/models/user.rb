class User < ApplicationRecord
  has_one :profile
  has_many :posts
  has_many :comments, :through => :posts
  enum role: [:user, :moderator, :admin]
  has_secure_password

  validates :password, confirmation: true
  validates :email, :password, :password_confirmation, presence: true

  validates :username, :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }



  def self.show_moderators
    where(role: "moderator")
  end


end
# where("created_at >=?", Time.zone.today.beginning_of_day)
