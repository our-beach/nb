require 'rails_helper'

RSpec.describe PhoneNumberDB, type: :db do
  describe '.for_user' do
    subject { described_class.for_user @user.id }

    before { DataEncryptionKey.generate!.promote! }

    context 'when a phone number exists for the user' do
      let(:phone_number) { '555-555-5555' }

      before { @user = User.create! phone_number: phone_number }
      after { @user.destroy! }

      it { is_expected.to eq phone_number }
    end

    context 'when a phone number does not exist for the user' do
      before { @user = instance_double User, id: 'not there' }

      it { is_expected.to be_nil }
    end
  end
end
