Rails.application.routes.draw do
  resources :orders, only: [ :create ]

  get "events/index"
  # get "sports/index"
  # get "locations/index"

  resources :events, only: [ :show, :create ]

  resources :sports, only: [ :index, :create ]
  resources :locations, only: [ :index, :create ]
  resources :events, only: [ :create, :show ]

  post "signup", to: "auth#signup"
  post "login", to: "auth#login"

  resources :users do
    collection do
      get "my_orders"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
