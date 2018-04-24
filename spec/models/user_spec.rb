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
    expect { @user = User.create! phone_number: '555-555-5555' }
      .to change { EncryptedField.count }.by 1
    expect { @user.destroy! }
      .to change { EncryptedField.count }.by -1
  end

  describe '#phone_number=' do
    before do
      @user = User.create! phone_number: '555-555-5555'
    end

    it 'should update the encrypted field' do
      @user.phone_number = '420-420-6969'
      expect(@user.encrypted_phone_number.blob).to eq '420-420-6969'
    end
  end

  describe '#phone_number' do
    before do
      @user = User.create! phone_number: '555-555-5555'
    end

    it 'should return the set phone number' do
      expect(@user.phone_number).to eq '555-555-5555'
    end
  end
end
