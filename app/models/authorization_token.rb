class AuthorizationToken < ApplicationRecord
  belongs_to :user

  attribute :uuid
  attribute :expiration_time

  validates :uuid, :expiration_time, :user, presence: true

  def to_jwt
    { exp: expiration_time, sub: user.id, jti: uuid }
  end

  def self.from_jwt jwt
    find_by(uuid: jwt[:jti])
  end

end
