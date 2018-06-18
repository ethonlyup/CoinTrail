Rails.application.routes.draw do
  resources :apis, only: [:create, :new, :update]
  resources :apis, only: :destroy, as: :delete_api
  resources :alerts, except: :index
  resources :alerts, only: :update, as: :update_alert
  resources :alerts, only: :destroy, as: :delete_alert

  devise_for :users, :controllers => { :registrations => 'registrations' }
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/profile', to: 'pages#profile', as: 'profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
