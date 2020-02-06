Rails.application.routes.draw do
  root to: 'contacts#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resource :user
  resources :contacts
  resources :messages, only: [:show, :create]
end
