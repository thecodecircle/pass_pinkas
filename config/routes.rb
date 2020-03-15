Rails.application.routes.draw do
  resources :tasks
  resources :groups
  resources :branches
  resources :regions
  resources :movements
  devise_for :users
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
