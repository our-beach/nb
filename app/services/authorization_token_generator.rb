class AuthorizationTokenGenerator
  EXPIRATION_WINDOW = Figaro.env.authorization_token_expiration_window_days.to_i.days

  def self.call user
    user.authorization_token.destroy! if user.authorization_token
    AuthorizationToken.create! user: user,
      expiration_time: Time.zone.now + EXPIRATION_WINDOW,
      uuid: UUIDGenerator.call
  end
end
