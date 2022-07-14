class Api::V1::TweetsController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate

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
