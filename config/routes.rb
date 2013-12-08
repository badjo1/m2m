M2m::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  # You can have the root of your site routed with "root"
  root 'static_pages#home'
  match '/help',  to: 'static_pages#help', via: 'get'

  match '/signup',  to: 'users#new', via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  
end
