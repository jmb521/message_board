Rails.application.routes.draw do
  root 'application#home'
  resources :comments
  resources :profiles
  resources :posts do
    resources :comments, only: [:show, :index, :new, :edit]
  end

  get '/signup' => "users#new"
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get '/auth/facebook/callback' => 'sessions#omniauth_create'
  resources :users

  delete "/logout", to: "sessions#destroy"

  scope '/admin', module: 'admin' do
    resources :manage_users, only: [:index, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# get "/login", to: "sessions#login"
# post "/sessions/create", to: "sessions#create"

################################################
#see if you can fix why the login isn't using the session controller or if it is why
#it isn't logging in and redirecting to the posts_path
