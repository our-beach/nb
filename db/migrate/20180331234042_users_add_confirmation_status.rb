class UsersAddConfirmationStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :confirmation_status, :string, default: 'unconfirmed'
  end
end
