Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    resources :people_finds
    resources :users
    resources :sessions

    get 'avoidant/index'
    get 'avoidant/people'
    get 'avoidant/home'
    get 'avoidant/filter' # need for filter
    get 'avoidant/load_more' # кнопка для добавления еще 10 записей из бд на старицу
    get 'avoidant/reset_filter'

    match '/index', to: 'avoidant#index', via: 'get'
    match '/people', to: 'avoidant#people', via: 'get'
    match '/home', to: 'avoidant#home', via: 'get'

    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    match '/signout', to: 'sessions#destroy', via: 'delete'

    match '/create_post', to: 'people_finds#new', via: 'get'

    match 'update_people', to: 'avoidant#update_people', via: 'get'

    # Корневой путь
    root 'avoidant#index'
  end
end
