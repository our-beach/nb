# frozen_string_literal: true

class ApplicationController < ActionController::API
  def validate_auth_code
    AuthCodeService.valid? auth_code
  end

  def auth_code
    request.headers["Authorization"]
  end

  def route_for resource
    "/api/v1/#{resource.class.name.underscore.dasherize.pluralize}/#{resource.id}"
  end
end
