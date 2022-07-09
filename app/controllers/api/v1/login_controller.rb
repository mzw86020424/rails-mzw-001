class Api::V1::LoginController < ApplicationController
  def login
    login_user = User.find_by(email: params[:email], password: params[:password])
    if login_user
      render json: {token: login_user.token, id: login_user.id}
    else
      render json: "error"
    end
  end
end
