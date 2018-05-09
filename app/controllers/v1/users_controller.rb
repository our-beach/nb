class V1::UsersController < ApplicationController
  skip_before_action :validate_auth_code, only: :create

  deserializable_resource :user

  include UsersControllerHelper
  before_action :validate_phone_number, only: [:create]

  def create
    render jsonapi: created_user, status: :created
  end
end
