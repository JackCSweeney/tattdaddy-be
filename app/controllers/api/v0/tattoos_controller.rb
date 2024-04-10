class Api::V0::TattoosController < ApplicationController

  def show
    tattoo = Tattoo.find(params[:id])
    render json: TattoosSerializer.new(tattoo)
  end

end