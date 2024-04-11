class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  def not_found(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end

  def invalid(exception)
    if exception.message.include?("taken")
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).serialize_json, status: 422
    else 
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: 404
    end 
  end
end
