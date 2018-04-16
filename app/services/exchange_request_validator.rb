class AuthorizationRequestValidator < Service
  attr_reader :request
  def initialize request
    @request = request
  end

  def call
    request.token == found_token
  end

  private

  def found_token
    AuthorizationRequestTokenDB.for_user request.user.id
  end
end
