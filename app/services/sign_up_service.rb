# frozen_string_literal: true

module SignUpService
  InvalidPhoneNumber = Class.new ::StandardError

  def self.create!(phone_number)
    raise InvalidPhoneNumber unless PhoneValidator.valid? phone_number
    sign_up = SignUp.create(
      encrypted_phone_number: phone_number,
      confirmation_code: ConfirmationCodeService.create!
    )
    ConfirmationMessageJob.perform_later sign_up.id
    true
  end
end
