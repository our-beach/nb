require 'rails_helper'

RSpec.describe Authorization::Validator do
  describe '.call' do
    subject { described_class.new(db: db).call jwt }
    let(:db) { class_double AuthorizationToken }
    let(:token) { instance_double AuthorizationToken }
    let(:jwt) { instance_double Hash }


    context 'when a token can be found' do
      before do
        allow(db).to receive(:find_for_jwt).and_return token
      end

      context 'when the token is expired' do
        before { allow(token).to receive(:active?).and_return false }
        it { is_expected.to be_falsey }
      end

      context 'when the token is active' do
        before { allow(token).to receive(:active?).and_return true }
        it { is_expected.to be_truthy }
      end
    end

    context 'when no token can be found 'do
      before { allow(db).to receive(:find_for_jwt) }
      it { is_expected.to be_falsey }
    end
  end
end
