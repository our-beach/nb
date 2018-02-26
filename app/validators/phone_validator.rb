# frozen_string_literal: true

class PhoneValidator
  def self.valid? phone_number
    Phony.plausible? phone_number
  end
end
