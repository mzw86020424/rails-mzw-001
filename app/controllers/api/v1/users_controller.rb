class Api::V1::UsersController < ApplicationController
    def create
        user = User.new(name: params[:name], email: params[:email])
        if user.save
            render json: {
                status: "SUCCESS",
                data: user
            }
        else
            render json: {
                status: "ERROR",
                data: user.error
            }
        end
    end

    def like_tweets
        user = User.find(params[:user_id])
        render json: {
            status:'SUCCESS',
            data: user.like_tweets
        }
    end
    
end
