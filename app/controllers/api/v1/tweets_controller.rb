class Api::V1::TweetsController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate

    def index
        my_id = @auth_user.id
        tweets = Tweet.eager_load(:likes).order(id: :desc).limit(50) # ここではまだSQL発行されていない
        #自分がいいねしたツイートIDだけを取得する
        liked_tweets = Like.where(tweet_id: tweets, user_id: my_id).group_by(&:tweet_id) # tweet_idにtweetsを渡してもActiveRecordがidを拾ってくれる
        #カウントを取得する
        like_counts = Like.where(tweet_id: tweets).group(:tweet_id).count
        # alba用のクラスに置き換える
        view_models = tweets.map do |t|
            TweetViewModel.new(t, liked_tweets.has_key?(t.id), like_counts[t.id])
        end
        render json: TweetViewModelResource.new(view_models)
    end
    
    def show
        my_id = @auth_user.id
        tweet = Tweet.eager_load(:likes).find(params[:id])
        liked_by_me = Like.exists?(tweet_id: tweet.id, user_id: my_id)
        like_count = Like.where(tweet_id: tweet.id).count
        view_model = TweetViewModel.new(tweet, liked_by_me, like_count)
        render json: TweetViewModelResource.new(view_model)
    end

    def create
        user = User.find(params[:user_id])
        tweet = Tweet.new(tweet_params)
        if tweet.save
            render json: tweet
        else
            render json: tweet.errors
        end
    end

    def update
        tweet = Tweet.find(params[:id])
        if tweet.update(text: params[:text])
            render json: tweet
        else
            render json: tweet.errors
        end
    end

    def destroy
        tweet = Tweet.find(params[:id])
        if tweet.destroy
            render json: tweet
        else
            render json: tweet.errors
        end
    end
    
    def like_users
        render json: Tweet.find(params[:id]).like_users
    end

    def tags
        render json: Tweet.find(params[:id]).tags
    end

    private
    def tweet_params
        params.permit(:text, :user_id, :status)
    end

    def authenticate
        authenticate_or_request_with_http_token do |token, options|
            @auth_user = User.find_by(token: token)
            @auth_user != nil ? true : false
        end
    end
end
