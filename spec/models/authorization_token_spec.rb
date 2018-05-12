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

  describe '.find_for_jwt' do
    subject { described_class.find_for_jwt jwt }

    let(:uuid) { 'uuid' }
    let(:expiration_time) { Time.zone.now }
    let(:user) { User.new(phone_number: '555-555-5555') }

    before do
      DataEncryptionKey.generate!.promote!
      @token = described_class.create!(
        uuid: uuid,
        expiration_time: expiration_time,
        user: user
      )
    end

    context 'when the jwt matches a token' do
      let(:jwt) { { exp: expiration_time, sub: user.id, jti: uuid } }
      it { is_expected.to eq @token }
    end

    context 'when the jwt has a different uuid' do
      let(:jwt) { { exp: expiration_time, sub: user.id, jti: SecureRandom.uuid } }
      it { is_expected.to be_nil }
    end

    context 'when the jwt has a different expiration time' do
      let(:jwt) { { exp: expiration_time + 1.second, sub: user.id, jti: uuid } }
      it { is_expected.to be_nil }
    end

    context 'when the jwt has a different user' do
      let(:jwt) { { exp: expiration_time, sub: SecureRandom.uuid, jti: uuid } }
      it { is_expected.to be_nil }
    end
  end

  describe '#expired?' do
    subject { instance.expired? }
    let(:instance) do
      described_class.new(
        uuid: uuid,
        expiration_time: expiration_time,
        user: user
      )
    end
    let(:uuid) { 'uuid' }
    let(:user) { User.new(phone_number: '555-555-5555') }

    before do
      DataEncryptionKey.generate!.promote!
    end

    context 'when the current time is beyond the expiration time' do
      let(:expiration_time) { Time.zone.now - 1.second }

      it { is_expected.to eq(true) }
    end

    context 'when the current time is (virtually) equal to the expiration time' do
      let(:expiration_time) { Time.zone.now }

      it { is_expected.to eq(true) }
    end

   context 'when the current time is not beyond the expiration time' do
      let(:expiration_time) { Time.zone.now + 1.second}

      it { is_expected.to eq(false) }
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
