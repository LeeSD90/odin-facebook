Rails.application.routes.draw do

  get 'posts/index'
  get 'posts/create'
  get 'posts/destroy'
  devise_scope  :user do
    authenticated :user do
      root  'users#index', as: :authenticated_root
    end

    unauthenticated :user do
      root  'devise/sessions#new', as: :unauthenticated_root
    end
  end
  root  'devise/sessions#new'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, :only => [:index, :show]
  resources :friendships, only: [:create, :update, :destroy]
  resources :posts, :only => [:create, :destroy, :index]
end
