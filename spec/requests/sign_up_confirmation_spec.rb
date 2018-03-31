# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "PATCH api/v1/sign_ups/:id {completed: true}", type: :request do

  before { @signup = SignUp.create(encrypted_phone_number: "1", confirmation_code: '123456') }
  after { @signup.destroy }

  it "accepts for valid users" do
    patch "/api/v1/sign_ups/#{@sign_up.id}"

    expect(response.content_type).to eq('application/json')
    expect(response).to have_http_status(:created)
  end
end
