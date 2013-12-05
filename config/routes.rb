M2m::Application.routes.draw do
  get "users/new"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'
  
  match '/signup',  to: 'users#new', via: 'get'
  match '/help',  to: 'static_pages#help', via: 'get'

  resources :users
end
