class AuthorizationService
  attr_reader :decoder, :validator, :refresher, :creator
  def initialize decoder:, validator:, refresher:, creator:
    @decoder = decoder
    @validator = validator
    @refresher = refresher
    @creator = creator
  end

  def validate! tok
    parsed = decoder.decode! tok
    return parsed if validator.validate! parsed
  rescue Authorization::DecodeError => e
    raise Authorization::MalformedTokenError, e.message
  rescue Authorization::ExpiredTokenError
    refresh tok
  end

  private

  def refresh tok
    refresher.refresh! tok
  rescue Authorization::RefreshError
    raise Authorization::UnauthorizedError
  end
end
