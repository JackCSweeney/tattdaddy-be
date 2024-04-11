class Api::V0::UserIdentitiesController < ApplicationController

  def create
    user_identity = UserIdentity.create!(user_identity_params)
    render json: {:message => "Identity successfully added to User"}
  end

  def destroy
    user_identity = UserIdentity.find_by(user_identity_params)
    if user_identity
      user_identity.delete
    else
      render json: {message: "Association between Identity and User does not exist"}, status: 404
    end
  end


  private
  def user_identity_params
    params.require(:user_identity).permit(:user_id, :identity_id)
  end
end