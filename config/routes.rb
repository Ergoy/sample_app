Rails.application.routes.draw do
  get 'users/new'
  root             'static_pages#home'
  get 'help',to: 'static_pages#help'
  get 'about',to: 'static_pages#about'
  get 'contact',to: 'static_pages#contact'
  get 'signup',to: 'users#new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  get 'logout',  to: 'sessions#destroy'
  resources :users
  # get 'static_pages/help'
  # get 'static_pages/about'
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'static_pages/home'
  # get  'static_pages/contact'
  # # Defines the root path route ("/")
  # root 'static_pages#home'
end
