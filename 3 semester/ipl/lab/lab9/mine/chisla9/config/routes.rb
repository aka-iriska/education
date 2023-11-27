Rails.application.routes.draw do
  get 'chisla/input'
  get 'chisla/view'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'chisla#input'
end
