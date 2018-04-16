class AuthorizationRequestTokenDB
  TTL = Figaro.env.authorization_request_token_ttl_minutes.to_i.minutes

  class << self
    def create user_id
      token = AuthorizationRequestToken.new
      RedisDB.insert! prefix(user_id), token, ttl: TTL
      token
    end

    def for_user user_id
      RedisDB.get prefix(user_id)
    end

    private

    def prefix key
      "art:#{key}"
    end
  end
end
