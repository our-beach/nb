require 'rails_helper'

RSpec.describe V1::Users::AuthorizationTokenController, type: :controller do
  describe 'GET /' do
    subject { response }
    before { get :show, params: { id: '1', token: '123456' } }

    let(:auth_token) { "you're good to go" }

    context 'when the exchange request is valid' do
      it { is_expected.to have_http_status 204 }
      it do
        is_expected.to have_attributes headers: include(
          'Authorization' => "Bearer #{auth_token}"
        )
      end
    end

    context 'when the exchange request is not valid' do
      it { is_expected.to have_http_status 403 }
      it 'should have error information' do
        body = JSON.parse response.body
        expect(body).to include(
          'errors' => include(
            include(
              'title' => 'Invalid request token',
              'description' => 'The provided request token is not valid. It may have expired or may never have been assigned to the provided user'
            )
          )
        )
      end
    end
  end
end
