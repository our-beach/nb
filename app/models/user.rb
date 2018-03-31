class User < ApplicationRecord
  attribute :phone_number
  attribute :confirmation_status

  def confirmed?
    confirmation_status == 'confirmed'
  end
end
