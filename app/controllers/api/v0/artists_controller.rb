class Api::V0::ArtistsController < ApplicationController

  def index 
    artists = Artist.all
    render json: ArtistSerializer.new(artists)
  end
  
  def show 
    artist = Artist.find(params[:id])
    render json: ArtistSerializer.new(artist)
  end

  def create
    artist = Artist.create!(artist_params)
    render json: ArtistSerializer.new(artist), status: :created
  end

  def update 
    artist = Artist.find(params[:id])
    artist.update!(artist_params)
    render json: ArtistSerializer.new(artist)
  end

  def destroy
    artist = Artist.find(params[:id])
    render json: artist.destroy, status: 204
  end

  private 

  def artist_params
    params.require(:artist).permit(:name, :location, :email, :password)
  end
end