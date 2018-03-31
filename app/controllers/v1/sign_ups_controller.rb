# frozen_string_literal: true

class V1::SignUpsController < ApplicationController
  before_action :validate_auth_code

  def create
    # SignUpService does:
    # 1. is phone number valid?
    # 2. can we create a signup
    # 3. can we schedule a text?
    SignUpService.create! phone_number
    render status: 201
  rescue SignUpService::InvalidPhoneNumber => e
    render status: 422, json: {message: "Invalid phone number"}
  end

  def update
    render status: 201, json: {links: { user: "something" } }
  end

  private

  def phone_number
    sign_up_params[:phone_number]
  end

  def sign_up_params
    params.permit(:phone_number)
  end
end
