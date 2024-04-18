class Api::V0::UserTattoosController < ApplicationController

  def index
    tattoos = User.find(params[:user_id]).find_user_tatts
    render json: TattoosSerializer.new(tattoos)
  end

  def create 
    if params[:type] == "like"
      user_tattoo = UserTattoo.create!(user_tattoo_params.merge(status: "liked"))
    else
      user_tattoo = UserTattoo.create!(user_tattoo_params.merge(status: "disliked"))
    end
    render json: {message: "Tattoo successfully added to User"}
  end

  def destroy
    user_tattoo = UserTattoo.find_by(user_tattoo_params)
    if user_tattoo 
      user_tattoo.delete
    else 
      render json: {message: "Association between Tattoo and User does not exist"}, status: 404
    end 
  end

  private 

  def user_tattoo_params
    params.permit(:user_id, :tattoo_id)
  end
end