Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v0 do
      resources :identities, only: [:index]

      resources :users, only: [:destroy, :create, :update, :show] do
        resources :tattoos, only: [:index], controller: "user_tattoos"
        resources :identities, only: [:index], controller: "user_identities"
      end

      resources :user_tattoos, only: [:create]
      resources :artist_identities, only: [:create]
      
      delete "/artist_identities", to: "artist_identities#destroy"

      delete "/user_tattoos", to: "user_tattoos#destroy"
      
      # get "/distance_search", to: "distance_search#search"
      # get "/distance_search/:user_id", to: "distance_search#search"

      
      resources :artists do 
        resources :tattoos, only: [:index], controller: "artist_tattoos"
        resources :identities, only: [:index, :destroy], controller: "artist_identities"
      end

      resources :tattoos, only: [:index, :show, :create, :update, :destroy]

      post "/sign_in", to: "sign_in#verify_sign_in"
      delete "/sign_out", to: "sign_out#sign_out"

      resources :user_identities, only: [:create]
      delete "/user_identities", to: "user_identities#destroy"
    end
  end
end
