class ConfirmationCodeService
  TTL = Figaro.env.confirmation_code_ttl.to_i.minutes

  def self.create!
    code = Array.new(6) { rand(10) }.join
    RedisDB.insert! code, true, ttl: TTL
    code
  end

  def self.valid? code
    RedisDB.exists? code
  end
end
