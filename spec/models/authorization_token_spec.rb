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

  describe '.from_jwt' do
    subject { described_class.from_jwt jwt }

    context 'when the jwt matches a token' do
      xit 'should return the corresponding token'
    end

    context 'when the jwt does not match a token' do
      xit 'should return nil'
    end
  end

  describe '#expired?' do
    subject { instance.expired? }

    context 'when the current time is beyond the expiration time' do
      xit 'should be falsey'
    end

    context 'when the current time is not beyond the expiration time' do
      xit 'should be truthy'
    end
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
