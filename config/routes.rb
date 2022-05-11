Rails.application.routes.draw do
  
  get 'search'  , to: "search#index"
  get 'messages/create'
  
  root 'rooms#index'
  resources :rooms
  devise_for :users
  resources :rooms do
    resources :messages
  end
  resources :users
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
