require 'rails_helper'

RSpec.describe SignUp, type: :model do
  it { should have_readonly_attribute :encrypted_phone_number }
  it { should validate_presence_of :encrypted_phone_number }
  it { should have_readonly_attribute :auth_code }
  it { should validate_presence_of :auth_code }
end
