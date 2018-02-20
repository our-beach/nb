require 'rails_helper'

RSpec.describe SignUp, type: :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.number = '1234567890'
    expect(subject).to be_valid
  end

  it "is invalid with invalid attributes" do
    subject.number = 'qwertyuiop'
    expect(subject).to_not be_valid
  end

  it "is not valid without a number" do
    expect(subject).to_not be_valid
  end

  it "is not valid with extra parameters" do
    subject.number = '1234567890'
    subject.foo = 'bar'
    expect(subject).to_not be_valid
  end
end
