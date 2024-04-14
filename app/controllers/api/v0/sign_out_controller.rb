class Api::V0::SignOutController < ApplicationController

  def sign_out
    if params[:user_id]
      UserTattoo.delete_disliked_tattoos(sign_out_params[:user_id])
      render status: 204
    elsif params[:artist_id]
      render status: 204
    else
      render status: 404
    end
  end

  private
  def sign_out_params
    params.permit(:user_id, :artist_id)
  end

end