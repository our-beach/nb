require 'rails_helper'

RSpec.describe KekService do
  describe '.call' do
    subject { described_class.call }
    it { is_expected.to be == ENV['KEK'] }
  end
end
