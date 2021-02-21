Rails.application.routes.draw do
  root 'places#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :places
  resources :relationships, only: [:create, :destroy]
end
