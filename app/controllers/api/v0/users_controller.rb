class Api::V0::UsersController < ApplicationController

  def destroy
    user = User.find(params[:id])
    render json: user.destroy, status: 204
  end

end