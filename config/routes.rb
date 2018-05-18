Rails.application.routes.draw do
  devise_for :user
  devise_scope :user do
    authenticated :user do
      root 'users#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  root  'users#index'
  resources :users, :only => [:index, :show]
  resources :friendships, only: [:create, :update, :destroy]
  resources :posts, :only => [:create, :destroy, :index]
  resources :comments, :only => [:create, :destroy]
  resources :likes, :only => [:create, :destroy]

end
