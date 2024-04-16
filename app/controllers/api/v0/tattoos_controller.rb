class Api::V0::TattoosController < ApplicationController

  def show
    tattoo = Tattoo.find(params[:id])
    render json: TattoosSerializer.new(tattoo)
  end

  def create
    tattoo = Tattoo.new(tattoo_params)
    if tattoo.save 
      render json: TattoosSerializer.new(tattoo)
    else
      render json: {error: "Tattoo could not be uploaded"}, status: 422
    end
  end

  def update
    tattoo = Tattoo.find(params[:id])
    tattoo.update!(tattoo_params)
    render json: TattoosSerializer.new(tattoo)
  end

  def destroy
    tattoo = Tattoo.find(params[:id])
    render json: tattoo.destroy, status: 204
  end

  private

  def tattoo_params
    params.require(:tattoo).permit(:artist_id, :image_url, :price, :time_estimate)
  end
end