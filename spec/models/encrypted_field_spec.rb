require 'rails_helper'

RSpec.describe EncryptedField, type: :model do
  describe 'attributes' do
    it { should belong_to :data_encryption_key }
  end

  describe 'validations' do
    it { should validate_presence_of(:encrypted_blob).on :save }
    it { should validate_presence_of(:encrypted_blob_iv).on :save }
    it { should validate_presence_of(:encrypted_blob_salt).on :save }
    it { should validate_presence_of(:data_encryption_key).on :save }
  end

  describe '#reencrypt!' do
    before :all do
      @dek_one = DataEncryptionKey.generate! primary: true
      @field = EncryptedField.create! blob: 'dogs!'
      @dek_two = DataEncryptionKey.generate!

      @field.reencrypt! @dek_two
    end

    after :all do
      [@field, @dek_one, @dek_two].each(&:destroy!)
    end

    it 'should use the new dek for decryption/encryption' do
      expect(@field.data_encryption_key_id).to eq @dek_two.id
    end

    it 'should still correctly decrypt the blob' do
      expect(@field.blob).to eq 'dogs!'
    end
  end
end
