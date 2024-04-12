class Api::V0::IdentitiesController < ApplicationController

  def index
    identities = Identity.all
    render json: IdentitiesSerializer.new(identities)
  end

end