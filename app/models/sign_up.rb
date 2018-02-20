class SignUp < ApplicationRecord
  attr_accessor :number
  validates :number,
    presence: true,
    format: { with: /\A\d+\z/, message: "Invalid phone number" }
end
