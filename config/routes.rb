Refinery::Application.routes.draw do

  get '/home', :to => 'pages#home', :as => :user_root

end

