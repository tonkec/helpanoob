Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

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

  resources :conversations, only: [:index, :destroy] do
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

  resources :messages, only: [:create]

  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'notifications', to: 'notifications#index'
  get 'notifications/unread', to: 'notifications#unread'

  get 'messages/unread', to: 'messages#unread'

end