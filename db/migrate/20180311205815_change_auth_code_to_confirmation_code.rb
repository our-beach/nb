class ChangeAuthCodeToConfirmationCode < ActiveRecord::Migration[5.1]
  def change
    rename_column :sign_ups, :auth_code, :confirmation_code
  end
end
