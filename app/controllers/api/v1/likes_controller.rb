class Api::V1::LikesController < ApplicationController
    def create
        tweet = Tweet.find(params[:tweet_id])
        like = tweet.likes.new(user_id: params[:user_id], tweet_id: tweet.id)
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

    def show
        likes = Like.where(tweet_id: params[:tweet_id])
        render json: likes
    end

    def destroy
        like = Like.find_by_user_id_and_tweet_id(params[:user_id], params[:tweet_id])
        # like = Like.find_by(user_id: params[:user_id], tweet_id: params[:tweet_id])

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

    private

    def like_params
        params.permit(:user_id, :tweet_id)
    end
end