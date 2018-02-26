class Api::V1::FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.all
    render json: @friendships
  end

  def show
    user = User.find(params[:id])
    friends = user.friends
    render json: friends
  end

  def create
    @friendship = Friendship.new()
  end

  def update
    @friendship = Friendship.find(params[:id])

    @friendship.update(friendship_params)
    if @friendship.save
      render json: @friendship
    else
      render json: {errors: @friendship.errors.full_messages}, status: 422
    end
  end

  private
  def friendship_params
    params.permit(:title, :content)
  end
end
#HAVE NOT CREATED MODEL YET
