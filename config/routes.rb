Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users
      resources :friendships
      resources :meetups
      get '/users/:id/meetups', to: 'meetups#user_meetups'
      #post '/chats/:id/messages', to: 'chats#send_message'
      #mount ActionCable.server => '/cable'
    end
  end
  post '/login', to: 'auth#login'
  get '/get_current_user', to: 'auth#get_current_user'
end
