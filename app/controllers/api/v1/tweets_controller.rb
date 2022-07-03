class Api::V1::TweetsController < ApplicationController
    before_action :set_tweet, only: [:update, :destroy, :like_users, :tags, :likes]

    def index
        # like数を数えたものを追加
        render json: Tweet.joins(:likes).select('tweets.id, tweets.user_id, text, count(likes.id) AS like_count').group("tweets.id")
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
        @tweet.update(text: params[:text])
        render json: @tweet
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
