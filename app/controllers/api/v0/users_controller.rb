class Api::V0::UsersController < ApplicationController

  def destroy
    user = User.find(params[:id])
    render json: user.destroy, status: 204
  end

  def create
    user = User.create!(user_params)
    render json: UserSerializer.new(user), status: 201
  end

  private

  def user_params
    params.require(:user).permit(:name, :location, :email, :search_radius, :password)
  end

end