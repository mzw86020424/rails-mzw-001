class Api::V1::RelationshipsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  def create
    relationship = Relationship.new(follower_id: params[:user_id], followee_id: params[:followee_id])
    if relationship.save
      render json: relationship
    else
      render json: relationship.errors
    end
  end

  def destroy
    relationship = Relationship.find_by(follower_id: params[:user_id], followee_id: params[:followee_id])
    if relationship.destroy
      render json: relationship
    else
      render json: relationship.errors
    end
  end

  private

  def relationship_params
      params.permit(:user_id, :followee_id)
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
        @auth_user = User.find_by(token: token)
        @auth_user != nil ? true : false
    end
  end
end
