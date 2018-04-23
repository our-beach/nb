class User < ApplicationRecord

  belongs_to :encrypted_phone_number,
    class_name: "EncryptedField",
    dependent: :destroy,
    autosave: true
  validates_presence_of :phone_number, on: :create

  def phone_number=(val)
    encrypted_phone_number.blob = val
  end

  def phone_number
    encrypted_phone_number.blob
  end

  def encrypted_phone_number
    super || build_encrypted_phone_number
  end
end
