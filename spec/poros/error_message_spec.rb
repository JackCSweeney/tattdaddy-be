require 'rails_helper'

RSpec.describe ErrorMessage do
  describe '#initialize' do
    it 'exists and has attributes' do
      error_message = ErrorMessage.new("This is bad", 404)

      expect(error_message).to be_a(ErrorMessage)
      expect(error_message.message).to eq("This is bad")
      expect(error_message.status).to eq(404)
    end
  end
end