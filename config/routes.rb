Rails.application.routes.draw do
  get '/signup', to: "users#new"
  get "/login", to: "sessions#login"
  post '/signin' => 'sessions#create'
  delete "/logout", to: "sessions#destroy"
  resources :posts do
    resources :comments
  end
  resources :comments
  # delete "/delete_comment", to: "comments#destroy"


  resources :profiles
  resources :users do
    resources :posts
  end
  # get 'posts/:id/comments', to: 'posts#comments_index'
  # get 'posts/:id/comments/:comment_id', to: 'posts#comment'
  # post '/posts/:post_id/comments/new', to: 'comments#create'
  # get '/posts/:post_id/comments/:id/edit', to: 'comments#edit'
  root 'posts#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
