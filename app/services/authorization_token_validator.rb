class AuthorizationTokenValidator
  attr_reader :token
  def initialize token
    @token = AuthorizationToken.from_jwt token
  end

  def self.call auth_code
    new(auth_code).call
  end

  def call
    validate
  end

  private

  def validate
    return false unless token
    token.user.present? and not token.expired?
  end
end
