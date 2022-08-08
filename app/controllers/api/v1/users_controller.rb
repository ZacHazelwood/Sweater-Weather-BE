class Api::V1::UsersController < ApplicationController
  before_action :check_passwords, :check_email

  def create
    new_user = User.new(user_params)
    new_user[:api_key] = SecureRandom.hex
    if new_user.save
      render json: UserSerializer.new(new_user), status: 201
    else
      render json: { error: 'Email is unavailable' }, status: 401
    end
  end

  private

    def user_params
      params.permit(:email, :password, :password_confirmation)
    end

    def check_passwords
      if user_params[:password] == "" || user_params[:password_confirmation] == ""
        render json: { error: "Missing Field" }, status: 401
      elsif user_params[:password] != user_params[:password_confirmation]
        render json: { error: "Passwords must match" }, status: 401
      end
    end

    def check_email
      if user_params[:email] == ""
        render json: { error: 'Missing Field'}, status: 401
      end
    end
end
