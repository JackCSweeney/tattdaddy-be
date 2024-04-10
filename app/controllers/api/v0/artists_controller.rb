class Api::V0::ArtistsController < ApplicationController
  def show 
    artist = Artist.find(params[:id])
    render json: ArtistSerializer.new(artist)
  end

  def create
    artist = Artist.create!(artist_params)
    render json: ArtistSerializer.new(artist), status: :created
  end

  private 

  def artist_params
    params.require(:artist).permit(:name, :location, :email, :password)
  end
end