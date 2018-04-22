class RemoveEncryptedKeySaltFromDataEncryptionKeys < ActiveRecord::Migration[5.1]
  def change
    remove_column :data_encryption_keys, :encrypted_key_salt
  end
end
