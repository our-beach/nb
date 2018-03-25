require 'rails_helper'

RSpec.describe SignUp, type: :model do
  describe 'attributes' do
    it { should have_readonly_attribute :encrypted_phone_number }
    it { should validate_presence_of :encrypted_phone_number }
    it { should have_readonly_attribute :confirmation_code }
    it { should validate_presence_of :confirmation_code }
  end

  describe 'creation' do
    xit 'should encrypt the phone number before inserting into database'
  end

  describe '#phone_number' do
    subject { described_class.new encrypted_phone_number: encrypted_phone_number }
    let(:phone_number) { '5555555555' }
    let(:encryped_phone_number) { encrypt phone_number }
    xit 'should decrypt the phone number'
  end
end
