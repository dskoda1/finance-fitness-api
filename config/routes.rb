Rails.application.routes.draw do
  resources :purchases
  resources :categories
  post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'registration#register'
end
