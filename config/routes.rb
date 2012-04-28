JOPMTS::Application.routes.draw do
  
  get 'account'         => 'users#show'
  get 'account/edit'    => 'users#edit'
  #resources :profiles
  get    'profile'      => 'profiles#show'
  get    'profile/new'  => 'profiles#new',     :as => "new_profile"
  post   'profile'      => 'profiles#create'
  get    'profile/edit' => 'profiles#edit',    :as => "edit_profile"
  put    'profile'      => 'profiles#update',  :as => "update_profile"
  delete 'profile'      => 'profiles#destroy', :as => "delete_profile"

  get 'cid/:cid'        => 'profiles#show_cidprofile_publiconly'
  get 'cid/:cid/full'   => 'profiles#show_cidprofile_full'

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => { :registrations => 'registrations' }

  devise_scope :user do
    match 'users/register_orcid' => 'registrations#register_orcid'
  end

  resources :manuscripts
  resources :authentications
  
  resources :oauth_clients  
  match '/oauth/test_request',  :to => 'oauth#test_request',  :as => :test_request
  match '/oauth/token',         :to => 'oauth#token',         :as => :token
  match '/oauth/access_token',  :to => 'oauth#access_token',  :as => :access_token
  match '/oauth/request_token', :to => 'oauth#request_token', :as => :request_token
  match '/oauth/authorize',     :to => 'oauth#authorize',     :as => :authorize
  match '/oauth/revoke',        :to => 'oauth#revoke',        :as => :revoke
  match '/oauth',               :to => 'oauth#index',         :as => :oauth
  
  get "home/index"
  root :to => "home#index"

end
