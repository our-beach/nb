class DataEncryptionKey < ApplicationRecord
  attribute :primary, :boolean, default: false
  attr_encrypted :key,
    mode: :per_attribute_iv,
    key: :key_encryption_key

  has_many :encrypted_fields

  validates :encrypted_key, presence: true, on: :create

  scope :unused, ->() do
    where(primary: false).select { |dek| dek.encrypted_fields.empty? }
  end

  def self.primary
    find_by primary: true
  end

  def self.generate! primary: false
    dek = create!(key: AESKeyService.call)
    return dek unless primary
    dek.promote!
  end

  def is_primary?
    primary
  end

  def promote!
    return self if is_primary?

    transaction do
      prior = DataEncryptionKey.primary
      prior.update_attributes! primary: false if prior
      update_attributes! primary: true
      self
    end
  end

  def key_encryption_key
    KekService.call
  end
end
