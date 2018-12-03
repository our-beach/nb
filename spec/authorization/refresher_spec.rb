require 'rails_helper'

RSpec.describe Authorization::Refresher do
  let(:service) { described_class.new db: db }
  let(:db) { double }
  let(:tok) { instance_double AuthorizationToken }

  describe '#refresh!' do
    context 'when then token cannot be refreshed' do
      before do
        # what exactly does it mean for a token to be unrefreshable?
        # does this case make sense?
      end

      it 'should raise an Authorization::RefreshError' do
        expect { service.refresh! tok }.
          to raise_error Authorization::RefreshError
      end
    end

    context 'when a token exists that can be refreshed' do
      it 'should return the refreshed token' do
        refreshed = service.refresh! tok
        expect(refreshed.expiration_time).to be > tok.expiration_time
      end
    end
  end
end
