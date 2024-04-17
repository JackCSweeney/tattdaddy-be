class Api::V0::UsersController < ApplicationController

  def destroy
    user = User.find(params[:id])
    render json: user.destroy, status: 204
  end

  def create
    user = User.create!(user_params)
    render json: UserSerializer.new(user), status: 201
  end

  def update
    user = User.find(params[:id])
    user.email = params[:user][:email] if params[:user][:email]
    user.name = params[:user][:name] if params[:user][:name]
    user.location = params[:user][:location] if params[:user][:location]
    user.search_radius = params[:user][:search_radius] if params[:user][:search_radius]
    user.save!(validate: false)
    render json: UserSerializer.new(user), status: 201 
  end

  def show
    user = User.find(params[:id])
    render json: UserSerializer.new(user), status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :location, :email, :search_radius, :password)
  end

end