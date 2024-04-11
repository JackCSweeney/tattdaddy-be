class Api::V0::UserIdentitiesController < ApplicationController

  def create
    user_identity = UserIdentity.create!(user_identity_params)
    render json: {:message => "Identity successfully added to User"}
  end


  private
  def user_identity_params
    params.require(:user_identity).permit(:user_id, :identity_id)
  end
end