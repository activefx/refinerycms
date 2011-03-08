::Refinery::Application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  #, :controllers => {
#    :confirmations => "users/confirmations",
#    :omniauth_callbacks => "users/omniauth_callbacks",
#    :passwords => "users/passwords",
#    :registrations => "users/registrations",
#    :sessions => "users/sessions",
#    :unlocks => "users/unlocks"
#  }



  # Add Devise necessary routes.
  # For Devise routes, see: https://github.com/plataformatec/devise
  #namespace :refinery do
    devise_for :administrators, :path => :ctrlpnl, :controllers => {
      :sessions => 'administrator_sessions',
      :registrations => 'administrator_registrations',
      :passwords => 'administrator_passwords'
    }, :path_names => {
      :sign_out => 'logout',
      :sign_in => 'login',
      :sign_up => 'register'
    }
  #end



  # Override Devise's default after login redirection route.  This will pushed a logged in user to the dashboard.
  get 'refinery', :to => 'admin/dashboard#index', :as => :refinery_root
  get 'refinery', :to => 'admin/dashboard#index', :as => :administrator_root

  get '/home', :to => 'pages#home', :as => :user_root

  # Override Devise's other routes for convenience methods.
  #get 'refinery/login', :to => "sessions#new", :as => :new_user_session
  #get 'refinery/login', :to => "sessions#new", :as => :refinery_login
  #get 'refinery/logout', :to => "sessions#destroy", :as => :destroy_user_session
  #get 'refinery/logout', :to => "sessions#destroy", :as => :logout

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :administrators do
      resource :token_authentications, :controller => 'token_authentications'
      resource :rememberables, :controller => 'rememberables'
      resource :recoverables, :controller => 'recoverables'
      resource :confirmables, :controller => 'confirmables'
      resource :lockables, :controller => 'lockables'
    end
    resources :users do
      resource :token_authentications, :controller => 'token_authentications'
      resource :rememberables, :controller => 'rememberables'
      resource :recoverables, :controller => 'recoverables'
      resource :confirmables, :controller => 'confirmables'
      resource :lockables, :controller => 'lockables'
    end
  end

end

