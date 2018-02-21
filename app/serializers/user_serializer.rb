class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :profile_pic, :current_latitude, :current_longitude
end
