CvBuilder::Application.routes.draw do

  root :to => 'home#index'

  devise_for :users , :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
#    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/user/auth:github'     => 'user/omniauth_callbacks#github'
  end

  
  match '/dashboard'          =>              'users/dashboard#index' , :method=>:get , :as => :dashboard


  match '/linkedin/auth'   => 'linkedin_user#auth'
  match '/linkedin/import' => 'linkedin_user#callback'

  match '/github/authorize'   => 'github_login#authorize'
  match '/github/callback'   => 'github_login#callback'
 
  match '/user/basic_info/edit'               =>              'users/basic_info#edit'    , :method=>:get  , :as => :edit_basic_info
  match '/user/basic_info/update'             =>              'users/basic_info#update'  , :method=>:get  , :as => :update_basic_info
  match '/user/basic_info/create'                 =>              'users/basic_info#create'  , :method=>:post , :as => :create_basic_info
  
end
