class Api::V1::FriendshipsController < ApplicationController

  def index
    @friendships = Friendship.all
    render json: @friendships
  end

  def show
    user = User.find(params[:id])
    friends = user.friends
    render :json => friends.to_json
  end

  def create
    friend = User.find(params[:friendId])
    Friendship.create_reciprocal_for_ids(params[:user][:id], friend.id)

    render :json => friend.to_json
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
    params.permit()
  end
end
#HAVE NOT CREATED MODEL YET
