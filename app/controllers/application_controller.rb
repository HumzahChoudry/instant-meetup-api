class ApplicationController < ActionController::API

  private

  def encode_token(payload)
    JWT.encode(payload, secret, algorithm)
  end

  def login_user(username, password)

    user = User.find_by(username: username)
    if user && user.authenticate(password)
      user
    else
      raise AuthError
    end
  end

  def currentUser
    User.find_by(id: user_id_from_token(token))
  end

  def user_id_from_token(token)
    decode_token(token).first['user_id']
  end

  def decode_token(token)
    puts 'REQUEST MADE: ', token
    if (token)
      begin
        JWT.decode(token, secret, true, { algorithm: algorithm })
      rescue
        return [{}]
      end
    else
      return [{}]
    end
  end

  def token
    request.headers['Authorization']
  end

  def secret
    "rehtag"
  end

  def algorithm
    "HS256"
  end
end

class AuthError < StandardError
  def initialize(msg="No user or invalid password")
    super
  end
end
