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
      before do 
        expect(ConfirmationCodeService).to receive(:create).
          and_return(confirmation_code)
        expect(ConfirmationMessageJob).to receive(:perform_later).
          with(phone_number, confirmation_code)
        expect(SignUp).to receive(:create).
          with(phone_number: phone_number, confirmation_code: confirmation_code).
          and_call_original
      end

      it { is_expected.to be_truthy }
     

    end
  end
end
