module UsersControllerHelper
  def created_user
    @created_user ||= UserService.create create_params[:phone_number]
  end

  def create_params
    @create_params ||= params.
      require(:user).
      permit(:phone_number)
  end
end
