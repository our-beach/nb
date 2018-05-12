class AuthorizationTokenValidator
  def self.call jwt
    new.call jwt
  end

  def call jwt
    valid? jwt
  end

  private

  def valid? jwt
    AuthorizationToken.find_for_jwt(jwt)&.active?
  end
end
