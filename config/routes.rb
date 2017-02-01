Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :profiles
  resources :users
  root 'application#home'

  get '/signup', to: "users#create"
  get "/login", to: "sessions#login"
  post '/login' => 'sessions#create'
  post "/sessions/create", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
