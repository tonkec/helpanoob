Rails.application.routes.draw do
  root "posts#index"
  get "landing_page", to: "static_pages#home"
  get "about", to: "static_pages#about"

  resources :posts do
    get :autocomplete_tag_name, :on => :collection
     
    resources :comments, only: [:edit, :create, :update, :destroy] do
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

  devise_for :users, controllers: { registrations: "registrations" }

  devise_scope :user do
    get '/reset_password' => "passwordusers#new", :as => :reset_password
    get '/new_password' => "passwordusers#edit", :as => :new_password
  end

  resources :users, only: [:show, :update, :user_posts, :destroy] do
    match 'users/:id' => 'users#destroy', :via => :delete, :as => :delete_user
    resources :skills, only: [:create, :new, :destroy]
  end
  
end