# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::SignUpsController, type: :controller do
  describe 'create' do
    let(:valid_attributes) { { number: '1234567890' } }
    let(:invalid_attributes) { { number: 'qwertyuiop' } }
    subject { response }

    context 'When user sends valid phone number' do
      before { post :create, params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'When user sends invalid phone number' do
      before { post :create, params: invalid_attributes }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'should include a message about the phone number being invalid' do
        expect(JSON.parse(response.body)['message']).to eq("Invalid phone number")
      end
    end

    context 'When the phone number cannot be processed' do
      it 'returns status code 500' do
        expect(response).to have_http_status(500)
      end
    end
  end
end
