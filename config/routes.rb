Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        get 'tweets'
        get 'like_tweets'
        get 'like_tweet_tags'
        # 明示してルーティングできるし、明示しないと自動でルーティング作られる。パラメータも明示可能
        get 'status_tweets/:status', to: 'users#status_tweets'
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
