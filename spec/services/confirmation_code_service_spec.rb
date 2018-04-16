# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfirmationCodeService do
  describe 'generate_code' do
    subject { described_class.generate_code }

    it { is_expected.to match(/^\d{6}$/) }
  end

  describe 'create!' do
    subject { described_class.create! }
    let(:code) { '123456' }

    before do
      expect(RedisDB).to receive(:insert!).
        with code, true, ttl: described_class::TTL

      expect(described_class).to receive(:generate_code).
        and_return code
    end

    it { is_expected.to eql code }
  end

  describe 'valid?' do
    subject { described_class.valid? code }
    let(:code) { "123456" }

    context 'when the confirmation code has been generated' do
      before { expect(RedisDB).to receive(:exists?).and_return true }
      it { is_expected.to be true }
    end

    context 'when the confirmation code has not been generated' do
      before { expect(RedisDB).to receive(:exists?).and_return false }
      it { is_expected.to be false }
    end
  end
end
