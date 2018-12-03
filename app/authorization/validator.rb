module Authorization
  class Validator
    def self.call jwt
      new.call jwt
    end

    attr_reader :db
    def initialize db: AuthorizationToken
      @db = db
    end

    def call jwt
      valid? jwt
    end

    private

    def valid? jwt
      db.find_for_jwt(jwt)&.active?
    end
  end
end
