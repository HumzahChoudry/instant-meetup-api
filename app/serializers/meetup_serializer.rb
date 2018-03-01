class MeetupSerializer < ActiveModel::Serializer
  attributes :id, :host_id, :location_id, :public

  belongs_to :location
  has_many :users, through: :user_meetups
end
