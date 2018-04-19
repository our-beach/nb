require 'rails_helper'

RSpec.describe DataEncryptionKey, type: :model do
  describe 'attributes' do
    it { should have_attribute :key }
    it { should have_attribute :primary }
  end

  describe 'validations' do
    it { should validate_inclusion_of(:primary).in_array([true, false]).on :create }
    it { should validate_presence_of(:key).on :create }
  end

  describe '.primary' do
    subject { described_class.primary }

    before do
      @key_one = described_class.create key: 'abc', primary: true
      @key_two = described_class.create key: 'def', primary: false
    end

    after do
      @key_one.destroy!
      @key_two.destroy!
    end

    it { is_expected.to have_attributes key: 'abc' }
  end

  describe '#promote!' do
    subject { @promoted.promote! }

    context 'when a different key is already primary' do
      before do
        @demoted = described_class.create key: 'abc', primary: true
        @promoted = described_class.create key: 'def', primary: false
      end

      after do
        @demoted.destroy!
        @promoted.destroy!
      end

      it 'should promote the new key' do
        is_expected.to have_attributes primary: true
      end

      it 'should demote the prior primary key' do
        @promoted.promote!
        expect(@demoted.reload).to have_attributes primary: false
      end
    end

    context 'when no prior key is primary' do
      before { @promoted = described_class.create key: 'def', primary: false }
      after { @promoted.destroy! }

      it 'should promote the new key' do
        is_expected.to have_attributes primary: true
      end
    end
  end
end
