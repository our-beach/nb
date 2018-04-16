require 'rails_helper'

RSpec.describe AuthorizationRequestValidator do
  describe '.call' do
    subject { described_class.call request }

    let(:user) { instance_double User, id: '1' }
    let(:token) { '123456' }
    let(:request) { AuthorizationRequest.new user, token }

    context 'when the request matches an existing user/token pair' do
      before do
        allow(AuthorizationRequestTokenDB).to receive(:for_user).
          with(user.id).
          and_return token
      end

      it { is_expected.to be true }
    end

    context 'when the request does not match an existing user/token pair' do
      before do
        allow(AuthorizationRequestTokenDB).to receive(:for_user).
          with(user.id)
      end

      it { is_expected.to be false }
    end
  end
end
