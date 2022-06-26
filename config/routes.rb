Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        get 'like_tweets'
      end
      resources :tweets do
        get 'like_users'
        get 'tags'
        resource :likes
      end
      resources :tags do
        get 'tagged_tweets'
        resource :tweet_tags
      end
    end
  end
end
