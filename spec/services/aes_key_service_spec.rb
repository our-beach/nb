require 'rails_helper'

RSpec.describe AESKeyService do
  describe '.call' do
    subject { described_class.call.size }
    it { is_expected.to be 32 }

    context 'when the size is specified' do
      subject { described_class.call(10).size }
      it { is_expected.to be 10 }
    end
  end
end
