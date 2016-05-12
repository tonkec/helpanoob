Rails.application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  #resources :post_attachments
  require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
  
  authenticated do
    root :to => 'posts#index', as: :root_path
  end

  unauthenticated do
    root to: "static_pages#home"
  end

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

  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'tags/unanswered/:tag', to: 'posts#unanswered', as: :unanswered_tag

  devise_for :users,
    controllers: {omniauth_callbacks: "omniauth_callbacks"}
    
  resources :users, only: [:show, :update, :user_posts, :destroy] do
    match 'users/:id' => 'users#destroy', :via => :delete, :as => :delete_user
    resources :skills, only: [:create, :destroy]
  end



  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
    end

    member do
      post :restore
    end

    collection do
      delete :empty_trash
    end

    member do
      post :mark_as_read
    end
  end

  resources :messages, only: [:new, :create]
  
end