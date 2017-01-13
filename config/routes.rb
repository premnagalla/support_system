Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :requests
  resources :departments

  root 'requests#index'
end
