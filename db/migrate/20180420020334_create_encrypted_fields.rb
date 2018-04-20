class CreateEncryptedFields < ActiveRecord::Migration[5.1]
  def change
    create_table :encrypted_fields do |t|
      t.string :encrypted_blob
      t.string :encrypted_blob_iv
      t.string :encrypted_blob_salt
      t.belongs_to :data_encryption_key, foreign_key: true

      t.timestamps
    end
  end
end
