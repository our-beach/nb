# frozen_string_literal: true

class RedisDB
  class << self
    def redis
      @redis ||= Redis.new
    end

    def exists? key
      redis.exists key
    end

    def insert! key, value, ttl: nil, **options
      options[:ex] = ttl if ttl
      result = redis.set(key, value, **options)
      result == 'OK' || result
    end
  end
end
