require 'rails_helper'

RSpec.describe ConfirmationCodeService do
  describe 'create!' do
    subject { described_class.create! }

    it { is_expected.to match /^\d{6}$/ }
  end
end
