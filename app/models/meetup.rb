class Meetup < ApplicationRecord
  belongs_to :location
  has_many :user_meetups
  has_many :users, through: :user_meetups

end
