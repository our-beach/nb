require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'attributes' do
    subject { described_class.new }

    it { should have_attribute :phone_number }
    it { should have_attributes confirmation_status: 'unconfirmed' }
  end

  describe '#confirmed?' do
    subject { user.confirmed? }

    context 'when the user has been confirmed' do
      let(:user) { described_class.new confirmation_status: 'confirmed' }
      it { is_expected.to be true }
    end

    context 'when the user has not been confirmed' do
      let(:user) { described_class.new }
      it { is_expected.to be false }
    end
  end
end
