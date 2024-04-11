class Api::V0::ArtistIdentitiesController < ApplicationController

  def create
    artist_identity = ArtistIdentity.create!(artist_identity_params)
    render json: {message: "Identity successfully added to Artist"}
  end

  private

  def artist_identity_params
    params.require(:artist_identity).permit(:artist_id, :identity_id)
  end
end