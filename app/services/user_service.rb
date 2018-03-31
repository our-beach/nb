class UserService
  def self.create phone_number
    User.create phone_number: EncryptionService.encrypt(phone_number)
  end
end
