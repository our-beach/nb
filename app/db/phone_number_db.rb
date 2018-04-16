class PhoneNumberDB
  def self.for_user user_id
    User.where(id: user_id).pluck(:phone_number).first
  end
end
