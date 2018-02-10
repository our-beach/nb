class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :encrypted_phone_number

      t.timestamps
    end
    add_index :users, :encrypted_phone_number
  end
end
