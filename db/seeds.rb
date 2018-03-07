require 'net/http'
require 'open-uri'
require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

url = 'https://randomuser.me/api/'
uri = URI.parse(url)

  #create Humzah and 2 friends
  User.create(first_name: 'Humzah', last_name: 'Choudry', username: 'humzah', profile_pic: 'https://media.licdn.com/mpr/mpr/shrinknp_200_200/p/5/005/0b5/03a/04f572a.jpg', current_latitude: (40.7052800), current_longitude: (-74.0140250), password: "123456")

  response = Net::HTTP.get_response(uri)
  info = JSON.parse(response.body)

  User.create(
    first_name: info["results"][0]["name"]["first"],
    last_name: info["results"][0]["name"]["last"],
    username: info["results"][0]["login"]["username"],
    profile_pic: info["results"][0]["picture"]["thumbnail"],
    current_latitude: (40.800694),
    current_longitude: (-73.955637),
    password: '123456'
  )

    response = Net::HTTP.get_response(uri)
    info = JSON.parse(response.body)

    User.create(
      first_name: info["results"][0]["name"]["first"],
      last_name: info["results"][0]["name"]["last"],
      username: info["results"][0]["login"]["username"],
      profile_pic: info["results"][0]["picture"]["thumbnail"],
      current_latitude: (40.725053),
      current_longitude: (-73.981052),
      password: '123456'
    )

    response = Net::HTTP.get_response(uri)
    info = JSON.parse(response.body)

    User.create(
      first_name: info["results"][0]["name"]["first"],
      last_name: info["results"][0]["name"]["last"],
      username: info["results"][0]["login"]["username"],
      profile_pic: info["results"][0]["picture"]["thumbnail"],
      current_latitude: (40.747703),
      current_longitude: (-73.976851),
      password: '123456'
    )

    response = Net::HTTP.get_response(uri)
    info = JSON.parse(response.body)

    User.create(
      first_name: info["results"][0]["name"]["first"],
      last_name: info["results"][0]["name"]["last"],
      username: info["results"][0]["login"]["username"],
      profile_pic: info["results"][0]["picture"]["thumbnail"],
      current_latitude: (40.711608),
      current_longitude: (-73.960415),
      password: '123456'
    )

    response = Net::HTTP.get_response(uri)
    info = JSON.parse(response.body)

    User.create(
      first_name: info["results"][0]["name"]["first"],
      last_name: info["results"][0]["name"]["last"],
      username: info["results"][0]["login"]["username"],
      profile_pic: info["results"][0]["picture"]["thumbnail"],
      current_latitude: (40.767737),
      current_longitude: (-73.983665),
      password: '123456'
    )

    response = Net::HTTP.get_response(uri)
    info = JSON.parse(response.body)

    User.create(
      first_name: info["results"][0]["name"]["first"],
      last_name: info["results"][0]["name"]["last"],
      username: info["results"][0]["login"]["username"],
      profile_pic: info["results"][0]["picture"]["thumbnail"],
      current_latitude: (40.775319),
      current_longitude: (-73.956710),
      password: '123456'
    )

    response = Net::HTTP.get_response(uri)
    info = JSON.parse(response.body)

    User.create(
      first_name: info["results"][0]["name"]["first"],
      last_name: info["results"][0]["name"]["last"],
      username: info["results"][0]["login"]["username"],
      profile_pic: info["results"][0]["picture"]["thumbnail"],
      current_latitude: (40.676527),
      current_longitude: (-73.964617),
      password: '123456'
    )

    response = Net::HTTP.get_response(uri)
    info = JSON.parse(response.body)

    User.create(
      first_name: info["results"][0]["name"]["first"],
      last_name: info["results"][0]["name"]["last"],
      username: info["results"][0]["login"]["username"],
      profile_pic: info["results"][0]["picture"]["thumbnail"],
      current_latitude: (40.716427),
      current_longitude: (-74.004120),
      password: '123456'
    )












  Friendship.create(user_id: 1, friend_id: 2)
  Friendship.create(user_id: 1, friend_id: 3)
  Friendship.create(user_id: 2, friend_id: 1)
  Friendship.create(user_id: 2, friend_id: 3)
  Friendship.create(user_id: 3, friend_id: 1)
  Friendship.create(user_id: 3, friend_id: 2)
  Friendship.create(user_id: 5, friend_id: 2)
  Friendship.create(user_id: 2, friend_id: 5)

# 10.times do
#   Meetup.create(location_id: Location.all.sample.id, host_id: User.all.sample.id)
# end
# user.user_meetups.build(meetup_id: Meetup.all.sample.id)


# UserMeetup.create(user_id: 1, meetup_id: 1)
# UserMeetup.create(user_id: 1, meetup_id: 2)
# UserMeetup.create(user_id: 2, meetup_id: 3)
# UserMeetup.create(user_id: 2, meetup_id: 1)
# UserMeetup.create(user_id: 3, meetup_id: 1)
# UserMeetup.create(user_id: 1, meetup_id: 6)
# UserMeetup.create(user_id: 8, meetup_id: 7)
# UserMeetup.create(user_id: 6, meetup_id: 7)
# UserMeetup.create(user_id: 5, meetup_id: 9)
# UserMeetup.create(user_id: 4, meetup_id: 1)
