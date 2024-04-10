class Api::V0::ArtistsController < ApplicationController
  def show 
    artist = Artist.find(params[:id])
    render json: ArtistSerializer.new(artist)
  end
end