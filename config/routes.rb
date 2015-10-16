Mash::Application.routes.draw do

  root 'welcome#index'
  resources :seeds
  
  post 'tag/register_video' => 'tag#register_video'

  post 'user/create_user' => 'user#new_user'
  get 'user/seeds/:user_id' => 'user#myseeds'
  get 'user/plants/:user_id' => 'user#myplants'
  get 'user/get_handle' => 'user#get_handle'

  put 'user/:user_id/saw/:seed_id' => 'seen#create'

  post 'api/v1/seeds/nearby' => 'seeds#nearby'
  get 'api/v1/user/suggest' => 'user#suggest'
end
