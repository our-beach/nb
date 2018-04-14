require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe '#create' do
    subject do
      post :create, params: api_params(
        data: {
          type: 'users',
          attributes: { phone_number: phone_number }
        }
      )
    end

    let(:phone_number) { '555-555-5555' }
    let(:user) { User.new id: 1, phone_number: phone_number }
    let(:encrypted_phone_number) { 'afhdslacdjsaklfhdkl;a' }

    before do
      expect(UserService).to receive(:create).
        with(phone_number).
        and_return user
    end

    it { is_expected.to have_http_status :created }

    it 'should include a representation of the user record' do
      representation = JSON.parse subject.body
      expect(representation).to include 'data' => {
        'id' => user.id.to_s,
        'type' => 'users',
        'links' => {
          'self' => "/api/v1/users/#{user.id}",
          'authorizationRequests' => "/api/v1/users/#{user.id}/authorization-requests",
          'authorizationTokens' => "/api/v1/users/#{user.id}/authorization-tokens"
        }
      }
    end
  end
end
