require 'rails_helper'

RSpec.describe JWTService do
  describe 'ALGORITHM' do
    subject { described_class::ALGORITHM }
    it('should be HMAC + SHA256') { is_expected.to eq 'HS256' }
  end

  describe 'SECRET' do
    subject { described_class::SECRET }
    it { is_expected.to eq Figaro.env.jwt_secret }
  end

  describe '.decode' do
    it 'preserves the original data' do
      data = { sub: rand(10000), exp: Time.now.to_i + 1 }
      expect(described_class.decode described_class.encode(data)).
        to be == data
    end

    it 'throws an error when decoding expired data' do
      data = { sub: rand(10000), exp: Time.now.to_i }
      expect { described_class.decode described_class.encode(data) }.
        to raise_error JWT::ExpiredSignature
    end
  end

  describe '.encode' do
    it 'obscures the original data' do
      data = {}
      expect(described_class.encode data).not_to be == data.to_s
    end
  end
end
