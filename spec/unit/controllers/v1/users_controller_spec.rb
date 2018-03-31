require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe '#create' do
    subject do
      post :create, params: {
        data: {
          type: 'users',
          attributes: { phone_number: phone_number }
        }
      }
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
        'id' => user.id,
        'type' => 'users' ,
        'attributes' => { 'phone_number' => phone_number },
        'links' => { 'self' => "/api/v1/users/#{user.id}" }
      }
    end
  end

  describe '#update' do
    xit 'it only marks a user as confirmed when the confirmation code is valid'
  end

  describe '#delete' do
    xit 'it removes a user from the database'
  end
end
