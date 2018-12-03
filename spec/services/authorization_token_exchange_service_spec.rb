require 'rails_helper'

RSpec.describe V1::Users::AuthorizationTokenExchangeService do
  describe '.call' do
    subject { described_class.call exchange_request }
    let(:exchange_request) do
      instance_double ExchangeRequest, user: user
    end

    let(:user) { instance_double User, id: 'abc' }
    let(:token) { instance_double AuthorizationToken }

    context 'when the exchange request is invalid' do
      before do
        expect(ExchangeRequestValidator).to receive(:call).
          with(exchange_request).
          and_return false

        expect(AuthorizationService).not_to receive(:authorize!)
        expect(AuthorizationRequestTokenDB).not_to receive(:destroy)
      end

      it 'should raise a error' do
        expect { subject }.to raise_error described_class::InvalidRequestError
      end
    end

    context 'when the exchange request is valid' do
      before do
        expect(ExchangeRequestValidator).to receive(:call).
          with(exchange_request).
          and_return true

        expect(AuthorizationService).to receive(:authorize!).
          with(user).
          and_return token

        expect(AuthorizationRequestTokenDB).to receive(:destroy)
      end

      it { is_expected.to eq token }
    end
  end
end
