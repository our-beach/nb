class AuthorizationRequestTokenValidator < Service
  attr_reader :user_id, :token
  def initialize user_id, token
    @user_id = user_id
    @token = token
  end

  def call
    token == found_token
  end

  private

  def found_token
    AuthorizationRequestTokenDB.for_user user_id
  end
end
