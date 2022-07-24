class Api::V1::UsersController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate, except: [:create]
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

    private

    def user_params
        params.permit(:name, :email, :password)
    end

    def authenticate
        authenticate_or_request_with_http_token do |token, options|
            auth_user = User.find_by(token: token)
            auth_user != nil ? true : false
        end
    end
end