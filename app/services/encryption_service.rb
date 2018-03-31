class EncryptionService
  COST = Figaro.env.encryption_cost.to_i

  def self.encrypt string
    BCrypt::Password.create string, cost: COST
  end
end
