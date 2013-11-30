Easytowticket::Application.routes.draw do
  devise_for :admins, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks",
    registrations: 'admins/registrations',
    :sessions => "admins/sessions",
    :passwords => 'admins/passwords',
    :confirmations => 'admins/confirmations'
  }

  authenticate :admin do
    namespace :admins do
      resources :admins
      resources :profile, :only => [:edit, :update]
      resources :tickets
      resources :profile, :only => [:edit, :update]
      get '/dashboard' => 'dashboards#index', as: :dashboard
      get '/' => 'dashboards#index'
    end
  end

  root 'pages#index'
end
