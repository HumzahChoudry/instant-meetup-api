class AuthController < ApplicationController

  def login

      user = login_user(params[:username], params[:password])
      render json: {
        user: {
          id: user.id,
          username: user.username,
          firstname: user.first_name,
          lastname: user.last_name,
          picture_url: user.profile_pic,
          latitude: user.current_latitude,
          longitude: user.current_longitude
        },
        token: encode_token({'user_id': user.id})
      }
  end


  def signup
    @user = User.new(user_params)
    if @user.save
      render json: {
        user: @user,
        token: encode_token({'user_id': @user.id})
        }
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end
  end

  def get_current_user
    user = currentUser
    if user
      render json: {
        user: {
          id: user.id,
          username: user.username,
          firstname: user.first_name,
          lastname: user.last_name,
          picture_url: user.profile_pic,
          latitude: user.current_latitude,
          longitude: user.current_longitude
        },
        token: encode_token({'user_id': user.id})
      }
    else
      render json: nil
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password, :current_latitude, :current_longitude)
  end

end
