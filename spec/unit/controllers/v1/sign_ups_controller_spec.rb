# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::SignUpsController, type: :controller do
  describe 'create' do
    subject { response }
    before { post :create }

    context 'When user sends valid phone number' do
      it { is_expected.to respond_with 201 }
    end

    context 'When user sends invalid phone number' do
      it { is_expected.to respond_with 400 }

      it 'should include a message about the phone number being invalid' do
        expect(response.body).to have_attributes(
          message: 'Invalid phone number',
        )
      end
    end

    context 'When the phone number cannot be processed' do
      it { is_expected.to respond_with 500 }
    end
  end
end
