Rails.application.routes.draw do
  # get 'alerts/create'
  # get 'alerts/destroy'
  # get 'alerts/update'
  # get 'alerts/new'
  # get 'alerts/show'
  # get 'alerts/index'
  # get 'alerts/edit'
  # get 'apis/create'
  # get 'apis/destroy'
  # get 'apis/new'
  # get 'apis/update'
  resources :apis, only: [:create, :new, :update]
  resources :apis, only: :destroy, as: :delete_api
  resources :alerts
  resources :alerts, only: :update, as: :update_alert
  resources :alerts, only: :destroy, as: :delete_alert


  devise_for :users
  root to: 'apis#new'
  get '/dashboard', to: 'pages#dashboard', as: 'dashboard'
  get '/profile', to: 'pages#profile', as: 'profile'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
