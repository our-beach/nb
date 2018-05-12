class AuthorizationTokenExchangeService
  InvalidRequestError = Class.new StandardError

  def self.call exchange_request
    raise InvalidRequestError unless ExchangeRequestValidator.call exchange_request
    AuthorizationRequestTokenDB.destroy exchange_request.user.id
    AuthorizationTokenGenerator.call exchange_request.user
  end
end
