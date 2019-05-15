Rails.application.routes.draw do
  root 'static_pages#home'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'photos/new'
  resources :photos, only: [:new, :create]
end
