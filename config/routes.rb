Mash::Application.routes.draw do

  root 'welcome#index'
  resources :seeds
  
  post 'seed/register' => 'seeds#register'

  post 'user/create_user' => 'user#new_user'
  get 'user/seeds/:user_id' => 'user#myseeds'
  get 'user/plants/:user_id' => 'user#myplants'
  get 'user/get_handle' => 'user#get_handle'

  get 'user/:user_id/saw/:seed_id' => 'seen#create'
  get 'seed/:seed_id/like' => 'seeds#like'
  get 'seed/:seed_id/dislike' => 'seeds#dislike'

  get 'user/look/down' => 'user#lookdown'

  post 'seed/nearby' => 'seeds#nearby'
  get 'user/suggest' => 'user#suggest'
end
