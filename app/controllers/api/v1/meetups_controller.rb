class Api::V1::MeetupsController < ApplicationController
  def index
    @meetups = Meetup.all
    render json: @meetups
  end

  def show
    user = User.find(params[:id])
    meetups = user.meetups
    render json: meetups
  end

  def create
    user = params[:id]

    if user
      meetup = Meetup.new(host_id: user.id)
      #will send meetup request to friends using action cable

      #right now we will just add all friends to meetup
      user.friends.each do |friend|
        meetup << friend
      end
      coordinates = average_meetup_users_location(meetup)
      location_data = find_location(coordinates)
    end

    render json: {locations: location_data}
  end

  def update
    @meetup = Meetup.find(params[:id])

    @meetup.update(meetup_params)
    if @meetup.save
      render json: @meetup
    else
      render json: {errors: @meetup.errors.full_messages}, status: 422
    end
  end

  def average_meetup_users_location(meetup)
    average_lat = 0
    average_lon = 0
    meetup.users.each do |p|
      average_lat += p.current_latitude
      average_lon += p.current_longitude
    end
    average_lat = average_lat / meetup.users.len
    average_lon = average_lon / meetup.users.lon
    return "#{average_lat},#{average_lon}"
  end

  def find_location(location)
    base_url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'

    key = '?key=AIzaSyCJWxC8L5mK9wrlkILVrNP3RmDT2yEXi6Y'
    type = "&type=bar"
    radius = "&radius=200"
    location = "&location=#{location}"
    # location = '&location=40.7052569,-74.0162643'

    final_url = "#{base_url + key + location + type + radius}"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)
    byebug


  end

  private
  def meetup_params
    params.permit(:title, :content)
  end
end
