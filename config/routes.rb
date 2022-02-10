Rails.application.routes.draw do
  get 'agencies/index'
  get 'reviews/new'
  get 'reviews/edit'
  get 'users/index'
  get 'users/show'
  get '/', to: "pages#index", as: "pages"
  get '/dashboard', to: "pages#dashboard", as: "dashboard"
  get '/guidelines', to: "pages#dashboard", as: "guidelines"
  get '/jobsandagencies', to: "pages#applicant_jobs", as: "jobsandagencies"
  get 'search_job' => 'jobs#job_search'



  # post 'applicant/:id', to: 'applicants#update'

  resources :messages

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
  resources :jobs
  resources :users

  get 'admins/:user_type', to: 'admins#users', as: 'admin_users'
  get 'admins/new/:user_type', to: 'users#new', as: 'new_admin_user'
  # (new_)admin_users_path("agency" || "applicant" || "admin" || "user")
  resources :applicants
  resources :agencies do
    resources :reviews
    resources :jobs
  end
  resources :admins

  # Defines the root path route ("/")
  root to: "pages#index"
end
