class Api::V1::UsersController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods
    before_action :authenticate, except: [:create]

    def index
        users = User.eager_load(:active_relationships, :passive_relationships)
        follower_ids = users.where(passive_relationships: {followee_id: @auth_user.id}).pluck("passive_relationships.followee_id")
        followee_ids = users.where(active_relationships: {follower_id: @auth_user.id}).pluck("active_relationships.follower_id")
        tweet_counts = Tweet.group(:user_id).count

        view_models = users.map do |u|
            UserViewModel.new(u, follower_ids.include?(u.id), followee_ids.include?(u.id), u.followers.size, u.followees.size, u.tweets.size)
        end

        render json: UserViewModelResource.new(view_models)
    end

    def show
        my_id = @auth_user.id

        user_view_model = UserViewModel.new(
            user = User.find(params[:id]),
            follows_me = user.followee_ids.include?(my_id),
            followed_by_me = user.follower_ids.include?(my_id),
            follower_count = user.followers.count,
            followee_count = user.followees.count,
            tweet_count = user.tweets.count
        )

        if user
            render json: UserViewModelResource.new(user_view_model)
        else
            render json: user.errors
        end
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors
        end
    end

    def update
        @auth_user.update!(user_params)
        render json: @auth_user
    end

    def destroy
        @auth_user.destroy
        render json: @auth_user
    end

    private

    def user_params
        params.permit(:name, :email, :password)
    end

    def authenticate
        authenticate_or_request_with_http_token do |token, options|
            @auth_user = User.find_by(token: token)
            @auth_user != nil ? true : false
        end
    end
end