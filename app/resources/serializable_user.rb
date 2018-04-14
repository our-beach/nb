class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  attributes :confirmation_status

  link :self do
    "/api/v1/users/#{@object.id}"
  end
end
