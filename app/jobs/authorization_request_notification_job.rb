class AuthorizationRequestNotificationJob < ApplicationJob
  queue_as :default

  def perform user_id
    phone_number = PhoneNumberDB.for_user user_id
    token = AuthorizationRequestTokenDB.create user_id
    message = Messages::AuthorizationRequest.new token

    TextMessageService.call phone_number, message
  end
end
