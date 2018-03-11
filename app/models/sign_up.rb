# frozen_string_literal: true

class SignUp < ApplicationRecord
  attr_readonly :encrypted_phone_number
  attr_readonly :confirmation_code

  validates :encrypted_phone_number, presence: true
  validates :confirmation_code, presence: true
end
