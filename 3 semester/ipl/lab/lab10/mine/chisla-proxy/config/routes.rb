Rails.application.routes.draw do
  get 'chisla_proxy/input'
  get 'chisla_proxy/view'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'chisla_proxy#input'
  # Defines the root path route ("/")
  # root "articles#index"
end
