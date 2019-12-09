Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :show]
  root 'books#index'

  namespace :admin do
    root 'books#index'
    resources :books
    resources :publishers, except: [:show]
  end
end
