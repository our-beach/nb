require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    DataEncryptionKey.generate! primary: true
  end

  after :all do
    DataEncryptionKey.primary.destroy!
  end

  describe 'attributes' do
    it { should belong_to :encrypted_phone_number }
  end

  describe 'validations' do
    it { should validate_presence_of(:phone_number).on :create }
  end

  it 'should create and destroy EncryptedFields in tandem' do
    start_count = EncryptedField.count
    @user = User.create! phone_number: '555-555-5555'
    expect(EncryptedField.count - start_count).to eq 1
    @user.destroy!
    expect(EncryptedField.count - start_count).to eq 0
  end

  describe '#phone_number=' do
    before :all do
      @user = User.create! phone_number: '555-555-5555'
      @user.phone_number = '420-420-6969'
    end

    after :all do
      @user.destroy!
    end

    it 'should update the encrypted field' do
      expect(@user.encrypted_phone_number.blob).to eq '420-420-6969'
    end
  end

  describe '#phone_number' do
    before :all do
      @user = User.create! phone_number: '555-555-5555'
    end

    after :all do
      @user.destroy!
    end

    it 'should return the set phone number' do
      expect(@user.phone_number).to eq '555-555-5555'
    end
  end
end
