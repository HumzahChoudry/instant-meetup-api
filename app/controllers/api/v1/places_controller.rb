require 'net/http'
require 'open-uri'
require 'json'

# Marvin AIzaSyDXX--6ZEOR4jUxhmS6qbuVxgfKouP8Xmk
# Matt AIzaSyAUtkYCeGodhngmVM40Yo8PxDDlgU6mrfo
class Api::V1::PlacesController < ApplicationController

  def get_places(location)
    base_url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'

    key = '?key=AIzaSyCJWxC8L5mK9wrlkILVrNP3RmDT2yEXi6Y'
    type = "&type=#{params[:type]}"
    radius = "&radius=#{params[:radius]}"
    location = "&location=#{params[:location]}"
    # location = '&location=40.7052569,-74.0162643'

    final_url = "#{base_url + key + location + type + radius}"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)


    render json: {locations: result}
  end

  def get_place
    url = 'https://maps.googleapis.com/maps/api/place/details/json'

    place_id = "&place_id=#{params[:place_id]}"
    key = '?key=AIzaSyAUtkYCeGodhngmVM40Yo8PxDDlgU6mrfo'

    final_url = "#{url + key + place_id}"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    response.body
    result = JSON.parse(response.body)

    render json: {locations: result, path: final_url}
  end

  def get_picture
    url = 'https://maps.googleapis.com/maps/api/place/photo'

    key = '?key=AIzaSyAUtkYCeGodhngmVM40Yo8PxDDlgU6mrfo'
    picture_id = "&photoreference=#{params[:picture_id]}"
    # 1280 x 720

    final_url = "#{url + key + picture_id}&maxwidth=400"

    uri = URI.parse(final_url)
    response = Net::HTTP.get_response(uri)
    # result = response.body

    picture_url = response.body.split("A HREF=\"") # remove first part of "A" HTML TAG
    picture_url = picture_url[1].split("\">here") # remove second part of "A" HTML TAG

    render json: {picture: picture_url[0]}
  end
end
