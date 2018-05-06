require 'rails_helper'

RSpec.describe AuthorizationTokenValidator do
  describe '.call' do
    context 'when the token is expired' do
      xit 'should be falsey'
    end

    context 'when the specified user does not exist' do
      xit 'should be falsey'
    end

    context 'when the jwt id does not match the user' do
      xit 'should be falsey'
    end

    xit 'should be truthy'
  end
end
