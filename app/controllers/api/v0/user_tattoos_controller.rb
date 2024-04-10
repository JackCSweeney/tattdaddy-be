class Api::V0::UserTattoosController < ApplicationController

  def index
    tattoos = User.find(params[:user_id]).find_user_tatts
    render json: TattoosSerializer.new(tattoos)
  end

end