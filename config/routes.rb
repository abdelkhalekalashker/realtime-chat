Rails.application.routes.draw do
  
  get 'users/show'
  get 'search'  , to: "search#index"
  get 'messages/create'

  root 'rooms#index'
  resources :rooms
  devise_for :users
  resources :rooms do
    resources :messages
    collection do
      post :search
    end
  end
  delete 'rooms/leave/:id', to: 'rooms#leave', as: 'leave_room'
 post 'rooms/join/:id', to: 'rooms#join', as: 'join_room'
  resources :users
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
