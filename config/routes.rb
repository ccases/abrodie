Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get '/', to: "pages#index", as: "pages"
  get '/dashboard', to: "pages#dashboard", as: "dashboard"
  get '/guidelines', to: "pages#dashboard", as: "guidelines"



  resources :messages
  resources :agencies
  resources :rooms, param: :name do
    resources :messages
  end
  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do
    get "/:user_type/sign_up", to: "users/registrations#new", as: "new_user"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :jobs do
    resources :applications
  end
  
  resources :pages
  # Defines the root path route ("/")
  root to: "pages#index"
end
