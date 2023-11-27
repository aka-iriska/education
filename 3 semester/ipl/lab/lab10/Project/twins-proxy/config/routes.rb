Rails.application.routes.draw do
  get 'twins_proxy/input'
  get 'twins_proxy/view'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'twins_proxy#input'
end
