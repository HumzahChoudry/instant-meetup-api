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

10.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, user_name: Faker::FamilyGuy.character, profile_pic: 'picture_url_here', current_latitude: (40 + rand(100)*0.01), current_longitude: (-70 + rand(100)*0.01), password_digest: 'Sup')
end

10.times do
  Friendship.create(user_id: User.all.sample, friend_id: User.all.sample,)
end

5.times do
  Meetup.create(location: Location.all.sample, host_id: User.all.sample.id)
end
# user.user_meetups.build(meetup_id: Meetup.all.sample.id)
20.times do
  UserMeetup.create(user_id: User.all.sample.id, meetup_id: Meetup.all.sample.id)
end
