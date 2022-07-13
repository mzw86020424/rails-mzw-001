class Api::V1::TweetsController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate
    before_action :set_tweet, only: [:update, :destroy, :like_users, :tags, :likes, :show]

    def index
        my_id = @auth_user.id
        render json: Tweet.tweets_with_my_like(my_id)
    end

    def show
        my_id = @auth_user.id
        render json: Tweet.tweet_with_my_like(my_id)
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

    def authenticate
        authenticate_or_request_with_http_token do |token, options|
            @auth_user = User.find_by(token: token)
            @auth_user != nil ? true : false
        end
    end
end
