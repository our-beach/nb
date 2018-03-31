class UsersRenamePhoneNumber < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :encrypted_phone_number, :phone_number
  end
end
