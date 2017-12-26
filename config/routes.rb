Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'api/v1/user/sessions',
        registrations: 'api/v1/user/registrations'
         }
      resources :drivers

    end
  end

  #

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
