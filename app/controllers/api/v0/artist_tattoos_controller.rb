class Api::V0::ArtistTattoosController < ApplicationController

  def index 
    tattoos = Artist.find(params[:artist_id]).all_artist_tatts
    render json: TattoosSerializer.new(tattoos)
  end
end