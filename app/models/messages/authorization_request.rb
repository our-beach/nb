module Messages
  class AuthorizationRequest < Message
    TTL = Figaro.env.authorization_request_token_ttl_minutes.freeze

    TEMPLATE = %Q{Your NB authorization request token is:
    %s
    It will expire in #{TTL} minutes.
    }.freeze

    def template
      TEMPLATE
    end
  end
end
