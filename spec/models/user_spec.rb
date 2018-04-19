require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_attribute :phone_number }
  it { should have_db_column :phone_number }
end
