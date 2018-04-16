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

  describe 'insert!' do
    let(:key) { 'key' }
    let(:value) { 'value' }
    let(:ttl) { 1 }

    after { RedisDB.redis.del key }

    context 'when no ttl or other options are provided' do
      subject { described_class.insert! key, value }

      after { expect(RedisDB.redis.ttl key).to be -1 }
      after { expect(RedisDB.redis.get key).to eql value }

      it { is_expected.to be true }
    end

    context 'when ttl is provided, but not other options' do
      subject { described_class.insert! key, value, ttl: ttl }

      after { expect(RedisDB.redis.ttl key).to be ttl }
      after { expect(RedisDB.redis.get key).to eql value }

      it { is_expected.to be true }
    end

    context 'when options are provided aside from ttl' do
      subject { described_class.insert! key, value, nx: true }

      before{ RedisDB.redis.set key, 'dogs' }
      after { expect(RedisDB.redis.ttl key).to be -1 }
      after { expect(RedisDB.redis.get key).to eq 'dogs' }

      it { is_expected.to be false }
    end

    context 'when ttl and other options are provided' do
      subject { described_class.insert! key, value, ttl: ttl, xx: true }

      before{ RedisDB.redis.set key, 'dogs' }
      after { expect(RedisDB.redis.ttl key).to be 1 }
      after { expect(RedisDB.redis.get key).to eq value }

      it { is_expected.to be true }
    end
  end
end
