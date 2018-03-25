# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfirmationMessageJob, type: :job do
  describe '#perform_now' do
    subject { described_class.perform_now sign_up_id }

    let(:sign_up_id) { 'abc' }
    let(:confirmation_code) { '123456' }
    let(:phone_number) { '5555555555' }
    let(:message) do
      "Welcome to nb, please enter [#{confirmation_code}] to register"
    end
    let(:sign_up) do
      instance_double(
        SignUp,
        confirmation_code: confirmation_code
      )
    end

    before do
      expect(SignUp).to receive(:find).with(sign_up_id).and_return sign_up

      expect(sign_up).to receive(:phone_number).and_return phone_number

      expect(TextMessageService).to receive(:send).
        with(phone_number, message)
    end

    it { subject }
  end
end
