Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users
      resources :friendships
      resources :meetups

      #post '/chats/:id/messages', to: 'chats#send_message'
      #mount ActionCable.server => '/cable'
    end
  end

end
