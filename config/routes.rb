Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'
  get '/gallery', to: 'static_pages#gallery'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'photos/new'
  resources :photos, only: [:new, :create]
  resources :likes, only: [:create, :destroy]
end
