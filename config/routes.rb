Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v0 do
      resources :users, only: [:destroy, :create, :update, :show] do
        resources :tattoos, only: [:index], controller: "user_tattoos"
      end
      resources :user_tattoos, only: [:create]
      resources :artist_identities, only: [:create]
      
      delete "/user_tattoos", to: "user_tattoos#destroy"
      
      resources :artists do 
        resources :tattoos, only: [:index], controller: "artist_tattoos"
      end
      resources :tattoos, only: [:show]
      post "/sign_in", to: "sign_in#verify_sign_in"
    end
  end
end
