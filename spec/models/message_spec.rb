require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { described_class.new }

  it { is_expected.to be === '' }
end
