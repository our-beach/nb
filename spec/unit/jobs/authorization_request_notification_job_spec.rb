require 'rails_helper'

RSpec.describe AuthorizationRequestNotificationJob, type: :job do
  let(:phone_number) { '555-555-5555' }
  let(:message) { Messages::AuthorizationRequest.new token }
  let(:token) { AuthorizationRequestToken.new }

  before do
    allow(PhoneNumberDB).to receive(:for_user).
      with('1').
      and_return phone_number

    allow(AuthorizationRequestTokenDB).to receive(:create).
      with('1').
      and_return token
  end

  it 'should send a authorization request code via text message' do
    expect(TextMessageService).to receive(:call).with phone_number, eq(message)
    described_class.perform_now '1'
  end
end
