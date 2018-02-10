class CreateSignUps < ActiveRecord::Migration[5.1]
  def change
    create_table :sign_ups do |t|
      t.string :encrypted_phone_number
      t.string :auth_code

      t.timestamps
    end
    add_index :sign_ups, :encrypted_phone_number
  end
end
