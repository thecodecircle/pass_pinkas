Rails.application.routes.draw do
  resources :tasks
  resources :houses
  resources :families
  resources :regions
  resources :movements
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#index'
  get "/leaders" => "home#leaders"
	get "/pinkasi" => "home#pinkasi"
  get "/assign_task", to: "tasks#assign_task"
  get "/change_progress", to: "tasks#change_progress"
  get "/approve_task", to: "tasks#approve_task"
  get "/kid_guide", to: "home#kid_guide"
  # get '/patients/:id', to: 'patients#show'
  # get ‘/show_message’, ‘home#show_message’, as: :show_message
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
