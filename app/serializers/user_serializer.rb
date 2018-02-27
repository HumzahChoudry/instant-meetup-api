class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :profile_pic, :current_latitude, :current_longitude

  has_many :friends, through: :friendships
  has_many :meetups, through: :user_meetups
end
