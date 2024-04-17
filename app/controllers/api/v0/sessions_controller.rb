class Api::V0::SessionsController < ApplicationController

  def create 
    jwt_token = GithubFacade.authenticate(params[:code])
    redirect_to "http://localhost:5000/auth/github/callback?token=#{jwt_token}"
  end

  private

  def user_params
    params.require(:user).permit(:name, :location, :email, :search_radius, :password)
  end
end 