class AuthorizationRequestTokenDB
  TTL = Figaro.env.confirmation_code_ttl.to_i.minutes

  def self.create user_id
    token = AuthorizationRequestToken.new
    RedisDB.insert! user_id, token, ttl: TTL
    token
  end

  def self.for_user user_id
    RedisDB.get user_id
  end
end
