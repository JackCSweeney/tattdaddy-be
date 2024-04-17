class Api::V0::DistanceSearchController < ApplicationController
  def search
    # require 'pry'; binding.pry
    user = User.find(params[:user_id])
    render json: DistanceFacade.new(user).get_artists_within_distance(user)
  end
end