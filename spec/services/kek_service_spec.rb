require 'rails_helper'

RSpec.describe KekService do
  describe '.call' do
    subject { described_class.call }
    before { ENV['KEK'] = 'abc' }
    it { is_expected.to be == 'abc' }
  end
end
