# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'static_pages#home'
  get '/gallery', to: 'photos#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: %i[show edit update]
  resources :photos, only: %i[new create show destroy]
  resources :likes, only: %i[create destroy]

  namespace :api do
    namespace :v1 do
      get '/photos/:photo_id/comments/', to: 'comments#index'
      post '/photos/:photo_id/comments/', to: 'comments#create'
      resources :photos, only: %i[index show create destroy]
    end
  end
end
