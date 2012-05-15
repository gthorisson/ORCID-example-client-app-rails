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

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => { :registrations => 'registrations' }

  devise_scope :user do
    match 'users/register_orcid' => 'registrations#register_orcid'
  end

  resources :manuscripts
  resources :authentications
    
  get "home/index"
  root :to => "home#index"

end
