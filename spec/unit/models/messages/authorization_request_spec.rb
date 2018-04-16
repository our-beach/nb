require 'rails_helper'

RSpec.describe Messages::AuthorizationRequest, type: :model do
  let(:ttl) { Figaro.env.authorization_request_token_ttl_minutes }

  it do
    expect(described_class.new '123456').to be === %Q{Your NB authorization request token is:
    123456
    It will expire in #{ttl} minutes.
    }
  end
end
