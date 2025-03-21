Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  # root "application#hello"
  resources :quizzes do
    member do
      get 'overview'
    end
    resources :questions, only: [:index, :create, :edit, :update, :destroy, :show] do
      member do
        get 'answer'
        get 'result'
        get 'confirm_destroy'
        delete :destroy # destroyアクションのルーティング
      end
    end
    member do
      get 'confirm_destroy' # クイズ削除確認ページ
    end
  end
  resources :choices
  resources :users, only: [:index, :show]
  resources :user_questions, only: [:create]
  resources :quizzes do
    resource :favorites, only: [:create, :destroy] # create と destroy を指定
  end

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'
  root "sessions#new"
end