Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  root 'places#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/guest_login', to: 'sessions#new_guest'
  resources :users do
    member do
      get :following, :followers, :like_show
    end
  end
  resources :places do
    resources :comments, only: [:create, :destroy]
    member do
      get :tag_search
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  
end
