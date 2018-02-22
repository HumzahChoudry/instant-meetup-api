class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :user_meetups
  has_many :meetups, through: :user_meetups
  has_secure_password

end
