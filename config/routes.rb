Rails.application.routes.draw do
  get '/signup', to: "users#new"
  get "/login", to: "sessions#login"
  post '/login' => 'sessions#create'

  delete "/logout", to: "sessions#destroy"
  resources :posts do
    resources :comments, only: [:show, :index, :new]
  end
  resources :comments
  # delete "/delete_comment", to: "comments#destroy"


  resources :profiles
  resources :users do
    resources :posts
  end
  root 'posts#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
