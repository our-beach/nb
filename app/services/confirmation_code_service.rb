class ConfirmationCodeService
  TTL = Figaro.env.confirmation_code_ttl.to_i.minutes

  def self.create!
    code = 6.times.map { rand(10) }.join
    while Redis.exists? 'confirmation', code do
      code = 6.times.map { rand(10) }.join
    end

    Redis.insert! 'confirmation', code, true, ttl: TTL.minute
    code
  end

  def self.valid? code
    Redis.exists? 'confirmation', code
  end
end
