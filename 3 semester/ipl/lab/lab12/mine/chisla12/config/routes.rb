Rails.application.routes.draw do
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  #get '/input',  :to => 'chisla#input'
  #get '/view',  :to => 'chisla#view'
  match '/input', to: 'chisla#input', via: 'get'
  match '/view', to: 'chisla#view', via: 'get'
  root 'chisla#input'
  get 'show_all', to: 'users#show_all'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
