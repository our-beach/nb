# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthCode, type: :model do
  describe 'attributes' do
    subject { described_class.new }

    it { is_expected.to have_attribute :code }
  end
end
