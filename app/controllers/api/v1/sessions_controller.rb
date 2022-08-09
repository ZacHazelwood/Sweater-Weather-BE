class Api::V1::SessionsController < ApplicationController
  before_action :check_fields

  def create
    current_user = User.find_by(email: session_params[:email])
    if current_user
      user = current_user.authenticate(session_params[:password])
      if user
        render json: UserSerializer.new(user), status: 200
      else
        render json: { error: 'Invalid credentials' }, status: 401
      end
    else
      render json: { error: 'Invalid credentials' }, status: 401
    end
  end

  private
    def session_params
      params.permit(:email, :password)
    end

    def check_fields
      if session_params[:email] == "" || session_params[:password] == ""
        render json: { error: "Missing field" }, status: 401
      end
    end
end
