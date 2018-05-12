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
    let(:auth_token) do
      described_class.new(
        uuid: uuid,
        expiration_time: expiration_time,
        user: user
      )
    end
    let(:jwt) { { exp: expiration_time, sub: user.id, jti: uuid } }
    let(:uuid) { 'uuid' }
    let(:expiration_time) { Time.zone.now }
    let(:user) { User.new(phone_number: '555-555-5555') }

    before do
      DataEncryptionKey.generate!.promote!
    end

    context 'when the jwt matches a token' do
      it 'should return the corresponding token' do
        auth_token.save

        expect(subject).to eq(auth_token)
      end
    end

    context 'when the jwt does not match a token' do
      it 'should return nil' do
        expect(subject).to eq(nil)
      end
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
