class ConfirmationCodeService
  TTL = Figaro.env.confirmation_code_ttl.to_i.minutes

  def self.create!
    code = generate_code
    RedisDB.insert! code, true, ttl: TTL
    code
  end

  def self.generate_code
    Array.new(6) { rand(10) }.join
  end

  def self.valid? code
    RedisDB.exists? code
  end
end
