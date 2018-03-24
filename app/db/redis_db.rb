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
      redis.set key, value, **options
    end

    def delete key
      redis.del key
    end
  end
end
