class AddEncryptedPhoneNumberRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :encrypted_phone_number,
      foreign_key: {to_table: :encrypted_fields}
  end
end
