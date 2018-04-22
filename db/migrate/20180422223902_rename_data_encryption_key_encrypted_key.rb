class RenameDataEncryptionKeyEncryptedKey < ActiveRecord::Migration[5.1]
  def change
    rename_column :data_encryption_keys, :key, :encrypted_key
  end
end
