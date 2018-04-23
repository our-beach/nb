class EncryptedField < ApplicationRecord
  attr_encrypted :blob,
    mode: :per_attribute_iv_and_salt,
    key: :encryption_key

  belongs_to :data_encryption_key

  validates :encrypted_blob, :encrypted_blob_iv, :encrypted_blob_salt, :data_encryption_key,
    presence: true

  def reencrypt! new_dek
    update_attributes! data_encryption_key: new_dek, blob: blob
    self.reload
  end

  private

  def encryption_key
    (self.data_encryption_key ||= DataEncryptionKey.primary).key
  end
end
