# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConfirmationCodeService do
  describe 'create!' do
    subject { described_class.create! }

    it { is_expected.to match(/^\d{6}$/) }
  end

  describe 'valid?' do
    subject { described_class.valid? code }

    context 'when the confirmation code exists in redis' do
      let(:code) { '654321' }

      before do
        RedisDB.insert!(code, true, ttl: 1)
      end

      after do
        RedisDB.delete(code)
      end

      it { is_expected.to be true }
    end
  end
end
