# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisDB do
  describe 'exists?' do
    subject { described_class.exists? key }
    let(:key) { 'dogs' }

    context 'when the redis key exists' do
      before { RedisDB.redis.set key, true }
      after { RedisDB.redis.del key }

      it { is_expected.to be true }
    end

    context 'when the redis key does not exists' do
      it { is_expected.to be false }
    end
  end
end
