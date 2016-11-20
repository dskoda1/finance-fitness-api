Rails.application.routes.draw do
  resources :purchase_names
  get 'users/me'

  resources :purchases
  resources :categories
  post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'registration#register'
end
