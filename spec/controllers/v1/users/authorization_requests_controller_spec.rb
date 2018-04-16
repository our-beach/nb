require 'rails_helper'

RSpec.describe V1::Users::AuthorizationRequestsController, type: :controller do
  describe 'create' do
    subject { response }
    before { post :create, params: { id: '1' } }

    it { is_expected.to have_http_status 204 }
  end
end
