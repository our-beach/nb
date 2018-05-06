class CreateAuthorizationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :authorization_tokens do |t|
      t.string :uuid, null: false
      t.time :expiration_time, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
      t.index :uuid, unique: true
    end
  end
end
