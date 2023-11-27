Rails.application.routes.draw do
  get 'calc/index'
  get 'calc/view'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'calc#index'
  # Defines the root path route ("/")
  # root "articles#index"
end
