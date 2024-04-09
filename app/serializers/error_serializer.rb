class ErrorSerializer
  def initialize(error)
    @error = error
    @status = error.status
  end

  def serialize_json
    {
      errors: [{
        detail: @error.message,
        status_code: @status
      }]
    }
  end
end