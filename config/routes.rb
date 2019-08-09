Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'
  get '/gallery', to: 'photos#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/api/photos/:photo_id/comments/', to: 'comments#list'
  post '/api/photos/:photo_id/comments/', to: 'comments#create'
  resources :users, only: [:show , :edit, :update]
  resources :photos, only: [:new, :create, :show]
  resources :likes, only: [:create, :destroy]
end
