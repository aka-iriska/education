Rails.application.routes.draw do
  resources :chisla_results
  get 'show_all', to: 'chisla_results#show_all'
  get 'chisla/input'
  get 'chisla/view'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'chisla#input'
  # Defines the root path route ("/")
  # root "articles#index"
end
