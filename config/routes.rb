Rails.application.routes.draw do
  root 'application#home'
  resources :users do
  collection do
    get 'user_status'
  end
end

  namespace :admin do
    resources :manage_users, only: [:show, :index, :new, :edit, :destroy]
  end
  patch '/admin/manage_users/:id/edit' => "admin/manage_users#update"
  resources :comments
  resources :profiles do
    resources :addresses
  end
  resources :addresses, only: [:show, :index, :new, :edit, :create, :update]
  resources :posts do
    resources :comments
  end

  get '/signup' => "users#new"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get '/auth/facebook/callback' => 'sessions#omniauth_create'
  resources :users

  delete "/logout", to: "sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# get "/login", to: "sessions#login"
# post "/sessions/create", to: "sessions#create"

################################################
#see if you can fix why the login isn't using the session controller or if it is why
#it isn't logging in and redirecting to the posts_path
