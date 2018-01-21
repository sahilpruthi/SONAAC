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
      resources :vehicles
      # resource :common 
      post '/get_drivers_near_to_me', to: 'commons#get_nearest_drivers'
      get '/check_user_existence/:email', to: 'commons#check_user'
      post '/offer_trip', to: 'commons#notify_cutomer_for_price'
      get '/get_drivers_offer/:user_id', to: 'commons#get_drivers_offer'
      get 'get_driver/:driver_id', to: 'commons#get_driver'
      get 'user_forgot_password/:user_id', to: 'commons#forgot_password'
      get 'driver_forgot_password/:driver_id', to: 'commons#driver_forgot_password'
      
    end
  end

  #

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
