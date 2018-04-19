class V1::UsersController < ApplicationController

  deserializable_resource :user

  include UsersControllerHelper
  before_action :validate_auth_code
  before_action :validate_phone_number, only: [:create]

  def create
    render jsonapi: created_user, status: :created
  end
end
