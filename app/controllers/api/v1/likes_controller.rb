class Api::V1::LikesController < ApplicationController
    def create
        user = User.find(params[:user_id])
        tweet = Tweet.find(params[:tweet_id])
        like = Like.new(user_id: user.id, tweet_id: tweet.id)
        if like.save
            render json: {
                status: "SUCCESS",
                data: like
            }
        else
            render json: {
                status: "ERROR",
                data: like.errors
            }
        end
    end

    def destroy
        like = Like.find_by(user_id: params[:user_id], tweet_id: params[:tweet_id])
        if like.destroy
            render json: {
                status: "SUCCESS",
                data: like
            }
        else
            render json: {
                status: "ERROR",
                data: like.errors
            }
        end
    end
    
end