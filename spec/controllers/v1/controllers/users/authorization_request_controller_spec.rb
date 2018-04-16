require 'rails_helper'

RSpec.describe Users::AuthorizationRequestController, type: :controller do
  describe 'create' do
    subject { response }
    before { post :create, params: api_params(data: attributes) }

    context 'When user sends valid phone number' do
      let(:attributes) { { phone_number: '15127628941' } }

      it { is_expected.to have_http_status 201 }
    end

    context 'When user sends invalid phone number' do
      let(:attributes) { { phone_number: 'qwertyuiop' } }

      it { is_expected.to have_http_status 422 }

      it 'should include a message about the phone number being invalid' do
        response = JSON.parse(response.body)
        expect(response).to have_attributes(
          'errors' => include(
            include(
              'title' => 'Invalid phone number',
              'description' => '"qwertyuiop" is not a valid phone number.'
            ),
          )
        )
      end
    end
  end
end
