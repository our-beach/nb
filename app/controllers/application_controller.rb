# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :validate_auth_code

  def validate_auth_code
    AuthorizationTokenValidator.call auth_code
  end

  def auth_code
    @_auth_code ||= JWTService.decode request.headers["Authorization"]
  end

  def route_for resource
    "/api/v1/#{resource.class.name.underscore.dasherize.pluralize}/#{resource.id}"
  end
end
