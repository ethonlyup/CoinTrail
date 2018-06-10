Rails.application.routes.draw do
  get 'apis/create'
  get 'apis/destroy'
  get 'apis/new'
  get 'apis/update'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
