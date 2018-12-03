require 'rails_helper'

RSpec.describe Authorization::Refresher do
  let(:service) { described_class.new db: db }
  let(:db) { double }

  describe '#refresh!' do
    context 'when no token exists that matches the provided token' do
      xit 'should raise an Authorization::RefreshError' do

      end
    end

    context 'when a matching token exists, but it cannot be refreshed' do
      xit 'should raise an Authorization::RefreshError' do

      end
    end

    context 'when a token exists that can be refreshed' do
      xit 'should return the refreshed token' do

      end
    end
  end
end
