class Api::V0::UsersController < ApplicationController

  def destroy
    render json: User.delete(params[:id]), status: 204
  end

end