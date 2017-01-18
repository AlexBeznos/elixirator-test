Rails.application.routes.draw do
  root to: 'products#index'

  resources :users, only: [:show]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :products, only: [] do
    delete 'archivate' => 'product_archivates#destroy'
  end

  get  'login'  => 'user_sessions#new',     :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
end
