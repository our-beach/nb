class V1::SignUpsController < ApplicationController
  def create
    @sign_up = SignUp.create(sign_up_params)
    if @sign_up.valid?
      json_response({ message: "Valid phone number" }, :created)
    else
      json_response({ message: "Invalid phone number" }, :unprocessable_entity)
    end
  end

  private
  def sign_up_params
    params.permit(:number)
  end
end
