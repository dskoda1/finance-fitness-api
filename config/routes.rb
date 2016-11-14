Rails.application.routes.draw do
  get 'users/me'

  resources :purchases
  resources :categories
  post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'registration#register'
end
