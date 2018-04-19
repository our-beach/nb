class RemoveUsersPhoneNumberIndex < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, name: 'index_users_on_phone_number'
  end
end
