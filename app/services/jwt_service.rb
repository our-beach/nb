class JWTService
  ALGORITHM = 'HS256'
  SECRET = Figaro.env.jwt_secret

  def self.encode payload
    JWT.encode payload, SECRET, ALGORITHM
  end

  def self.decode token
    data = JWT.decode token, SECRET, true, { algorithm: ALGORITHM }
    data[0].symbolize_keys if data[1]['alg'] == 'HS256'
  end
end
