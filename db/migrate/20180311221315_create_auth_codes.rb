class CreateAuthCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :auth_codes do |t|
      t.string :code, unique: true

      t.timestamps
    end
  end
end
