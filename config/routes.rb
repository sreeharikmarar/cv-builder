CvBuilder::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users , :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
#    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/user/auth:github'     => 'user/omniauth_callbacks#github'
  end

  
  match '/dashboard'          =>              'users/dashboard#index' , :method=>:get , :as => :dashboard


  match '/linkedin/auth'      => 'linkedin_user#auth'
  match '/linkedin/callback'  => 'linkedin_user#callback'

  match '/github/authorize'   => 'github_login#authorize'
  match '/github/callback'    => 'github_login#callback'
 
  match '/user/basic_info/edit'                 =>              'users/basic_info#edit'    , :method=>:get  , :as => :edit_basic_info
  match '/user/basic_info/update'               =>              'users/basic_info#update'  , :method=>:get  , :as => :update_basic_info
  match '/user/basic_info/create'               =>              'users/basic_info#create'  , :method=>:post , :as => :create_basic_info
  
  match '/user/position/new'                    =>              'users/position#new'    , :method=>:get  , :as => :new_position
  match '/user/position/:id/edit'               =>              'users/position#edit'    , :method=>:get  , :as => :edit_position
  match '/user/position/:id/update'             =>              'users/position#update'  , :method=>:get  , :as => :update_position
  match '/user/position/:id/delete'             =>              'users/position#delete'  , :method=>:get  , :as => :delete_position
  match '/user/position/create'                 =>              'users/position#create'  , :method=>:post , :as => :create_position
  
end
