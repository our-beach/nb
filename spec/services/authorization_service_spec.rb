require 'rails_helper'

RSpec.describe AuthorizationService do
  let :service do
    described_class.new decoder: decoder,
      validator: validator,
      refresher: refresher,
      creator: creator
  end

  describe 'validate!' do
    subject { service.validate! tok }

    let(:tok) { '' }

    let :decoder do
      double
    end

    let :validator do
      double
    end

    let :refresher do
      double
    end

    let :creator do
      double
    end

    before do
      allow(decoder).to receive(:decode!)
      allow(validator).to receive(:validate!)
      allow(refresher).to receive(:refresh!)
      allow(creator).to receive(:create!)
    end

    context 'when token is malformed' do
      before do
        allow(decoder).to receive(:decode!).
          and_raise Authorization::DecodeError
      end

      it 'should pass through an Authorization::MalformedTokenError' do
        expect { subject }.to raise_error Authorization::MalformedTokenError
      end
    end

    context 'when token is expired' do
      before do
        allow(validator).to receive(:validate!).
          and_raise Authorization::ExpiredTokenError
      end

      context 'and token can be refreshed' do
        let(:new_tok) { '' }

        before do
          expect(refresher).to receive(:refresh!).
            and_return new_tok
        end

        it { is_expected.to be_equal new_tok }
      end

      context 'and token cannot be refreshed' do
        before do
          expect(refresher).to receive(:refresh!).
            and_raise Authorization::RefreshError
        end

        it 'should pass through an Authorization::UnauthorizedError' do
          expect { subject }.to raise_exception Authorization::UnauthorizedError
        end
      end
    end
  end

  describe 'revoke!' do
    context 'when token has already been revoked' do
      xit 'should not raise an exception' do
      end
    end

    context 'when token exists' do
      xit 'should delete the matching token' do
      end
    end
  end

  describe '#authorize!' do
    xit 'should create a token for the provided user' do
    end
  end
end
