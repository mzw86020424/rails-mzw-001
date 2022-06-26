class Api::V1::TweetsController < ApplicationController
    def index
        render json: {
            status: "SUCCESS",
            data: Tweet.all
        }
    end

    def create
        user = User.find(params[:user_id])
        tweet = Tweet.new(text: params[:text], user_id: user.id)
        if tweet.save
            render json: {
                status: "SUCCESS",
                data: tweet
            }
        else
            render json: {
                status: "ERROR",
                data: tweet.error
            }
        end
    end

    def like_users
        tweet = Tweet.find(params[:tweet_id])
        render json: {
            status: 'SUCCESS',
            data: tweet.like_users
        }
    end

    def tags
        tweet = Tweet.find(params[:tweet_id])
        render json: {
            status: 'SUCCESS',
            data: tweet.tags
        }
    end
    
end
