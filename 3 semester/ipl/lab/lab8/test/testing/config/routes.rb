Rails.application.routes.draw do
  get 'calc/input'
  get 'calc/view'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
