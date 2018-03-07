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
    meetups = []
    user.friends.each do |friend|
      meetups.push(friend.meetups)
    end

    meetups = meetups.flatten.uniq
    publicMeetups = Meetup.all.where(public: true)
    meetups.push(publicMeetups)
    meetups = meetups.flatten.uniq
    if meetups
    render json: meetups
    else
      render json: {errors: meetup.errors.full_messages}, status: 422
    end
  end

  def show_friends_meetups
    user = User.find(params[:id])
    meetups = []
    user.friends.each do |friend|
      meetups.push(friend.meetups.flatten)
    end
    render json: meetups.uniq
  end

  def create
    user = User.find(params[:user_id])
    if user
      @meetup = Meetup.new(host_id: user.id, public: params[:public])
      selectedFriends = params[:selectedFriends]
      #will send meetup request to friends using action cable
      #right now we will just add all friends to meetup
      @meetup.users << user
      selectedFriends.each do |friend_info|
        @meetup.users << User.find(friend_info[:id])
      end
      coordinates = average_meetup_users_location(@meetup)
      location_data = find_location(coordinates, params[:keyword], 200)
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
    users = params[:users].map do |user|
      User.find(user[:id])
    end
    @meetup.users = users
    # @meetup.update(meetup_params)
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

  def find_location(location, keyword, radius)

    base_url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'

    key = '?key=AIzaSyCJWxC8L5mK9wrlkILVrNP3RmDT2yEXi6Y'
    type = "&type=#{keyword}"
    radius_str = "&radius=#{radius}"
    location_str = "&location=#{location}"
    # location = '&location=40.7052569,-74.0162643'

    final_url = "#{base_url + key + location_str + type + radius_str}"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)

    if (result["status"] == "ZERO_REULTS")
      find_location(location, keyword, (radius+100))
    end

    max = result["results"].length
    return result["results"][rand(max)]
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

    if(result["result"]["photos"])
      result["result"]["photos"][0]["photo_reference"]
    else
      "https://vignette.wikia.nocookie.net/kotlc/images/a/a8/10546i3DAC5A5993C8BC8C.jpg/revision/latest?cb=20170111040640"
    end
  end

  def get_picture(picture_id)

    if (picture_id == "https://vignette.wikia.nocookie.net/kotlc/images/a/a8/10546i3DAC5A5993C8BC8C.jpg/revision/latest?cb=20170111040640")
      return "https://vignette.wikia.nocookie.net/kotlc/images/a/a8/10546i3DAC5A5993C8BC8C.jpg/revision/latest?cb=20170111040640"
    end

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

  private
  def meetup_params
    params.require(:meetup).permit(:host_id, :location_id)
  end
end
