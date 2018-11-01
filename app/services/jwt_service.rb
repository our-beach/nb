class JWTService
  ALGORITHM = 'HS256'
  SECRET = Figaro.env.jwt_secret

  def self.encode payload
    JWT.encode payload, SECRET, ALGORITHM
  end

  def self.decode(token, leeway: 0.seconds)
    data, meta = JWT.decode token, SECRET, true,
      { algorithm: ALGORITHM, exp_leeway: leeway.to_i }
    data.symbolize_keys if meta['alg'] == 'HS256'
  end
end
