class Api::V0::ArtistIdentitiesController < ApplicationController

  def create
    artist_identity = ArtistIdentity.create!(artist_identity_params)
    render json: {message: "Identity successfully added to Artist"}
  end

  def destroy
    artist_identity = ArtistIdentity.find_by(artist_identity_params)
    if artist_identity 
      artist_identity.delete
    else 
      render json: {message: "Association between Identity and Artist does not exist"}, status: 404
    end 
  end

  private

  def artist_identity_params
    params.require(:artist_identity).permit(:artist_id, :identity_id)
  end
end