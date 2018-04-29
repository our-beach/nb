class DropAuthCodes < ActiveRecord::Migration[5.1]
  def up
    drop_table :auth_codes
  end
end
