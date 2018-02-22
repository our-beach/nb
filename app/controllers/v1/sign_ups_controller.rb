# frozen_string_literal: true

class V1::SignUpsController < ApplicationController
  before_filter :validate_auth_code

  def create
    # SignUpService does:
    # 1. is phone number valid?
    # 2. can we create a signup
    # 3. can we schedule a text?
    SignUpService.create! sign_up_params
    render status: 201
  rescue SignUpService::InvalidPhoneNumber => e
    render status: 422
  end

  private

  def sign_up_params
    params.permit(:number, :auth_code)
  end

  def validate_auth_code
    AuthCodeService.valid? sign_up_params[:auth_code]
  end
end
