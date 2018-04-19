module UsersControllerHelper

  def created_user
    @created_user ||= UserService.create phone_number
  end

  def user_params
    @user_params ||= params.
      require(:user).
      permit(:phone_number)
  end

  def phone_number
    @phone_number ||= user_params[:phone_number]
  end

  def validate_phone_number
    return if PhoneValidator.valid? phone_number
    render jsonapi_errors: [{
      title: 'Invalid phone number',
      description: "We don't recognize #{phone_number} as a phone number, friendo..."
    }], status: 422
  end
end
