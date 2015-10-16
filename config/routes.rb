Mash::Application.routes.draw do

  # You can have the root of your site routed with "root"
   root 'welcome#index'

  # Example of regular route:
     post 'user/create_user' => 'user#new_user'
  
  resources :seeds

      post "api/v1/seeds/nearby" => 'seeds#nearby'
end
