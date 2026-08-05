Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :posts, only: [ :index, :show ]

  get "about", to: "pages#about"
  get "start", to: "pages#start"

  namespace :admin do
    root to: "entrypoints#show"
    get "dashboard", to: "dashboard#index"
    resources :posts do
      member do
        patch :publish
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
end
