class DataEncryptionKey < ApplicationRecord
  attribute :primary, :boolean, default: false
  attr_encrypted :key,
    mode: :per_attribute_iv,
    key: :key_encryption_key

  has_many :encrypted_fields

  validates :encrypted_key, :primary,
    presence: true, on: :create

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

  def key_encryption_key
    KekService.call
  end
end
