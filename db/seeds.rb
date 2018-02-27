# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  Location.create(name: Faker::FamilyGuy.location)
end

  User.create(first_name: 'Humzah', last_name: 'Choudry', username: 'humzah', profile_pic: 'picture_url_here', current_latitude: (40.7052800), current_longitude: (-74.0140250), password: "123456")

10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, username: Faker::FamilyGuy.character, profile_pic: 'picture_url_here', current_latitude: (40.7 + rand(100)*0.0001), current_longitude: (-74.01 - rand(100)*0.0001), password: '123456')
end


  Friendship.create(user_id: 1, friend_id: 2)
  Friendship.create(user_id: 1, friend_id: 3)
  Friendship.create(user_id: 1, friend_id: 4)
  Friendship.create(user_id: 1, friend_id: 5)
  Friendship.create(user_id: 1, friend_id: 6)
  Friendship.create(user_id: 2, friend_id: 3)
  Friendship.create(user_id: 5, friend_id: 9)
  Friendship.create(user_id: 9, friend_id: 1)


10.times do
  Meetup.create(location_id: Location.all.sample.id, host_id: User.all.sample.id)
end
# user.user_meetups.build(meetup_id: Meetup.all.sample.id)


  UserMeetup.create(user_id: 1, meetup_id: 1)
  UserMeetup.create(user_id: 1, meetup_id: 2)
  UserMeetup.create(user_id: 2, meetup_id: 3)
  UserMeetup.create(user_id: 2, meetup_id: 1)
  UserMeetup.create(user_id: 3, meetup_id: 1)
  UserMeetup.create(user_id: 1, meetup_id: 6)
  UserMeetup.create(user_id: 8, meetup_id: 7)
  UserMeetup.create(user_id: 6, meetup_id: 7)
  UserMeetup.create(user_id: 5, meetup_id: 9)
  UserMeetup.create(user_id: 4, meetup_id: 1)
