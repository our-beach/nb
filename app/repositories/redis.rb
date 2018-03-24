#require "redis"
#
#class Redis
#  @redis = Redis.new
#  class << self
#    def exists? code
#      @redis.exists(code)
#    end
#
#    def insert! code, value, ttl
#      @redis.setex(code, ttl, value)
#    end
#
#    def delete code
#      @redis.del(code)
#    end
#  end
#end

