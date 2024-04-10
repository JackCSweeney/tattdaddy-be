class Api::V0::UserTattoosController < ApplicationController

  def index
    tattoos = User.find(params[:user_id]).find_user_tatts
    render json: TattoosSerializer.new(tattoos)
  end

  def create 
    user_tattoo = UserTattoo.create!(user_tattoo_params)
    render json: {message: "Tattoo successfully added to User"}
  end

  private 

  def user_tattoo_params
    params.require(:user_tattoo).permit(:user_id, :tattoo_id)
  end
end