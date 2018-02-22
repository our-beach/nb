class SignUp < ApplicationRecord
  attr_readonly :encrypted_phone_number
  attr_readonly :auth_code

  validates :encrypted_phone_number, presence: true
  validates :auth_code, presence: true
end
