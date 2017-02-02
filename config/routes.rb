Rails.application.routes.draw do
  get '/signup', to: "users#new"
  get "/login", to: "sessions#login"
  post '/signin' => 'sessions#create'


  delete "/logout", to: "sessions#destroy"
  resources :comments
  resources :posts
  resources :profiles
  resources :users
  root 'application#home'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
