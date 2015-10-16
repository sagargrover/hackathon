Mash::Application.routes.draw do

  root 'welcome#index'
  resources :seeds
  
    post 'user/create_user' => 'user#new_user'
    get 'user/get_handle' => 'user#get_handle'
    post "api/v1/seeds/nearby" => 'seeds#nearby'
    get 'user/myseeds/:user' => 'user#myseeds'
    get 'user/myplants/:user' => 'user#myplants'
    post 'tag/register_video' => 'tag#register_video'
end
