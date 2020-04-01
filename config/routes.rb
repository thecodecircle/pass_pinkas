Rails.application.routes.draw do
  resources :tasks
  resources :houses
  resources :families
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#index'
  get "/leaders" => "home#leaders"
	get "/pinkasi" => "home#pinkasi"
  get "/assign_task", to: "tasks#assign_task"
  get "/change_progress", to: "tasks#change_progress"
  get "/approve_task", to: "tasks#approve_task"
  get "/add_user_to_house", to: "home#add_user_to_house"
end
