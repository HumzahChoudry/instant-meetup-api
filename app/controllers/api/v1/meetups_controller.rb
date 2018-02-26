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
    @meetup = Meetup.new()
  end

  def login
    byebug
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

  def user_meetups

  end

  private
  def meetup_params
    params.permit(:title, :content)
  end
end
