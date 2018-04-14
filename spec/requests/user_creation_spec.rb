# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "POST api/v1/users/", type: :request do

  let(:phone_number) { '555-555-5555' }
  let(:request_params) do
    {
      _jsonapi: {
        data: {
          type: 'users',
          atributes: {phone_number: phone_number }
        }
      }
    }
  end

  it "creates a new user" do
    post "/api/v1/users/create", params: request_params

    expect(response.content_type).to eq('application/vnd.api+json')
    expect(response).to have_http_status(:created)
  end
end

