class DataEncryptionKey < ApplicationRecord
  attribute :key, :string
  attribute :primary, :boolean, default: false

  validates :key, presence: true, on: :create
  validates :primary, inclusion: [true, false]

  def self.primary
    find_by primary: true
  end

  def promote!
    transaction do
      prior = DataEncryptionKey.primary
      prior.update_attributes! primary: false if prior
      update_attributes! primary: true
    end

    self
  end
end
