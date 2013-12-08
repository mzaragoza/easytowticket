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

  resources :comments
  resources :leads, :only => [:new, :create]
  post '/sign_up' => 'pages#sign_up', :as => :sign_up
  match '/contact_us' => 'leads#new', :as => :contact_us, via: :all
  match '/thanks' => 'leads#thanks', :as => :thanks, via: :all
  match "/prices" => "pages#prices", :as => :prices, via: :all
  match "/about_us" => "pages#about_us", :as => :about_us, via: :all
  match "/test" => "pages#test", :as => :test, via: :all
  root 'pages#index'
end
