# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Location.create()

Meetup.create(location: Location.all.sample)

user = User.create(first_name: 'Humzah', last_name: 'Choudry', user_name: 'HChouDaddy', profile_pic: 'picture_url_here', current_latitude: 22.00, current_longitude: 52.12, password_digest: 'HFUIHIHFEI12i1hi1')

# user.user_meetups.build(meetup_id: Meetup.all.sample.id)

UserMeetup.create(user_id: User.all.sample.id, meetup_id: Meetup.all.sample.id)
