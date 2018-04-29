class V1::Users::AuthorizationTokenController < ApplicationController
  include V1::Users::AuthorizationTokensHelper

  before_action :validate_auth_code

  def show
    authorization_token = AuthorizationTokenExchangeService.call exchange_request
    render status: :no_content, headers: { 'Authorization' => "Bearer #{authorization_token}" }
  end
end
