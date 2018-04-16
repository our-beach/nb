require 'rails_helper'

RSpec.describe AuthorizationRequestTokenDB, type: :db do
  describe '.create' do
    it 'should create a new token in the database and return it' do
      user_id = 'test_id'
      token = '123456'

      expect(AuthorizationRequestToken).to receive(:new).
        and_return token

      expect(RedisDB).to receive(:insert!).
        with(
          "art:#{user_id}",
          token,
          ttl: Figaro.env.authorization_request_token_ttl_minutes.to_i.minutes
        )

      expect(described_class.create user_id).to eq token
    end
  end

  describe '.for_user' do
    subject { described_class.for_user user_id }

    let(:user_id) { '1' }

    context 'when a request token exists for the given user' do
      let(:token) { '123456' }
      before { expect(RedisDB).to receive(:get).with("art:#{user_id}").and_return token }
      it('should return the token') { is_expected.to eq token }
    end

    context 'when a request token exists for the given user' do
      before { expect(RedisDB).to receive(:get).with("art:#{user_id}") }
      it { is_expected.to be_nil }
    end
  end
end
