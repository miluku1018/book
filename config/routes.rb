Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :show] do
    member do
      post :comment  #POST /books/:id/comment, to: 'books#comment' 不用做一個comment controller
    end
  end

  root 'books#index'
  resources :publishers, only: [:show]
  resources :comments, only: [:create]
  
  namespace :admin do
    root 'books#index'
    resources :books
    resources :publishers, except: [:show]
  end
end
