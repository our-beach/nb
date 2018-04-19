class RemoveConfirmationStatusFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :confirmation_status, :string
  end
end
