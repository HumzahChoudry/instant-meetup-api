class Api::V1::UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    @user.update(current_latitude: params[:current_latitude], current_longitude: params[:current_longitude])
    if @user.save
      render json: @user
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end
  end
end
