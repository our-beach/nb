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
end
