Rails.application.routes.draw do
  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books, only: [:index, :show] do
    member do
      post :comment  #POST /books/:id/comment, to: 'books#comment' 不用做一個comment controller
    end
  end

  resources :publishers, only: [:show]
  resources :categories, only: [:show]

  root 'books#index'
  
  namespace :api do
    resources :books, only: [] do
      member do
        post :favorite  #api/books/:id/favorite
      end
    end
  end

  namespace :admin do
    root 'books#index'
    resources :books
    resources :publishers, except: [:show]
    resources :categories, except: [:show]
  end
end
