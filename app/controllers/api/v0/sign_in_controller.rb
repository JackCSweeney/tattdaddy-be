class Api::V0::SignInController < ApplicationController

  def verify_sign_in
    if sign_in_params[:type].include?("User")
      login = User.find_by(email: sign_in_params[:email])
    else
      login = Artist.find_by(email: sign_in_params[:email])
    end

    if login.authenticate(sign_in_params[:password])
      render json: {data: {id: login.id, type: login.class.to_s.downcase}}
    else
      render json: {error: "Invalid Parameters for Sign In"}, status: 422
    end
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:email, :password, :type)
  end

end