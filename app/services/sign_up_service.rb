# frozen_string_literal: true

module SignUpService
  InvalidPhoneNumber = Class.new ::StandardError

  def self.create!(phone_number)
    raise InvalidPhoneNumber unless PhoneValidator.valid? phone_number
    SignUp.create(phone_number: phone_number,
                  confirmation_code: ConfirmationCodeService.create)
    true
  end
end
