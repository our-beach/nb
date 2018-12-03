module Authorization
  class Creator
    EXPIRATION_WINDOW = Figaro.env.authorization_token_expiration_window_days.to_i.days

    def self.call user
      new.call user
    end

    attr_reader :db
    def initialize db: AuthorizationToken
      @db = db
    end

    def call user
      user.authorization_token.destroy! if user.authorization_token
      db.create! user: user,
        expiration_time: (Time.zone.now + EXPIRATION_WINDOW).to_i,
        uuid: UUIDGenerator.call
    end
  end
end
