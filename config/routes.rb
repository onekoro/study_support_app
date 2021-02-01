Rails.application.routes.draw do
  root 'study_serch#home'
  get '/signup', to: 'users#new'
  resources :users
end
