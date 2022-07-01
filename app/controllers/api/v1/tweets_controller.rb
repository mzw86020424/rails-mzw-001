class Api::V1::TweetsController < ApplicationController
    before_action :set_tweet, only: [:like_users, :tags]

    def index
        render json: Tweet.all
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

    def like_users
        render json: @tweet.like_users
    end

    def tags
        render json: @tweet.tags
    end

    private

    def set_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end

    def tweet_params
        params.permit(:text, :user_id, :status)
    end
end
