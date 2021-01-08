Rails.application.routes.draw do
  root 'study_serch#home'
  get 'study_serch/home'
  get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
