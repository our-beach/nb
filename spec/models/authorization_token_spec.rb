require 'rails_helper'

RSpec.describe AuthorizationToken, type: :model do
  describe 'attributes' do
    it { is_expected.to have_attribute :uuid }
    it { is_expected.to have_attribute :expiration_time }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :uuid }
    it { is_expected.to validate_presence_of :expiration_time }
    it { is_expected.to validate_presence_of :user }
  end

  describe '#to_jwt' do
    subject do
      described_class.new(
        uuid: 'uuid',
        expiration_time: now,
        user: User.new(id: 10)
      ).to_jwt
    end

    let(:now) { Time.zone.now }

    it { is_expected.to include exp: now }
    it { is_expected.to include sub: 10 }
    it { is_expected.to include jti: 'uuid' }
  end
end
