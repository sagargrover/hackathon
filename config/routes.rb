Mash::Application.routes.draw do

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  resources :seeds
  
    post 'user/create_user' => 'user#new_user'
    get 'user/get_handle' => 'user#get_handle'
    post "api/v1/seeds/nearby" => 'seeds#nearby'
end
