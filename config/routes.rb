Rails.application.routes.draw do
  resources :tasks
  resources :groups
  resources :branches
  resources :regions
  resources :movements
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#index'
  get "/home/:leaders" => "home#leaders"
  get "/assign_task", to: "home#assign_task"
  get "/change_progress", to: "home#change_progress"
  get "/approve_task", to: "home#approve_task"
  # get '/patients/:id', to: 'patients#show'
  # get ‘/show_message’, ‘home#show_message’, as: :show_message
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
