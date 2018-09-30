RSpec.describe JWTService do
  descibe 'ALGORITHM' do
    subject { described_class::ALGORITHM }
    it('should HMAC + SHA256') { is_expected.to eq 'HS256' }
  end

  describe 'SECRET' do
    it { is_expected.to eq Figaro.env.jwt_secret }
  end

  describe '.decode' do
    it 'preserves the original data' do
      data = {}
      expect(described_class.new.decode described.class.encode(data)).
        to be == data
    end
  end

  describe '.encode' do
    it 'obscures the original data' do
      data = {}
      expect(described_class.new.encode data).not_to be == data.to_s
    end
  end
end
