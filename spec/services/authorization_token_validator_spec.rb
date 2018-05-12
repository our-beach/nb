require 'rails_helper'

RSpec.describe AuthorizationTokenValidator do
  describe '.call' do
    subject { described_class.call jwt }
    let(:token) { 'hey bud' }

    before do
      allow(AuthorizationToken).to receive(:from_jwt).and_return token
    end

    context 'when the token is expired' do
    end

    context 'when the specified user does not exist' do
    end

    context 'when the jwt id does not match the user' do
    end

    context 'when the jwt is valid' do
    end
  end
end
