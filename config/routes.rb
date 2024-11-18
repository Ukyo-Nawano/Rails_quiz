Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get 'login', to: 'auth0#login'
  # get 'auth/auth0/callback', to: 'auth0#callback'
  # get 'auth/failure', to: 'auth0#failure'
  # get 'logout', to: 'auth0#logout'
  # get '/auth/auth0', to: redirect('/auth/auth0')
  get '/auth/auth0/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  # ログイン画面へのルート
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth/logout', to: 'sessions#logout'


  # ユーザー情報ページへのルート
  resources :users, only: [:index]

  # ルートページ
  root 'sessions#new'

  # root 'users#index'
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  # root "application#hello"
  resources :quizzes
  resources :choices
end