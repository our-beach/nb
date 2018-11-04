class AuthorizationToken < ApplicationRecord
  belongs_to :user

  attribute :uuid
  attribute :expiration_time

  validates :uuid, :expiration_time, :user, presence: true

  def to_jwt
    { exp: expiration_time, sub: user.id, jti: uuid }
  end

  def self.find_for_jwt jwt
    find_by uuid: jwt[:jti],
      user_id: jwt[:sub],
      expiration_time: jwt[:exp]
  end
end
