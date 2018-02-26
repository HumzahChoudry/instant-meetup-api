class AuthController < ApplicationController

  def login

      user = login_user(params[:username], params[:password])

      render json: {
        user: {
          id: user.id,
          username: user.username,
        },
        token: encode_token({'user_id': user.id})
      }
  end


  def signup
    user = User.create(username: params[:username], password: params[:password])

  end

  def get_current_user
    user = currentUser
    if user
      render json: {
        user: {
          id: user.id,
          username: user.username,
        },
        token: encode_token({'user_id': user.id})
      }
    else
      render json: nil
    end
  end
end
