Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  # Web Routes
  root 'pages#home'

  resources :rooms do
    member do
      get  :toggle_status
      get  :claim
      post :authenticate
    end
  end

  post '/sessions', to: 'sessions#create'
  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
      only: %i[new create edit update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end

  mount ActionCable.server, at: '/cable'

  # API Routes
  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end
  end
end
