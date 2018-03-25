# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthCode, type: :model do
  describe 'attributes' do
    subject { described_class.attributes }

    it { is_expected.to include :code }
  end
end
