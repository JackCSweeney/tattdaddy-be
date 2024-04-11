class Api::V0::SignInController < ApplicationController

  def verfy_sign_in
    if sign_in_params[:type].include?("User")
      user = User.find_by(email: sign_in_params[:email])
      if user.authenticate(sign_in_params[:password])
        render json: {data: {id: user.id, type: "user"}}
      else
        render json: {error: "Invalid Parameters for Sign In"}, status: 422
      end
    else
      artist = Artist.find_by(email: sign_in_params[:email])
      if artist.authenticate(sign_in_params[:password])
        render json: {data: {id: artist.id, type: "artist"}}
      else
        render json: {error: "Invalid Parameters for Sign In"}, status: 422
      end
    end
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password, :type)
  end

end