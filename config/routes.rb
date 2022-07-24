Rails.application.routes.draw do
  # get 'login/login'
  namespace :api do
    namespace :v1 do
      post 'login/login'
      resources :users, only: [:create, :index, :update, :destroy] do
        resource :relationships, only: [:create, :destroy]
        get :follows, on: :member
        get :followers, on: :member
      end
      resources :tweets do
        resource :likes, only: [:create, :show, :destroy]
      end
      resources :tags, only: [:index, :create] do
        resource :tweet_tags, only: [:create, :destroy]
      end
    end
  end
end
