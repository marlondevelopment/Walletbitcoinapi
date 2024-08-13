class Api::V1::UsersController < ApplicationController
  def show
    response = Api::V1::Users::Detail.call(params)
    render json: response[:response], status: response[:status]
  end

  def update
    response = Api::V1::Users::Update.call(params[:id], user_params)
    render json: response[:response], status: response[:status]
  end

  def create
    response = Api::V1::Users::Create.call(params)
    render json: response[:response], status: response[:status]
  end

  def index
    response = Api::V1::Users::List.call(params)
    render json: response[:response], status: response[:status]
  end

  private
  def user_params
    params.require(:user).permit(:email, :password_digest, :first_name, :last_name, :nid, :balance)
  end
end
