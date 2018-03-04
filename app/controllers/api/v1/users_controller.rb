class Api::V1::UsersController < ApplicationController

  def update_location
    @user = User.find(params[:id])
    @user.update(current_latitude: params[:current_latitude], current_longitude: params[:current_longitude])
    if @user.save
      render json: @user
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end
  end

  def index
    users = User.all
    render json: users
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password)
  end
end
