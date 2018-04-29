require 'rails_helper'

RSpec.describe V1::Users::AuthorizationTokenExchangeService, type: :controller do
  describe '.call' do
    subject { described_class.call exchange_request }

    context 'when the exchange request is invalid' do
      before do
        expect(ExchangeRequestValidator).to receive(:call).
          with(exchange_request).
          and_return false

        expect(AuthorizationTokenGenerator).not_to receive(:call)
      end

      it 'should raise a error' do
        expect { subject }.to raise described_class::InvalidRequestError
      end
    end

    context 'when the exchange request is valid' do
      before do
        expect(ExchangeRequestValidator).to receive(:call).
          with(exchange_request).
          and_return true

        expect(AuthorizationTokenGenerator).to receive(:call).
          with(user).
          and_call_original
      end

      it { is_expected.to be_a String }
    end
  end
end
