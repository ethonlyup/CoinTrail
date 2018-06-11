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
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
