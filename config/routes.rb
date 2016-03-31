Rails.application.routes.draw do
  root "posts#index"
  get "landing_page", to: "static_pages#home"
  get "about", to: "static_pages#about"

  resources :posts do
    get :autocomplete_tag_name, :on => :collection  
    resources :comments do
       member do 
        put "like" => "comments#upvote"
        put "dislike" => "comments#downvote"
      end
    end

    member do 
      put "like" => "posts#upvote"
      put "dislike" => "posts#downvote"
    end
  end


  get "unanswered" => "posts#unanswered"
  get "profile", to: "users#profile"
  get 'tags', to: 'posts#tags'

  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'tags/unanswered/:tag', to: 'posts#unanswered', as: :unanswered_tag
  #get '/user/:id', to: 'users#show', as: "user_path"
  get '/profile/edit', to: 'users#edit', as: "edit_profile"

  devise_for :users, controllers: { registrations: "registrations" }

  devise_scope :user do
  #  get "sign_in", to: "devise/sessions#new"
  #  get "sign_up", to: "devise/registrations#new"
   # delete "sign_out", to: "devise/sessions#destroy"
    get '/reset_password' => "passwordusers#new", :as => :reset_password
    get '/new_password' => "passwordusers#edit", :as => :new_password
  end

  resources :users, only: [:show, :update]
end