class DataEncryptionKey < ApplicationRecord
  attribute :key, :string
  attribute :primary, :boolean, default: false

  validates :key, presence: true, on: :create

  def self.primary
    find_by primary: true
  end

  def is_primary?
    primary
  end

  def promote!
    return self if is_primary?

    transaction do
      prior = DataEncryptionKey.primary
      prior.update_attributes! primary: false if prior
      update_attributes! primary: true and self
    end
  end
end
