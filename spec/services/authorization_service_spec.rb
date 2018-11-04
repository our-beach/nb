require 'rails_helper'

RSpec.describe AuthorizationService do
  let :service do
    described_class.new decoder: decoder, validator: validator, db: db
  end

  describe 'validate!' do
    let :decoder do
      double
    end

    let :validator do
      double
    end

    let :db do
      double
    end

    context 'when token is malformed' do
      before do
        allow(decoder).to receive(:decode).
          and raise_exception RuntimeError
      end

      xit 'should pass through an Authorization::DecodeError' do
      end
    end

    context 'when token is expired' do
      before do
        allow(validator).to receive(:validate).
          and raise_exception RuntimeError
      end

      xit 'should attempt to refresh the token' do
      end

      context 'and token can be found' do
        xit 'should refresh the token' do
        end
      end

      context 'and token cannot be found' do
        before do
          allow(db).to receive(:refresh).
            and raise_exception RuntimeError
        end

        xit 'should pass through an Authorization::UnauthorizedError' do
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
end
