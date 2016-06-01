require 'sidekiq/web'

Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :post_attachments

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

  devise_for :users
    
  resources :users, only: [:show, :update, :user_posts, :destroy] do
    match 'users/:id' => 'users#destroy', :via => :delete, :as => :delete_user
    resources :skills, only: [:create, :destroy]
  end

  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications', to: 'notifications#index'
  get 'notifications/unread', to: 'notifications#unread'

end