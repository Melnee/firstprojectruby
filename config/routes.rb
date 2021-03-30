Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  #articles routes
  resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  #users routes
  resources :users, except: [:new]

  get 'signup', to: 'users#new'


end
