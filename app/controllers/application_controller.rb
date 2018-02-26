# frozen_string_literal: true

class ApplicationController < ActionController::API

  def validate_auth_code
    AuthCodeService.valid? auth_code
  end
  
  def auth_code
    request.headers["Authorization"]
  end
end
