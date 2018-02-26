# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::SignUpsController, type: :controller do
  describe 'create' do
    subject { response }
    before { post :create, params: attributes }

    context 'When user sends valid phone number' do
      let(:attributes) { { phone_number: '15127628941' } }

      it { is_expected.to have_http_status 201 }
    end

    context 'When user sends invalid phone number' do
      let(:attributes) { { phone_number: 'qwertyuiop' } }

      it { is_expected.to have_http_status 422 }

      it 'should include a message about the phone number being invalid' do
        expect(JSON.parse(response.body)['message']).to eq("Invalid phone number")
      end
    end
  end
end
