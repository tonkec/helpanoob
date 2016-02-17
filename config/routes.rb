Rails.application.routes.draw do
  root "static_pages#home"
  resources :groups
  resources :posts do
    resources :comments
  end
  resources :users, only: [:show, :edit, :update]
  get "profile", to: "users#profile"
  get '/user/:id', to: 'users#show', as: "user_path"
  get '/user/:id/edit', to: 'users#edit', as: "edit_user_path"


  devise_for :users
  devise_scope :user do
    get "sign_in", to: "devise/sessions#new"
    get "sign_up", to: "devise/registrations#new"
    delete "sign_out", to: "devise/sessions#destroy"
    get '/reset_password' => "passwordusers#new", :as => :reset_password
    get '/new_password' => "passwordusers#edit", :as => :new_password
  end
end