class AuthorizationTokenValidator
  def self.valid? auth_code
    AuthCode.exists? code: auth_code
  end
end
