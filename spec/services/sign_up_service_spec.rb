require 'rails_helper'

RSpec.describe SignUpService do
  describe 'create!' do
    subject { described_class.create! phone_number }

    context 'when the provided phone number is invalid' do
      let(:phone_number) { 'abc' }

      it 'should raise an InvalidPhoneNumber error' do
        expect { subject }.to raise_error SignUpService::InvalidPhoneNumber
      end
    end

    context 'when the provided phone number is valid' do
      let(:phone_number) { '15555555555' }
      let(:confirmation_code) { 'abc' }
      let(:id) {'9a0fkj2'}

      before do
        expect(ConfirmationCodeService).to receive(:create!).
          and_return(confirmation_code)

        expect(SignUp).to receive(:create).
          with(encrypted_phone_number: phone_number, confirmation_code: confirmation_code).
          and_return instance_double(SignUp, id: id)

        expect(ConfirmationMessageJob).to receive(:perform_later).
          with(id)
      end

      it { is_expected.to be_truthy }
    end
  end
end
