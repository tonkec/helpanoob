Rails.application.routes.draw do
  root "posts#index"
  get "landing_page", to: "static_pages#home"
  get "welcome", to: "static_pages#welcome"
  resources :groups
  resources :posts do
    resources :comments

    member do 
      put "like" => "posts#upvote"
      put "dislike" => "posts#downvote"
    end
  end

  get "unanswered" => "posts#unanswered"

  get "profile", to: "users#profile"
  #get '/user/:id', to: 'users#show', as: "user_path"
  #get '/user/:id/edit', to: 'users#edit', as: "edit_user_path"

  devise_for :users, controllers: { registrations: "registrations" }

  devise_scope :user do
  #  get "sign_in", to: "devise/sessions#new"
  #  get "sign_up", to: "devise/registrations#new"
   # delete "sign_out", to: "devise/sessions#destroy"
    get '/reset_password' => "passwordusers#new", :as => :reset_password
    get '/new_password' => "passwordusers#edit", :as => :new_password
  end

  resources :users, only: [:show, :edit, :update]
end