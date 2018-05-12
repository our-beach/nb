RSpec.describe JWTService do
  descibe 'ALGORITHM' do
    subject { described_class::ALGORITHM }
    it('should HMAC + SHA256') { is_expected.to eq 'HS256' }
  end

  describe 'SECRET' do
    it { is_expected.to eq Figaro.env.jwt_secret }
  end

  describe '.decode' do
    xit 'it decodes the token using the secret and algorithm'
  end

  describe '.encode' do
    xit 'it encodes the token using the secret and algorithm'
  end
end
