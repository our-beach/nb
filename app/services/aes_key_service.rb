class AESKeyService
  def self.call size = 32
    OpenSSL::Random.random_bytes(32).unpack('H*')[0][0...size]
  end
end
