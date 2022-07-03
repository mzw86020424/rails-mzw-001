class Api::V1::UsersController < ApplicationController
    before_action :set_user, except: [:create]

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors
        end
    end

    def update
        @user.update!(user_params)
        render json: @user
    end

    def destroy
        user = User.all.eager_load(tweets: :tweet_tags).find(@user.id)
        user.destroy
        render json: @user
    end

    def tweets
        render json: @user.tweets
    end

    def like_tweets
        render json: @user.like_tweets
    end

    def like_tweet_tags
        render json: @user.like_tweet_tags
    end

    def status_tweets
        render json: @user.status_tweets(params[:status])
    end

    private

    def set_user
        id = params[:user_id] || params[:id]
        @user = User.find(id)
    end

    def user_params
        params.permit(:name, :email)
    end
end