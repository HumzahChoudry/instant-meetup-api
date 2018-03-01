require 'net/http'
require 'open-uri'
require 'json'

class Api::V1::MeetupsController < ApplicationController
  def index
    @meetups = Meetup.all
    render json: @meetups
  end


  def show
    user = User.find(params[:id])
    meetups = user.meetups
    byebug
    render json: meetups
  end

  def create
    user = User.find(params[:user_id])

    if user
      @meetup = Meetup.new(host_id: user.id)
      #will send meetup request to friends using action cable
      #right now we will just add all friends to meetup
      @meetup.users < user
      user.friends.each do |friend|
        @meetup.users << friend
      end

      coordinates = average_meetup_users_location(@meetup)
      location_data = find_location(coordinates)
      #get picture uses return from get place to get picture and add it to @meetup
      x = get_place(location_data["place_id"])
      picture_url = get_picture(x)

      location = create_or_find_location(location_data, picture_url)
      #add_location_to_meetup

      @meetup.location_id = location.id

      if @meetup.save
        #return_meetup_to_frontend with location data
        render json: @meetup
      else
        render json: {errors: @meetup.errors.full_messages}, status: 422
      end
    end
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
    average_lat = average_lat / meetup.users.length
    average_lon = average_lon / meetup.users.length

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
    max = result["results"].length

    return result["results"][rand(max)]
  end

  def create_or_find_location(location_data, picture_url)
    location = Location.find_or_create_by(
      name: location_data["name"],
      place_id: location_data["place_id"],
      lat: location_data["geometry"]["location"]["lat"],
      lng: location_data["geometry"]["location"]["lng"],
      vicinity: location_data["vicinity"],
      photo: picture_url
     )
  end

  def get_picture(picture_id)
    url = 'https://maps.googleapis.com/maps/api/place/photo'

    key = '?key=AIzaSyCJWxC8L5mK9wrlkILVrNP3RmDT2yEXi6Y'
    picture_id = "&photoreference=#{picture_id}"
    # 1280 x 720

    final_url = "#{url + key + picture_id}&maxwidth=400"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    # result = response.body
    picture_url = response.body.split("A HREF=\"") # remove first part of "A" HTML TAG
    picture_url = picture_url[1].split("\">here") # remove second part of "A" HTML TAG

    picture_url[0]
  end

  def get_place(place_id)
    url = 'https://maps.googleapis.com/maps/api/place/details/json'

    place_id = "&place_id=#{place_id}"
    key = '?key=AIzaSyAUtkYCeGodhngmVM40Yo8PxDDlgU6mrfo'

    final_url = "#{url + key + place_id}"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)
    result["result"]["photos"][0]["photo_reference"]

  end

  private
  def meetup_params
    params.permit(:host_id)
  end
end
