Rails.application.routes.draw do
  # Web Routes
  root 'pages#home'

  resources :rooms do
    member do
      get :toggle_status
      get :claim
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  # API Routes
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
end
