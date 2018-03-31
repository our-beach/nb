class V1::UsersController < ApplicationController
  include UsersControllerHelper
  before_action :validate_auth_code

  def create
    render status: :created, json: {
      data: {
        id: user.id,
        type: 'users',
        attributes: user.attributes,
        links: { self: route_for(user) }
      }
    }
  end
end
