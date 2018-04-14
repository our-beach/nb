# frozen_string_literal: true

class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  link(:self) { "/api/v1/users/#{@object.id}" }
  link(:authorizationRequests) { "/api/v1/users/#{@object.id}/authorization-requests" }
  link(:authorizationTokens) { "/api/v1/users/#{@object.id}/authorization-tokens" }
end
