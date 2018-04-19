class DropSignUps < ActiveRecord::Migration[5.1]
  def up
    drop_table :sign_ups
  end

  def down
    create_table "sign_ups", force: :cascade do |t|
      t.string "encrypted_phone_number"
      t.string "confirmation_code"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["encrypted_phone_number"], name: "index_sign_ups_on_encrypted_phone_number"
    end
  end
end
