Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do
    get "/applicant/sign_up", to: "users/registrations#new", as: "new_applicant"
    get "/agency/sign_up", to: "users/registrations#new", as: "new_agency"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :jobs
  # Defines the root path route ("/")
  root to: "pages#index"
end
