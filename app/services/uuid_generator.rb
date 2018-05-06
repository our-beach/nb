class UUIDGenerator
  def self.call
    SecureRandom.uuid
  end
end
