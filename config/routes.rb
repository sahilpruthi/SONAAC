Rails.application.routes.draw do


root to: 'admin/admin_session#index'
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
      resources :vehicles do
       collection do
        post :search_vehicle
        get :get_stations
        post :vehicle_details
       end
      end
      post '/get_drivers_near_to_me', to: 'commons#get_nearest_drivers'
      get '/check_user_existence/:email', to: 'commons#check_user'
      post '/offer_trip', to: 'commons#notify_cutomer_for_price'
      get '/get_drivers_offer/:user_id', to: 'commons#get_drivers_offer'
      get 'get_driver/:driver_id', to: 'commons#get_driver'
      post 'user_sign_out', to: 'commons#user_sign_out'
      post 'driver_sign_out', to: 'commons#driver_sign_out'
      post '/start_trip', to: 'commons#start_trip'
      get 'user_forgot_password/:user_id', to: 'commons#forgot_password'
      get 'driver_forgot_password/:driver_id', to: 'commons#driver_forgot_password'
      post 'get_nearest_user_driver', to: 'commons#get_nearest_user_driver'
      post 'cancel_trip', to: 'commons#cancel_trip'
      post 'stop_trip', to: 'commons#stop_trip'
      post 'resume_trip', to: 'commons#resume_trip'
      get '/get_state', to: 'state_city#get_state'
      get '/get_cities/:state', to: 'state_city#get_cities'

    end
  end
  namespace :admin do
    get '/', to: 'admin_session#index'
    post '/login', to: 'admin_session#login'
    get '/home', to: 'admin_session#home'
    delete '/session_destory', to: 'admin_session#destroy'
    get '/privacy_policy', to: 'admin_session#privacy_policy'
    resources :drivers, only: %i(edit index update)
    resources :vehicles do
      collection do
        post :vehicle_sheet
      end
    end
    resources :users, only: %i(edit index update destroy) 

  end

  #

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
