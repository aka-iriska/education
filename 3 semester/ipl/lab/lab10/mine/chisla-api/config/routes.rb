Rails.application.routes.draw do
  get 'chisla_api/view'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'chisla_api#view'
end
