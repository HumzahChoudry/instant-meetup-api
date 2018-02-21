class User < ApplicationRecord
  has_many :user_meetups
  has_many :meetups, through: :user_meetups
  has_secure_password

end
