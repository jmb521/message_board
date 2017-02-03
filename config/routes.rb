Rails.application.routes.draw do
  get '/signup', to: "users#new"
  get "/login", to: "sessions#login"
  post '/signin' => 'sessions#create'


  delete "/logout", to: "sessions#destroy"
  resources :posts do
    resources :comments
  end
  resources :profiles
  resources :users do
    resources :posts
  end
  get 'posts/:id/comments', to: 'posts#comments_index'
  get 'posts/:id/comments/:comment_id', to: 'posts#comment'
  post '/posts/:post_id/comments/new', to: 'comments#create'
  root 'application#home'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
