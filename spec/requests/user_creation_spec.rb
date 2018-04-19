# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "POST api/v1/users/", type: :request do

  let(:phone_number) { '1-555-555-5555' }
  let(:request_params) do
    {
      data: {
        type: 'users',
        attributes: {phone_number: phone_number }
      }
    }
  end
  let(:headers) do
    { "CONTENT_TYPE" => "application/vnd.api+json" }
  end

  it "creates a new user" do
    post '/api/v1/users', params: request_params.to_json, headers: headers

    expect(response.content_type).to eq('application/vnd.api+json')
    expect(response).to have_http_status(:created)
  end
end

