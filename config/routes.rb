Rails.application.routes.draw do
  resources :posts
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  root "users#new"
end
