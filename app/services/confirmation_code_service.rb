require "redis"

class Redis
  @redis = Redis.new
  class << self
    def exists? code
      @redis.exists(code)
    end

    def insert! code, value, ttl
      @redis.setex(code, ttl, value)
    end

    def delete code
      @redis.del(code)
    end
  end
end

class ConfirmationCodeService
  TTL = Figaro.env.confirmation_code_ttl.to_i.minutes

  def self.create!
    code = 6.times.map { rand(10) }.join
    Redis.insert! code, true, TTL
    code
  end

  def self.valid? code
    Redis.exists? code
  end
end
