class Api::V1::TweetsController < ApplicationController
    before_action :set_tweet, only: [:update, :destroy, :like_users, :tags, :likes, :show]

    def index
        user_id = 1 # 仮のauth_user

        tweets = Tweet.eager_load(:likes).order(id: :desc).each do |tweet|
            tweet.liked_by_me = tweet.likes { |like| like.user_id == user_id}.count > 0
            tweet.like_count = tweet.likes.count
        end
        render json: tweets
    end

    def show
        tweet = Tweet.eager_load(:likes).find(@tweet.id)
        tweet.liked_by_me = tweet.likes { |like| like.user_id == user_id}.count > 0
        tweet.like_count = tweet.likes.count
        render json: tweet
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
        if @tweet.update(text: params[:text])
            render json: @tweet
        else
            render json: @tweet.errors
        end
    end

    def destroy
        @tweet.destroy
        render json: "tweet id:#{@tweet.id} is deleted"
    end
    
    def like_users
        render json: @tweet.like_users
    end

    def tags
        render json: @tweet.tags
    end

    private

    def set_tweet
        id = params[:tweet_id] || params[:id]
        @tweet = Tweet.find(id)
    end

    def tweet_params
        params.permit(:text, :user_id, :status)
    end
end
