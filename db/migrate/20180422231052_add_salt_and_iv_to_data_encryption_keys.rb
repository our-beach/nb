class AddSaltAndIvToDataEncryptionKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :data_encryption_keys, :encrypted_key_salt, :string
    add_column :data_encryption_keys, :encrypted_key_iv, :string
  end
end
