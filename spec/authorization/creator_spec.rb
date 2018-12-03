require 'rails_helper'

RSpec.describe Authorization::Creator do
  describe '.call' do
    subject { described_class.call @user }

    let(:uuid) { 'uuid' }

    let(:now) { Time.zone.now }

    before do
      DataEncryptionKey.generate! primary: true
      @user = User.create phone_number: '555-555-5555'
      allow(UUIDGenerator).to receive(:call).and_return uuid
    end

    it { is_expected.to respond_to :to_jwt }
    it { is_expected.to have_attributes user: @user }
    it { is_expected.to have_attributes uuid: uuid }
    it do
      window = described_class::EXPIRATION_WINDOW.to_i
      is_expected.to have_attributes(
        expiration_time: be_within(window).of(now.to_i)
      )
    end

    context 'when the user already has an authorization token' do
      before do
        @old_token = AuthorizationToken.create! user: @user,
          uuid: 'uuid',
          expiration_time: Time.zone.now.to_i
      end

      it 'should destroy the prior token' do
        expect(@old_token).to receive(:destroy!).and_call_original
        subject
      end
    end
  end
end
