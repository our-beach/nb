class V1::UsersController < ApplicationController
  include UsersControllerHelper
  before_action :validate_auth_code

  deserializable_resource :user, only: [:create, :update]

  def create
    render jsonapi: created_user, status: :created
  end
end
