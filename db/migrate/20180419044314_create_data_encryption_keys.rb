class CreateDataEncryptionKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :data_encryption_keys do |t|
      t.string :key, null: false
      t.boolean :primary, null: false

      t.timestamps
    end
  end
end
