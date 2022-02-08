Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/edit'
  get 'users/index'
  get 'users/show'
  get '/', to: "pages#index", as: "pages"
  get '/dashboard', to: "pages#dashboard", as: "dashboard"


  # post 'applicant/:id', to: 'applicants#update'

  resources :messages

  resources :rooms, param: :name do
    resources :messages
  end
  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do
    get "/:user_type/sign_up", to: "users/registrations#new", as: "new_user"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :jobs
  resources :users

  resources :applicants
  resources :agencies do
    resources :reviews
  end
  resources :admins

  # Defines the root path route ("/")
  root to: "pages#index"
end
