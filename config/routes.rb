Rails.application.routes.draw do
  # Web Routes
  root 'pages#home'
  resources :rooms
  devise_for :users

  # API Routes
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth',
                                          controllers: {
                                            registrations: 'users/registrations'
                                          }
    end
  end
end
