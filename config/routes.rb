Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/user/sessions',
        registrations: 'api/v1/user/registrations'
         }
      devise_for :drivers, controllers: {
        sessions: 'api/v1/driver/sessions',
        registrations: 'api/v1/driver/registrations'
         }

      # resource :common 
      post '/get_drivers_near_to_me', to: 'commons#get_driver'
      get '/check_user_existence/:email', to: 'commons#check_user'
      
    end
  end

  #

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
