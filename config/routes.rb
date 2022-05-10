Rails.application.routes.draw do
  get 'rooms' , to: 'rooms#index'
  devise_for :users
  root 'rooms#index'
  resources :users
  resources :rooms
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
