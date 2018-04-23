require 'rails_helper'

RSpec.describe DataEncryptionKey, type: :model do
  describe 'attributes' do
    it { should have_attribute :primary }

    it { should have_db_column :encrypted_key }
    it { should have_db_column :encrypted_key_iv }

    it { should have_many :encrypted_fields }
  end

  describe 'validations' do
    it { should validate_presence_of(:encrypted_key).on :create }
  end

  describe '.generate!' do
    before { expect(AESKeyService).to receive(:call).and_call_original }

    context 'when primary is specified' do
      subject { described_class.generate! primary: true }
      after { described_class.last.destroy! }

      it { is_expected.to eq described_class.primary }
    end

    context 'when primary is not specified' do
      subject { described_class.generate! }
      after { described_class.last.destroy! }

      it { is_expected.not_to eq described_class.primary }
    end
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

  describe '.unused' do
    subject { described_class.unused }

    before :all do
      @non_primary_no_fields = described_class.generate!
      @non_primary_fields = described_class.generate! primary: true
      EncryptedField.create! blob: 'dogs!'
      @primary = described_class.generate! primary: true
    end

    after :all do
      @non_primary_no_fields.destroy!
      @non_primary_fields.encrypted_fields.each(&:destroy!)
      @non_primary_fields.destroy!
      @primary.destroy!
    end

    it { is_expected.not_to include @primary }
  end

  describe '#is_primary?' do
    subject { instance.is_primary? }

    context 'when the key is primary' do
      let(:instance) { described_class.new key: 'abc', primary: true }
      it { is_expected.to be_truthy }
    end

    context 'when the key is not primary' do
      let(:instance) { described_class.new key: 'abc', primary: false }
      it { is_expected.to be_falsey }
    end
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
