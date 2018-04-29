class PhoneNumberDB
  def self.for_user user_id
    User.where(id: user_id).first&.phone_number
  end
end
