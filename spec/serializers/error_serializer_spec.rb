require 'rails_helper'

RSpec.describe ErrorSerializer do
  describe '#initialize' do
    it 'exists' do
      error = ErrorMessage.new("Error Message", 404)
      error_serializer = ErrorSerializer.new(error)

      expect(error_serializer).to be_a(ErrorSerializer)
    end
  end

  describe '#serialize_json' do
    it 'can return the correct format of error message from its error object attribute' do
      error = ErrorMessage.new("Error Message", 404)
      error_serializer = ErrorSerializer.new(error)
      expect(error_serializer.serialize_json).to eq({:errors=>[{:detail=>error.message, status_code: error.status}]})
    end
  end
end