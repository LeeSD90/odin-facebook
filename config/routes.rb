Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  devise_for :users
  resources :users, :only => [:index, :show]
  resources :friendships, only: [:create, :update, :destroy]
end
