require 'rails_helper'

RSpec.describe AuthCodeService do
  describe '.valid?' do
    subject { described_class.valid? auth_code }

    context 'when the provided auth code is invalid' do
      let(:auth_code) { 'my_phony_auth_code' }

      before do
        allow(AuthCode).to receive(:exists?).and_return false
      end

      it { is_expected.to be false }
    end

    context 'when the provided auth code is valid' do
      let(:auth_code) { 'my_valid_auth_code' }

      before do
        allow(AuthCode).to receive(:exists?).and_return true
      end

      it { is_expected.to be true }
    end
  end
end
