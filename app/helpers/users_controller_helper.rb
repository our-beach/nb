module UsersControllerHelper
  def user
    @user ||= UserService.create user_params[:phone_number]
  end

  def user_params
    @user_params ||= params.
      permit(data: { attributes: [:phone_number, :confirmed] }).
      dig(:data, :attributes).
      to_h.
      with_indifferent_access
  end
end
