require 'rails_helper'

RSpec.describe TextMessageService, type: :service do
  let(:phone_number) { '555-555-5555' }
  let(:message) { '' }

  xit 'should send the provided message to the provided phone number' do
    described_class.call phone_number, message
  end
end
